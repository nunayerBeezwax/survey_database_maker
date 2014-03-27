require 'active_record'

class Choice < ActiveRecord::Base
  belongs_to :question
  has_and_belongs_to_many :responses

end
