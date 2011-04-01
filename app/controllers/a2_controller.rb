class A2Controller < ApplicationController  
  def map
    @place = session[:geo_location]
    @user_lat = -74.2239989859999
    @user_lng = 40.4198225810001
  end
end
