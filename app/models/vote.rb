class Vote < ApplicationRecord
  belongs_to :candidate

  def self.count(resource)
    if resource.is_a?(Candidate)
      return where(candidate_id: resource.id).count
    end
    joins(candidate: :election).where(election: { id: resource.id }).count
  end
end
