require 'maptastic/railtie'

module Maptastic

  ##
  # :singleton-method: api_key
  # Stores the application's Google Maps API key.
  mattr_accessor :api_key
  @@api_key = ""

  ##
  # :singleton-method: longitude_attribute
  # Gets the attribute name used to get the longitude of an object
  mattr_accessor :longitude_attribute
  @@longitude_attribute = :longitude

  ##
  # :singleton-method: latitude_attribute
  # Gets the attribute name used to get the latitude of an object
  mattr_accessor :latitude_attribute
  @@latitude_attribute = :latitude

  ##
  # :singleton-method: locale
  # Gets the override locale used to load the Google Maps API
  mattr_accessor :locale
  @@locale = nil

  ##
  # :singleton-method: region
  # Gets the defined region
  mattr_accessor :region
  @@region = nil


  ##
  # :singleton-method: default_zoom_level
  # Gets the default zoom level for maps
  mattr_accessor :default_zoom_level
  @@default_zoom_level = 10

  ##
  # :singleton-method: sensor
  # Gets the sensor option (load the api with gps device support)
  # Default: nil
  mattr_accessor :sensor
  @@sensor = nil

  ##
  # Configure maptastic
  #
  # Example:
  #
  #   Maptastic.configure do |config|
  #     config.locale = :de
  #   end
  def self.configure
    yield self
  end

end
