class Movie < ApplicationRecord
  attr_accessor :youtube_url

  belongs_to :user

  validates_presence_of :youtube_id, :title
  validates_uniqueness_of :youtube_id
  validates_length_of :youtube_id, is: 11
end
