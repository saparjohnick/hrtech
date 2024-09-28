class User < ApplicationRecord
  extend Enumerize

  has_and_belongs_to_many :skills
  has_and_belongs_to_many :interests

  enumerize :gender, in: [:male, :female], predicates: true, scope: true

  validates :email, presence: true, uniqueness: true
  validates :name, :surname, :patronymic, :age, :nationality, :country, :gender, presence: true

  accepts_nested_attributes_for :interests, allow_destroy: true
  accepts_nested_attributes_for :skills, allow_destroy: true
end
