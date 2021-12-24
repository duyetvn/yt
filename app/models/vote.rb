class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  enum state: { voted_up: 'voted_up', voted_down: 'voted_down' }

  validates_uniqueness_of :movie_id, scope: :user_id
  validates_presence_of :state
end
