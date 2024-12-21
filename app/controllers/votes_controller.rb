class VotesController < ApplicationController
  # POST /votes
  def create
    @vote = Vote.new(vote_params)
    @election = @vote.candidate.election

    if @vote.save
      redirect_to results_elections_path(@election), notice: "Vote was successfully registered."
    else
      redirect_to @election, alert: "Unable to register vote."
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def vote_params
      params.expect(vote: [ :candidate_id ])
    end
end
