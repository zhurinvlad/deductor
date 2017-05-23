class QuestionnairesController < ApplicationController
  layout "form", only: :show

  before_action :set_questionnaire, only: [:show, :update]

  # GET /questionnaires/1
  # GET /questionnaires/1.json
  def show
  end

  # PATCH/PUT /questionnaires/1
  # PATCH/PUT /questionnaires/1.json
  def update
    if params[:questionnare].present?
      # TODO добавить валидацию
      # && validate_questionnare!
      answers = params[:questionnare].to_xml
      @questionnaire.update_attributes(
          status: :completed,
          answer: answers
      )
      # TODO Push to Deductor
      render_to_msg('Успешно пройден')
    end
  rescue
    @questionnaire.update_attributes(status: :error)
    render_to_msg('Возникла непредвиденная ошибка, попробуйте еще раз')
  end

  private
  def set_questionnaire
    @questionnaire = Questionnaire.find_by(uid: params[:id])
    if @questionnaire.blank?
      render_to_msg('Анкеты не найдено')
    elsif @questionnaire.completed?
      render_to_msg('Данная анкета уже заполнена')
    end
  end

  def render_to_msg(message)
    render :msg, message: message
  end
end