class Item < ApplicationRecord
  before_destroy :not_referenced_by_any_line_item
    mount_uploader :image, ImageUploader
    serialize :image, JSON
    belongs_to :user, optional: true
    has_many :line_items

    validates :title, :brand, :price, :model, presence: true
    validates :description, length: { maximum: 1000, too_long: "%{count} character is the maximum allowed."}
    validates :title, length: { maximum: 140, too_long: "%{count} character is the maximum allowed."}
    validates :price, length: {maximum: 7}


  BRAND = %w{ Apple Samsung Xiomi }
  CONDITION = %w{ New Excellent Used  }

  private

  def not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, "Line items present")
      throw :abort
    end
  end

end
