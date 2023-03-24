class Movie < ApplicationRecord
  attr_accessor :youtube_url

  belongs_to :user
  has_many :votes

  validates_presence_of :youtube_id, :title
  validates_uniqueness_of :youtube_id
  validates_length_of :youtube_id, is: 11

  def embed_url
    "https://www.youtube.com/embed/#{youtube_id}"
  end

  def youtube_full_url
    "https://youtu.be/#{youtube_id}"
  end

  %w[voted_up voted_down].each do |vote_action|
    define_method("number_of_#{vote_action}") do
      votes.send(vote_action).count
    end
  end
end
