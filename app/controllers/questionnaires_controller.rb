class QuestionnairesController < ApplicationController
  layout "form", only: :show
  # GET /questionnaires/1
  # GET /questionnaires/1.json
  def show
    @questionnaire = Questionnaire.find_by(uid: params[:id])
    if @questionnaire.blank? || @questionnaire.status == 'completed'
      render plain: "Анкета не найдена"
    else
      render :show
    end
  end

  # POST /questionnaires
  # POST /questionnaires.json
  def create
    #здесь сохраняем анкету в БД
  end
end