class Step < ApplicationRecord
  belongs_to :recipe

  validates :description, presence: true
  validates :position, presence: true, uniqueness: {case_sensitive: false, scope: :recipe_id }
end
