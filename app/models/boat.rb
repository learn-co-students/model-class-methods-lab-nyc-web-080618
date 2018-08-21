class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    Boat.limit(5)
  end

  def self.dinghy
    Boat.where("length < 20")
  end

  def self.ship
    Boat.where("length >= 20")
  end

  def self.last_three_alphabetically
    Boat.order('name ASC').reverse_order.limit(3)
  end

  def self.without_a_captain
    Boat.where(captain_id: nil)
  end

  def self.sailboats
    Boat.joins(:classifications).where('classifications.name = ?', "Sailboat")
  end

  def self.with_three_classifications
    Boat.joins(:boat_classifications).having("COUNT(boat_classifications.boat_id) >= 3").group("boat_classifications.boat_id")
  end

  def self.longest
    order('length DESC').first
  end
end
