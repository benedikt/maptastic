module Maptastic
  
  mattr_accessor :api_key
  @@api_key = ""
  
  mattr_accessor :longitude_attribute
  @@longitude_attribute = :longitude
  
  mattr_accessor :latitude_attribute
  @@latitude_attribute = :latitude

  mattr_accessor :sensor
  @@sensor = nil
  
  mattr_accessor :locale
  @@locale = nil
  
  mattr_accessor :default_zoom_level
  @@default_zoom_level = 10

  def self.configure
    yield self
  end
  
end

require 'maptastic/railtie'
