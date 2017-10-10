class Year < ActiveRecord::Base
  validates :year, presence: true
  has_many :albums
end
