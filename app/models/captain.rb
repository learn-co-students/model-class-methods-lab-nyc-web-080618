require 'pry'
class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: :classifications).where('classifications.name' => 'Catamaran')
  end

  def self.sailors
    self.joins(boats: :classifications).where('classifications.name' => 'Sailboat').uniq
  end

  def self.motorboats
    self.joins(boats: :classifications).where('classifications.name' => "Motorboat").uniq
  end

  def self.talented_seafarers
    self.where("id IN (?)", self.sailors.pluck(:id) & self.motorboats.pluck(:id))
    #binding.pry
  end

  def self.non_sailors
    self.where.not(id:self.sailors.pluck(:id))
  end

end #END CLASS
