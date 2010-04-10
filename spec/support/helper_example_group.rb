require 'webrat'

module HelperExampleGroupBehaviour
  include Webrat::Matchers
  include Rspec::Matchers

  class HelperExampleController < ActionController::Base
    attr_accessor :request, :url
  end
  
  module ViewExtension
     def protect_against_forgery?; end
     def method_missing(selector, *args)
       if Rails.application.routes.named_routes.helpers.include?(selector)
         controller.__send__(selector, *args)
       else
         super
       end
     end
  end
  
  def helper
    @helper ||= returning ActionView::Base.new(ActionController::Base.view_paths, assigns, controller) do |helper_object|
      if described_class.class == Module
        helper_object.extend described_class
      end  
      helper_object.extend(ActionController::PolymorphicRoutes)
      helper_object.extend(ViewExtension)
    end
  end
  
  def assign(name, value)
    assigns[name] = value
  end
  
  def assigns
    @assigns ||= {}
  end

  def method_missing(selector, *args)
    if Rails.application.routes.named_routes.helpers.include?(selector)
      controller.__send__(selector, *args)
    else
      super
    end
  end

  Rspec.configure do |c|
    c.include self, :example_group => { :file_path => /\bspec\/helpers\// }
  end

  private
    def controller
      @controller ||= begin
                        controller = HelperExampleController.new
                        controller.request = ActionDispatch::Request.new(Rack::MockRequest.env_for("/url"))
                        controller
                      end
    end
end