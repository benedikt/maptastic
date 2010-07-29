module Maptastic

  class Railtie < Rails::Railtie # :nodoc:
    config.maptastic = Maptastic

    initializer "maptastic.action_view" do |app|
      if defined? ::ActionView
        require 'maptastic/view_helpers/action_view'
        ActionView::Base.send(:include, Maptastic::ViewHelpers::ActionView)
      end
    end

  end

end
