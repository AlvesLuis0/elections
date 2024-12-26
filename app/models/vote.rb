class Vote < ApplicationRecord
  belongs_to :candidate
  has_one :election, through: :candidate

  validate :must_have_open_election

private
  def must_have_open_election
    if election.closed?
      errors.add(:election, "must be open")
    end
  end
end
