class ElectionsController < ApplicationController
  before_action :set_election, only: %i[ results ]

  # GET /elections/new
  def new
    @election = Election.new
    @election.candidates.build
  end

  # POST /elections
  def create
    @election = Election.new(election_params)

    if @election.save
      redirect_to new_election_vote_path(@election), notice: "Election was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /elections/:uuid/results
  def results
    if @election.can_see_results?
      render :results
    else
      redirect_to new_election_vote_path(@election), alert: "The results will only be released after the closing date."
    end
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_election
    @election = Election.includes(candidates: :votes).find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def election_params
    params.expect(election: [ :title, :description, :closing_date, candidates_attributes: [ [ :name ] ] ])
  end
end
