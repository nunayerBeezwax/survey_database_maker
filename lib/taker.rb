require 'active_record'

class Taker < ActiveRecord::Base
  has_many :choices, { :through => :responses }
  has_many :responses
  validates :name, { :uniqueness => true }
end
