class Trip < ApplicationRecord
  belongs_to :user
  belongs_to :location

  has_many :contacts, through: :companions
end