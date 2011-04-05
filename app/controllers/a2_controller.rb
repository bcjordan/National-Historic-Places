class A2Controller < ApplicationController  
  def map
    session[:username] = params[:username] unless session[:username]
    @user    = User.find_by_name(session[:username])
    if !@user
      redirect_to("/a2", :notice => "You must log in!")
    else
      grab_location
      @last_10 = Location.find_all_by_user_id(@user.id, :limit => 10)
      @nearest = Place.find_within(3, :origin => @location)
    end
    
    render :action => "map", :layout => false
  end
  
  private
  def grab_location
    unless (request.remote_ip == "127.0.0.1")
      @ip = request.remote_ip
    else @ip = "130.64.22.2" end
    @user_location = Geokit::Geocoders::MultiGeocoder.geocode(@ip)
    
    @location = Location.create(:user_id => @user.id, :ip => @ip, :lat => @user_location.lat, :lng => @user_location.lng)
  end
end
