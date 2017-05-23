class QuestionnairesController < ApplicationController
  layout "form", only: :show

  before_action :set_questionnaire, only: [:show, :update]

  # GET /questionnaires/1
  # GET /questionnaires/1.json
  def show
    @questionnaire.update_attributes(status: :warn)
  end

  # PATCH/PUT /questionnaires/1
  # PATCH/PUT /questionnaires/1.json
  def update
    @questionnaire.update_attributes(
        status: :completed,
        answer: questionnaire_params.to_xml
    )
    render_to_msg('Успешно пройден')
  rescue => e
    logger.info("ОШИБКА: #{e}")
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
    render :msg, :locals => { message: message }
  end

  def questionnaire_params
    params[:questionnare][:q1_problems] ||= nil
    params[:questionnare][:q2_worths] ||= nil
    params[:questionnare][:q4_funs] ||= nil

    permitted = params.require(:questionnare).permit(
        {q1_problems: []}, 
        {q2_worths: []},
        :q3_free_time,
        {q4_funs: []},
        :q5_phys_health,
        :q6_moral_health,
        :q7_bad,
        :age,
        :education,
        :family,
        :sex,
        :social,
        :social_other
      )
      if  ( permitted[:q1_problems].size != 5 ) || 
          ( permitted[:q2_worths].size < 1 ||  permitted[:q2_worths].size > 5 ) ||
          ( permitted[:q4_funs].size < 1 ||  permitted[:q4_funs].size > 3 )
        raise
      else
        permitted
      end
  end
end