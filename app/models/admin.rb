class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :doorkeeper

  enum status: {active:0, inactive:1}
  enum role: {admin:0, employee:1}
end
