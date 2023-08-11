class CreateProgramms < ActiveRecord::Migration[7.0]
  def change
    create_table :programms do |t|
      t.string :name
      t.string :status
      t.references :instructor, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
