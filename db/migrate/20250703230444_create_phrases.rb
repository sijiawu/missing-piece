class CreatePhrases < ActiveRecord::Migration[7.1]
  def change
    create_table :phrases do |t|
      t.references :entry, null: false, foreign_key: true
      t.string :text
      t.string :translation
      t.text :explanation
      t.text :example

      t.timestamps
    end
  end
end
