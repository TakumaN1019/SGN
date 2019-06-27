class Relationship < ApplicationRecord

  belongs_to :uhoer, class_name: "User"
  belongs_to :uhoing, class_name: "User"
  validates :uhoer_id, presence: true
  validates :uhoing_id, presence: true

end
