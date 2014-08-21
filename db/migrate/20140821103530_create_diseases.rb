class CreateDiseases < ActiveRecord::Migration
  def change
    create_table :diseases do |t|
      t.string :code
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
