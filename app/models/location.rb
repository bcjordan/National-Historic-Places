class Location < ActiveRecord::Base
  belongs_to :user
  
  acts_as_mappable :default_units => :miles,
                         :default_formula => :sphere,
                         :distance_field_name => :distance,
                         :lat_column_name => :lat,
                         :lng_column_name => :lng
                        
def nearest3
  @places = []
  Place.all[0..50].each do |place|
    dist = coorDist(place.lat, place.lng, self[:lng].to_f, self[:lat].to_f)

        logger.debug "The object is #{place.lat}, #{place.lng}, #{self[:lat]}, #{self[:lng]}"
        logger.debug "The distance is #{dist}"

  end

  @places
end

def coorDist(lat1, long1, lat2, long2)
  #convert from degrees to radians
  a1 = lat1 * (Math::PI / 180)
  b1 = long1 * (Math::PI / 180)
  a2 = lat2 * (Math::PI / 180)
  b2 = long2 * (Math::PI / 180)

  r_e = 6378.135 #radius of the earth in kilometers (at the equator)
  #note that the earth is not a perfect sphere, r is also as small as
  r_p = 6356.75 #km at the poles

  #find the earth's radius at the average latitude between the two locations
  theta = (lat1 + lat2) / 2

  r = Math.sqrt(((r_e**2 * Math.cos(theta))**2 + (r_p**2 * Math.cos(theta))**2) / ((r_e * Math.cos(theta))**2 + (r_p * Math.cos(theta))**2))

  #do the calculation with radians as units
  d = r * Math.acos(Math.cos(a1)*Math.cos(b1)*Math.cos(a2)*Math.cos(b2) + Math.cos(a1)*Math.sin(b1)*Math.cos(a2)*Math.sin(b2) + Math.sin(a1)*Math.sin(a2));

end

 def coorDistaaa(lat1, lon1, lat2, lon2)

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
