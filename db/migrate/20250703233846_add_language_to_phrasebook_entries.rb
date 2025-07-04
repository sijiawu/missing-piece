class AddLanguageToPhrasebookEntries < ActiveRecord::Migration[7.1]
  def change
    add_column :phrasebook_entries, :language, :string
  end
end
