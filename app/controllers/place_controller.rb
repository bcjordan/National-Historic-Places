class PlaceController < ApplicationController
  respond_to :json
  
  def nearest
    @places = Place.all
    render :json => @places[0...5]
  end
end
