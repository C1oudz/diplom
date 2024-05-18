class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :firstname, presence: true
  validates :secondname, presence: true
  validates :surname, presence: true
  validates :role, presence: true
  has_many :items
  has_many :orders
  enum role: [:loader, :manager, :admin]
  after_initialize :set_default_role, :if => :new_record? 
  has_many :baskets
  def set_default_role
    self.role ||= :manager
  end

  def full_name
    "#{secondname} #{firstname.first}.#{surname.first}."
  end
end
