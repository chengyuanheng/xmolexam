class CreateExamDateTable < ActiveRecord::Migration
  def change
    create_table :exam_dates do |t|
      t.integer :year
      t.integer :month

      t.timestamps
    end
  end
end
