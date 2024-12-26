class VotesController < ApplicationController
  # GET /:uuid
  def new
    @election = Election.includes(:candidates).find(params.expect(:election_id))
    redirect_if_closed(@election)
    @vote = Vote.new
  end

  # POST /votes
  def create
    @election = Election.find(params.expect(:election_id))
    redirect_if_closed(@election)
    @vote = Vote.new(vote_params)

    if @vote.save
      redirect_to new_election_vote_path(@election), notice: "Vote was successfully registered."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  # Only allow a list of trusted parameters through.
  def vote_params
    params.expect(vote: [ :candidate_id ])
  end

  def redirect_if_closed(election)
    if election.closed?
      redirect_to results_elections_path(election), alert: "This election is closed."
    end
  end
end
