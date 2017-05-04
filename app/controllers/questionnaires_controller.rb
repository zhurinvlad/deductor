class QuestionnairesController < ApplicationController

  # GET /questionnaires/1
  # GET /questionnaires/1.json
  def show
    @questionnaire = Questionnaire.find_by(uid: params[:id])
    if @questionnaire.nil? || @questionnaire.status == 'completed'
      render :retry
    else
      render :show
    end
  end

  # POST /questionnaires
  # POST /questionnaires.json
  def create

  end
end