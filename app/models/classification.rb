require "pry"
class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    Classification
  end

  def self.longest

    includes(:boats).where("boats.length= ?",Boat.maximum(:length))

  end
end
