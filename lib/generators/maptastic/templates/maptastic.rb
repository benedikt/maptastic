Maptastic.configure do |config|
  # Set this to your Google Maps API Key
  config.api_key = "PUT YOUR API KEY HERE"

  # Attribute to use to get the longitude of an object
  # Default: :longitude
  # config.longitude_attribute = :lng

  # Attribute to use to get the latitude of an object
  # Default :latitude
  # config.latitude_attribute = :lat

  # Overrides the locale used to load the Google Maps API
  # Default: Whatever defined as the current I18n.locale
  # config.locale = :en

  # Sets the default region behavior
  # Default: Autodetected by Google Maps
  # config.region = 'GB'

  # Sets the default zoom level for maps
  # Default: 10
  # config.default_zoom_level = 10

  # Load the API with sensor (gps device) support
  # Default: nil
  # config.sensor = false
end

