require 'valid_email'

class Student < ApplicationRecord
  has_many :languages_students
  has_many :languages, through: :languages_students
  has_one :mentor
  delegate :resources, to: :mentor

  has_secure_password

  validates :username, presence: { message: 'Username cannot be blank.' }
  validates :username, uniqueness: { message: 'This username is already taken.' }
  validates :username, length: { minimum: 8, message: 'Username must be at least 8 characters.' }
  validates :first_name, presence: { message: 'First name cannot be blank.' }
  validates :last_name, presence: { message: 'Last name cannot be blank.' }
  validates :email, presence: { message: 'Email cannot be blank.' }
  validates :email, uniqueness: { message: 'There is already an account associated with this email address.' }
  validates :email, email: { message: 'This is not a valid email address.' }
#  validates :github_link, presence: { message: 'Github link cannot be blank.' }
  validates :github_link, uniqueness: { message: 'There is already an account associated with this Github link.' }
  validates :password, presence: { message: 'Password cannot be blank.' }, :if => :password
  validates :password, length: {minimum: 8, message: 'Password must be at least 8 characters.' }, :if => :password
end
