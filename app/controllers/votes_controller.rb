class VotesController < ApplicationController
  # POST /votes
  def create
    @vote = Vote.new(vote_params)

    if @vote.save
      redirect_to root_path, notice: "Vote was successfully registered."
    else
      redirect_to root_path, alert: "Unable to register vote."
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def vote_params
      params.expect(vote: [ :candidate_id ])
    end
end
