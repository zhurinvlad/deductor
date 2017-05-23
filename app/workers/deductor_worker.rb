class DeductorWorker
  include Sidekiq::Worker

  def perform(resource_id)
    @questionnaire = Questionnaire.find(resource_id)
    # @questionnaire.send_to_deductor # TODO обработка ответа от deductor
    @questionnaire.update_attributes(is_analyze: true)
  end
end
