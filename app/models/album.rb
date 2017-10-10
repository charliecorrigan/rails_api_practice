class Album < ActiveRecord::Base
  validates :name, :artist, :genre, :year, presence: true
  belongs_to :artist
  belongs_to :genre
  belongs_to :year
end
