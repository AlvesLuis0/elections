class Election < ApplicationRecord
  has_many :candidates, -> { order :name }, dependent: :destroy
  accepts_nested_attributes_for :candidates

  validates :title, presence: true
  validate :must_have_at_least_two_candidates

private
  def must_have_at_least_two_candidates
    if candidates.size < 2
      errors.add(:candidates, "must have at least two associated")
    end
  end
end
