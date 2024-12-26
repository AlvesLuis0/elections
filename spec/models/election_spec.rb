require 'rails_helper'

RSpec.describe Election, type: :model do
  let(:valid_attributes) { { title: 'Test Election', closing_date: Date.tomorrow } }
  let(:candidate1) { Candidate.new(name: 'Candidate 1') }
  let(:candidate2) { Candidate.new(name: 'Candidate 2') }

  context 'validations' do
    it 'is valid with valid attributes' do
      election = Election.new(valid_attributes.merge(candidates: [ candidate1, candidate2 ]))
      expect(election).to be_valid
    end

    it 'is invalid without a title' do
      election = Election.new(valid_attributes.merge(title: nil, candidates: [ candidate1, candidate2 ]))
      expect(election).not_to be_valid
    end

    it 'is invalid with a past closing date' do
      election = Election.new(valid_attributes.merge(closing_date: Date.yesterday, candidates: [ candidate1, candidate2 ]))
      expect(election).not_to be_valid
    end

    it 'is invalid with less than two candidates' do
      election = Election.new(valid_attributes.merge(candidates: [ candidate1 ]))
      expect(election).not_to be_valid
    end

    it 'is invalid with duplicate candidate names' do
      duplicate_candidate = Candidate.new(name: 'Candidate 1')
      election = Election.new(valid_attributes.merge(candidates: [ candidate1, duplicate_candidate ]))
      expect(election).not_to be_valid
    end
  end

  context 'methods' do
    it 'returns results' do
      election = Election.create!(valid_attributes.merge(candidates: [ candidate1, candidate2 ]))
      candidate1.votes.create!
      candidate2.votes.create!
      candidate2.votes.create!
      expect(election.results).to eq({ 'Candidate 1' => 1, 'Candidate 2' => 2 })
    end

    it 'returns true if voting is allowed' do
      election = Election.new(valid_attributes.merge(closing_date: Date.tomorrow, candidates: [ candidate1, candidate2 ]))
      expect(election.can_vote?).to be true
    end

    it 'returns false if voting is not allowed' do
      election = Election.new(valid_attributes.merge(closing_date: Date.yesterday, candidates: [ candidate1, candidate2 ]))
      expect(election.can_vote?).to be false
    end

    it 'returns true if results can be seen' do
      election = Election.new(valid_attributes.merge(closing_date: Date.yesterday, candidates: [ candidate1, candidate2 ]))
      expect(election.can_see_results?).to be true
    end

    it 'returns false if results cannot be seen' do
      election = Election.new(valid_attributes.merge(closing_date: Date.tomorrow, candidates: [ candidate1, candidate2 ]))
      expect(election.can_see_results?).to be false
    end
  end
end
