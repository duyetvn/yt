class Movie < ApplicationRecord
  attr_accessor :youtube_url

  belongs_to :user

  validates_presence_of :youtube_id, :title
  validates_uniqueness_of :youtube_id
  validates_length_of :youtube_id, is: 11

  def embed_url
    "https://www.youtube.com/embed/#{youtube_id}"
  end

  def youtube_full_url
    "https://youtu.be/#{youtube_id}"
  end
end
