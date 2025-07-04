class PhrasebookEntry < ApplicationRecord
  belongs_to :user
  belongs_to :phrase
  
  validates :language, presence: true, inclusion: { in: %w[French Spanish Polish] }
end
