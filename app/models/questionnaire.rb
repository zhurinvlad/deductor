class Questionnaire < ApplicationRecord
  # gray, yellow, green, red
  enum status: [:ready, :warn, :completed, :error]
  before_create :randomize_id

  private

  def randomize_id
    begin
      self.uid = SecureRandom.hex(15)
    end while Questionnaire.where(id: self.uid).exists?
  end

  def validate_questionnare!()

  end
end
