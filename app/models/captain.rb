class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: :classifications).where("classifications.name"=>"Catamaran")
  end

  def self.sailors
    self.joins(boats: :classifications).distinct.where("classifications.name"=>"Sailboat")
  end

  def self.motorboat_operators
    self.includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seafarers
  array=Captain.sailors&Captain.motorboat_operators
   self.where(id:array.map(&:id))
  end 

  def self.non_sailors
    self.where.not(id:self.sailors.pluck(:id))
  end
end
