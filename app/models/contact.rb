class Contact < ApplicationRecord
  belongs_to :user
  validates :first_name, presence: true
  validates :phone, presence: true

  include PgSearch
  pg_search_scope :search, against: [:first_name, :last_name, :phone]
end
