class Election < ApplicationRecord
  has_many :candidates, -> { order :name }, dependent: :destroy
  accepts_nested_attributes_for :candidates

  validates :title, presence: true
  validate :must_have_at_least_two_candidates
  validate :must_have_unique_candidates

  def votes_count
    Vote.joins(:candidate).where(candidate: { election_id: id }).count
  end

private
  def must_have_at_least_two_candidates
    if candidates.size < 2
      errors.add(:candidates, "must have at least two associated")
    end
  end

  def must_have_unique_candidates
    candidate_names = candidates.map { |candidate| candidate.name.downcase }
    candidate_names = candidate_names.filter { |name| name.present? }
    duplicated_names = candidate_names.select { |name| candidate_names.count(name) > 1 }
    if duplicated_names.any?
      errors.add(:candidates, "must be unique within the same election")
    end
  end
end
