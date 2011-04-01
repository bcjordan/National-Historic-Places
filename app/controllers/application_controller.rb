class ApplicationController < ActionController::Base
  protect_from_forgery

  geocode_ip_address 
  
  def geokit 
    @location = session[:geo_location]  # @location is a GeoLoc instance. 
  end
end
