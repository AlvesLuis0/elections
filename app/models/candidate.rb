class Candidate < ApplicationRecord
  belongs_to :election
  has_many :votes, dependent: :destroy

  validates :name, presence: true

  def votes_count
    votes.count
  end
end
