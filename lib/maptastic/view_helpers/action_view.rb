module Maptastic
  module ViewHelpers
    module ActionView
      
      def maptastic(*args, &block)
        options = args.extract_options!
        
        markers = (args.first.kind_of? Enumerable) ? args.first : [args.first]
        
        options["data-map"]           = true
        options["data-map-zoom"]      = options.delete(:zoom) || Maptastic.default_zoom_level
        options["data-map-controls"]  = options.delete(:controls)
        options["data-map-center"]    = coordinates_for(options.delete(:center) || markers.first)
        
        content_tag(:div, marker_html_for(markers, &block), options)
      end
      
      def maptastic_provider_tag
        provider_url  = returning("http://maps.google.com/maps?file=api&v=2") do |u|
          u << "&key=" + Maptastic.api_key
          u << "&sensor=" + (Maptastic.sensor ? "true" : "false") unless Maptastic.sensor.nil?
          u << "&hl=" + (Maptastic.locale || I18n.locale).to_s if Maptastic.locale || I18n.locale
        end
        javascript_include_tag provider_url
      end
      
      private
      
      def coordinates_for(point)
        if point.respond_to?(Maptastic.latitude_attribute) && point.respond_to?(Maptastic.longitude_attribute)
          lat, lng = point.send(Maptastic.latitude_attribute), point.send(Maptastic.longitude_attribute)
        elsif point.kind_of?(Array) && point.size >= 2
          lat, lng = point[0], point[1]
        else
          return nil
        end
        return "#{lat} #{lng}"
      end
      
      def marker_html_for(markers, &block)
        html = "".html_safe
        markers.each do |marker|
          options = {
            "data-map-marker" => true,
            "data-map-position" => coordinates_for(marker)
          }
          html << content_tag(:div, (block_given? ? capture(marker, &block) : ""), options)
        end
        html
      end
      
    end
  end
end