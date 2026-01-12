class Slab < ApplicationRecord
  belongs_to :grading_company
  has_many :verifications

  # convenience
  def verified?
    verified
  end
end
