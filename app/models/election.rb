class Election < ApplicationRecord
  has_many :candidates, -> { order :name }, dependent: :destroy
  has_many :votes, through: :candidates
  accepts_nested_attributes_for :candidates

  validates :title, presence: true
  validates :closing_date, comparison: { greater_than_or_equal_to: Date.today, message: "must be today or in the future" }, if: -> { closing_date.present? }
  validate :must_have_at_least_two_candidates
  validate :must_have_unique_candidates

  def results
    candidates.joins(:votes).group("candidates.name").count
  end

  def closed?
    closing_date.present? && closing_date.past?
  end

private
  def must_have_at_least_two_candidates
    if candidates.length < 2
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
