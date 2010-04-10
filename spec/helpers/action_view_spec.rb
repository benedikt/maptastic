require 'spec_helper'
require 'maptastic/view_helpers/action_view'

describe Maptastic::ViewHelpers::ActionView do
  
  context "#maptastic_provider_tag" do
    it "should exist" do
      helper.should respond_to :maptastic_provider_tag
    end

    it "should include the API key in the Url" do
      Maptastic.api_key = "SOME_RANDOM_API_KEY"
      helper.maptastic_provider_tag.should match /key=SOME_RANDOM_API_KEY/
    end
  end
  

  
end