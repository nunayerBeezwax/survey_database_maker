require 'active_record'

class Response < ActiveRecord::Base
  belongs_to :choice
  belongs_to :taker

end
