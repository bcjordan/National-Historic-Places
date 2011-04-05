class Location < ActiveRecord::Base
  belongs_to :user
  
  acts_as_mappable :default_units => :miles,
                         :default_formula => :sphere,
                         :distance_field_name => :distance,
                         :lat_column_name => :lat,
                         :lng_column_name => :lng
                         
def nearesty
  @places = Place.select do |place|
    coorDist(place.lat, place.lng, lat, lng) < 3
  end

  @places
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
