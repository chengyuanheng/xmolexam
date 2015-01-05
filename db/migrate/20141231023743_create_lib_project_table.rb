class CreateLibProjectTable < ActiveRecord::Migration
  def change
    create_table :lib_projects do |t|
      t.string :name

      t.timestamps
    end
  end
end
