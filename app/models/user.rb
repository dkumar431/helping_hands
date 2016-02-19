class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role
  has_many :patients

  has_many :relationships, class_name: 'Relationship', foreign_key:'manager_id'
  has_many :agents, through: :relationships

  has_one :reverse_relationship, class_name: 'Relationship',foreign_key: 'agent_id'
  has_one :manager, through: :reverse_relationship

  delegate :role_name, to: :role
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # validate :validate_user_login, if: :user_sign_in?
  attr_accessor :sign_in

    validates   :name,
                :presence => {:message => "Name cann't be blank."} ,
                :length => { :minimum => 10,:message => "Name must be at least 10 character long."}


    validates   :email,
                :presence => true,
                :format => {:with =>  email_regex},
                :uniqueness => {:case_sensitive => false}

    validates   :password,
                :presence => true,
                :length => {:within => 6..10},
                :confirmation => true
    validates   :phone,
                :presence => true



  def is?(role_type)
    self.role_name == role_type.to_s
  end

  def authenticate(email, password)
 #   user.valid?
  end

  def user_sign_in?
    self.sign_in? == true
  end

  def validate_user_login
    user = User.find_by_email(self.email)
    user.errors.add(:base, 'User not found') and return false if user.nil?
    user.errors.add(:base, 'Invalid password entered') and return false unless user.valid_password?(self.password)
  end

  def get_patients
    self.patients
  end

end
