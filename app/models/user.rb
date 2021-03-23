class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :comments
  has_many :orders
       
  validates :nickname,  presence: true
  validates :lastname,  presence: true, format: {with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :firstname, presence: true, format: {with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :lastkana,  presence: true, format: {with: /\A[ァ-ヶー－]+\z/ }
  validates :firstkana, presence: true, format: {with: /\A[ァ-ヶー－]+\z/ }
  validates :birthday,  presence: true
end
