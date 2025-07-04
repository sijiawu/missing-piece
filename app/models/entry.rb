class Entry < ApplicationRecord
  belongs_to :user
  has_many :phrases, dependent: :destroy
end
