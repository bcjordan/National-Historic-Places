class PlaceController < ApplicationController
  respond_to :json
  
  def nearest
    @places = Place.all.select do |place|
      coorDist(place.lat, place.lng, params[:lat].to_f, params[:lng].to_f) < 3
    end
    
    render :json => @places
  end
  
  def coorDist(lat1, lon1, lat2, lon2)

      earthRadius = 6371 # Earth's radius in KM

          # convert degrees to radians
          def convDegRad(value)
            unless value.nil? or value == 0
                  value = (value/180) * Math::PI
            end
          return value
          end

      deltaLat = (lat2-lat1)
      deltaLon = (lon2-lon1)
      deltaLat = convDegRad(deltaLat)
      deltaLon = convDegRad(deltaLon)

      # Calculate square of half the chord length between latitude and longitude
      a = Math.sin(deltaLat/2) * Math.sin(deltaLat/2) +
          Math.cos((lat1/180 * Math::PI)) * Math.cos((lat2/180 * Math::PI)) *
          Math.sin(deltaLon/2) * Math.sin(deltaLon/2); 

      # Calculate the angular distance in radians
      c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))

      distance = earthRadius * c

    return distance

  end
  
  
end
