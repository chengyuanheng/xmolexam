class CreateLibSubjectTable < ActiveRecord::Migration
  def change
    create_table :lib_subjects do |t|
      t.integer :project_id
      t.string :name

      t.timestamps
    end
  end
end
