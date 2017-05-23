class AddAnswersToQuestionnaires < ActiveRecord::Migration[5.0]
  def change
    add_column :questionnaires, :answer, :string
  end
end
