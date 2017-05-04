class CreateQuestionnaires < ActiveRecord::Migration[5.0]
  def change
    create_table :questionnaires do |t|
      t.string :uid
      t.integer :status, default: 0
      t.timestamps
    end
    add_index :questionnaires, :uid, :unique => true
  end
end
