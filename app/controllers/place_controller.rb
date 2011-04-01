class PlaceController < ApplicationController
  respond_to :json
  
  def nearest
    @places = Place.find(:all, :origin =>[0,0], :within=>10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000)
    render :json => @places
  end
end
