class User < ApplicationRecord
  has_secure_password

  has_many :movies
  has_many :votes
  has_many :voting_movies, through: :votes, source: :movie

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  def state_voting_movie(movie)
    voting = votes.find_by(movie: movie)
    return unless voting

    voting.state
  end
end
