require 'rails_helper'

RSpec.describe Vote, type: :model do
  let(:election) do
    Election.create!(title: 'Test Election', closing_date: Date.tomorrow, candidates: [
      Candidate.new(name: 'Candidate 1'),
      Candidate.new(name: 'Candidate 2')
    ])
  end
  let(:vote) { Vote.new(candidate: election.candidates.first) }

  context 'validations' do
    it 'is valid with a candidate in an open election' do
      expect(vote).to be_valid
    end

    it 'is invalid with a candidate in a closed election' do
      vote.election.update(closing_date: Date.yesterday)
      expect(vote).not_to be_valid
      expect(vote.errors[:election]).to include('must be open')
    end
  end
end
