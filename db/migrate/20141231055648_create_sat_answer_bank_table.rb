class CreateSatAnswerBankTable < ActiveRecord::Migration
  def change
    create_table :sat_answer_banks do |t|
      t.integer :question_id
      t.string :tag
      t.string :answer,  :limit => 10000
      t.boolean :is_right_answer, :default=>false

      t.timestamps
    end
  end
end
