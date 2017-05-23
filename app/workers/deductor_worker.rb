class DeductorWorker
  include Sidekiq::Worker

  def perform(resource_id)
    Questionnaire.find(resource_id).update_attributes(is_analyze: true)
  end
end
