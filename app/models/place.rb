class Place < ActiveRecord::Base
  acts_as_mappable :auto_geocode => true
end
