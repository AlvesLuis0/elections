class Candidate < ApplicationRecord
  belongs_to :election

  validates :name, presence: true, uniqueness: { scope: :election_id, case_sensitive: false, message: "must be unique within the same election" }
end
