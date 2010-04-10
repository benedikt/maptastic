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

    it "should include the API key in the Url" do
      Maptastic.stub(:api_key => "SOME_RANDOM_API_KEY")
      helper.maptastic_provider_tag.should match /key=SOME_RANDOM_API_KEY/
    end
    
    it "should include the sensor param when set to true" do
      Maptastic.stub(:sensor => true)
      helper.maptastic_provider_tag.should match /sensor=true/
    end
    
    it "should include the sensor param when set to false" do
      Maptastic.stub(:sensor => false)
      helper.maptastic_provider_tag.should match /sensor=false/
    end
    
    it "should not include the sensor param when not set" do
      Maptastic.stub(:sensor => nil)
      helper.maptastic_provider_tag.should_not match /sensor=(false|true)/
    end
    
    it "should use the current I18n.locale" do
      I18n.stub(:locale => :de)
      helper.maptastic_provider_tag.should match /hl=de/
    end
    
    it "should use the locale defined in the config when available" do
      I18n.stub(:locale => :en)
      Maptastic.stub(:locale => :de)
      helper.maptastic_provider_tag.should match /hl=de/
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
        
  end
  
end