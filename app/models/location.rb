class Location < ActiveRecord::Base
  attr_accessible :city, :country, :latitude, :longitude, :neighborhood, :number, :state, :street
end
