require 'spec_helper'
require 'maptastic/view_helpers/action_view'

describe Maptastic::ViewHelpers::ActionView do
  
  subject { ActionView::Base.new }
  
  it { should respond_to :maptastic }
  it { should respond_to :maptastic_provider_tag }
  
  
end