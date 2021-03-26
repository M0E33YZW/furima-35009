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
    validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }
    validates :birthday
  end
  with_options presence:true ,format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ } do
      validates :lastname
      validates :firstname
  end
  with_options presence:true ,format: { with: /\A[ァ-ヶー－]+\z/ } do
      validates :lastkana
      validates :firstkana
  end
end
