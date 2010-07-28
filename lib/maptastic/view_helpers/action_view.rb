module Maptastic
  module ViewHelpers
    module ActionView

      ##
      # Generates a simple map.
      #
      # Available options:
      #
      # *
      #
      def maptastic(*args, &block)
        options = args.extract_options!

        markers = (args.first.respond_to? :each) ? args.first : [args.first]

        options["data-map"]                   = true
        options["data-map-zoom"]              = options.delete(:zoom) || Maptastic.default_zoom_level
        options["data-map-controls"]          = options.delete(:controls)
        options["data-map-controls-dragging"] = options.delete(:dragging)
        options["data-map-controls-zooming"]  = options.delete(:zooming)

        options["data-map-center"] = [:client, :marker].include?(options[:center]) ?
            options.delete(:center) : coordinates_for(options.delete(:center) || markers.first)


        content_tag(:div, marker_html_for(markers, &block), options)
      end

      def maptastic_provider_tag
        autoload = { :modules => [
          { :name => "maps", :version => "2.X", :language => (Maptastic.locale || I18n.locale).to_s }
        ] }
        javascript_include_tag "http://www.google.com/jsapi?autoload=#{url_encode(autoload.to_json)}&key=#{Maptastic.api_key}"
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
        return "".html_safe.tap do |html|
          markers.each do |marker|
            options = { "data-map-marker" => true, "data-map-position" => coordinates_for(marker) }
            html << content_tag(:div, (block_given? ? capture(marker, &block) : ""), options)
          end
        end
      end

    end
  end
end
