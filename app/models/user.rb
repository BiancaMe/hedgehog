class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :transactions, class_name: 'Entity', foreign_key: :transaction_id
  has_many :categories, class_name: 'Group', foreign_key: :category_id

  validates :name, presence: true
end
