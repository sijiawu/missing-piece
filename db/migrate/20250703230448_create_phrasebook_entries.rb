class CreatePhrasebookEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :phrasebook_entries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :phrase, null: false, foreign_key: true

      t.timestamps
    end
  end
end
