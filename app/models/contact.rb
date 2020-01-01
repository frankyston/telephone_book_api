class Contact < ApplicationRecord
  belongs_to :user
  validates :first_name, presence: true
  validates :phone, presence: true
end
