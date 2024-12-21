class VotesController < ApplicationController
  before_action :set_election_and_candidates, only: [ :new, :create ]

  # GET /:uuid
  def new
    @vote = Vote.new
  end

  # POST /votes
  def create
    @vote = Vote.new(vote_params)

    if @vote.save
      redirect_to results_elections_path(@election), notice: "Vote was successfully registered."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_election_and_candidates
    @election = Election.find(params.expect(:election_id))
    @candidates = @election.candidates
  end

  # Only allow a list of trusted parameters through.
  def vote_params
    params.expect(vote: [ :candidate_id ])
  end
end
