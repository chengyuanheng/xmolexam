class CreateSatQuestionBankTable < ActiveRecord::Migration
  def change
    create_table :sat_question_banks do |t|
      t.integer :exam_date_id
      t.integer :subject_id
      t.integer :section
      t.string :question, :limit => 10000

      t.timestamps
    end
  end
end
