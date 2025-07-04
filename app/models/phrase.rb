class Phrase < ApplicationRecord
  belongs_to :entry
  has_many :phrasebook_entries, dependent: :destroy
end
