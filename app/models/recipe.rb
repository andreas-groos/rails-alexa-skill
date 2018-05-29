class Recipe < ApplicationRecord
  belongs_to :user
  has_many :steps, dependent: :destroy
  has_many :ingredients, dependent: :destroy

  validates :name, presence: true, uniqueness: {scope: :user_id}

  #
  # Include a display string for the date.
  #
  def pretty_day
    self.created_at.to_date.to_s(:long)
  end

end
