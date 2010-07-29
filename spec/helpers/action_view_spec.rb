require 'spec_helper'
require 'maptastic/view_helpers/action_view'

describe Maptastic::ViewHelpers::ActionView do

  describe "#maptastic_provider_tag" do

    it "should exist" do
      helper.should respond_to :maptastic_provider_tag
    end

    it "should return a script tag" do
      helper.maptastic_provider_tag.should have_selector("script[type='text/javascript']")
    end

    it "should use Google Maps API v3" do
      helper.maptastic_provider_tag.should match /v=3/
    end

    it "should use the current I18n.locale" do
      I18n.stub(:locale => :de)
      helper.maptastic_provider_tag.should match /language=de/
    end

    it "should use the locale defined in the config when available" do
      I18n.stub(:locale => :en)
      Maptastic.stub(:locale => :de)
      helper.maptastic_provider_tag.should match /language=de/
    end

    it "should set the region when defined" do
      Maptastic.stub(:region => 'GB')
      helper.maptastic_provider_tag.should match /region=GB/
    end

    it "should use the sensor parameter if set to true" do
      Maptastic.stub(:sensor => true)
      helper.maptastic_provider_tag.should match /sensor=true/
    end

    it "should use the sensor parameter set to false if not set to true" do
      Maptastic.stub(:sensor => nil)
      helper.maptastic_provider_tag.should match /sensor=false/
    end
  end

  describe "#maptastic" do

    it "should have a data-map=true attribute" do
      helper.maptastic.should have_selector("div[data-map=true]")
    end

    it "should have a data-map-zoom attribute set to the default defined in the config" do
      Maptastic.stub(:default_zoom_level => 5)
      helper.maptastic.should have_selector("div[data-map-zoom='5']")
    end

    { :controls => "data-map-controls",
      :dragging => "data-map-controls-dragging",
      :zooming  => "data-map-controls-zooming" }.each_pair do |option, attribute|
      it "should map option #{option} to attribute #{attribute} " do
        helper.maptastic(option => true).should have_selector("div[#{attribute}=true]")
      end
    end

    it "should have a data-map-zoom attribute set to the given value" do
      helper.maptastic(:zoom => 7).should have_selector("div[data-map-zoom='7']")
    end

    it "should have data-map-controls=true if specified" do
      helper.maptastic(:controls => true).should have_selector("div[data-map-controls=true]")
    end

    it "should not have data-map-controls=true if not specified" do
      helper.maptastic.should_not have_selector("div[data-map-controls]")
    end

    it "should set data-map-center to the coordinates given as array" do
      helper.maptastic(:center => [123, 456]).should have_selector("div[data-map-center='123 456']")
    end

    it "should set data-map-center to the coordinates given as an object" do
      point = mock(:latitude => 123, :longitude => 456)
      helper.maptastic(:center => point).should have_selector("div[data-map-center='123 456']")
    end

    it "should use the attributes given in the config on an object" do
      Maptastic.stub(:latitude_attribute => :lat, :longitude_attribute => :lng)
      point = mock(:lat => 123, :lng => 456)
      helper.maptastic(:center => point).should have_selector("div[data-map-center='123 456']")
    end

    it "should not have data-map-center if not specified" do
      helper.maptastic.should_not have_selector("div[data-map-center]")
    end

    context "with markers" do

      let(:point) { mock(:latitude => 123, :longitude => 456) }
      let(:points) { [mock(:latitude => 123, :longitude => 456), mock(:latitude => 654, :longitude => 321)] }

      it "should use the given point as marker" do
        helper.maptastic(point).should have_selector("div[data-map-marker=true][data-map-position='123 456']")
      end

      it "should use the given point as center" do
        helper.maptastic(point).should have_selector("div[data-map-center='123 456']")
      end

      it "should use the first point as center" do
        helper.maptastic(points).should have_selector("div[data-map-center='123 456']")
      end

      it "should use the center option when given" do
        helper.maptastic(point, :center => [654, 321]).should have_selector("div[data-map-center='654 321']")
      end

      it "should accept :client as center option" do
        helper.maptastic(point, :center => :client).should have_selector("div[data-map-center=client]")
      end

      it "should accept :marker as center option" do
        helper.maptastic(point, :center => :marker).should have_selector("div[data-map-center=marker]")
      end

      it "should use all points in enumerable as markers" do
        output = helper.maptastic(points)
        output.should have_selector("div[data-map-marker=true][data-map-position='123 456']")
        output.should have_selector("div[data-map-marker=true][data-map-position='654 321']")
      end

      it "should render the given block for each marker" do
        output = helper.maptastic(points) do |point|
          "--#{point.latitude}-#{point.longitude}--"
        end
        output.should contain("--123-456--")
        output.should contain("--654-321--")
      end

    end

  end

end
