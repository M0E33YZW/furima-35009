class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :comments
  has_many :orders
  
  with_options presence: true do
    validates :nickname
    validates :password,  format: {with: /[a-z\d]{6,}/i}
    validates :lastname,  format: {with: /\A[ぁ-んァ-ン一-龥々ー]+\z/} 
    validates :firstname, format: {with: /\A[ぁ-んァ-ン一-龥々ー]+\z/}
    validates :lastkana,  format: {with: /\A[ァ-ヶー－]+\z/}
    validates :firstkana, format: {with: /\A[ァ-ヶー－]+\z/}
    validates :birthday
  end
end
