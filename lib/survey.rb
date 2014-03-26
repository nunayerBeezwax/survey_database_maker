require 'active_record'

class Survey < ActiveRecord::Base
  validates :name, { :presence => true, :uniqueness => true }
  before_save :capitalize

private
  def capitalize
    name.capitalize!
  end
end
