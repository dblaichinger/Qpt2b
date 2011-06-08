# == Schema Information
# Schema version: 20110419083731
#
# Table name: users
#
#  id                   :integer(4)      not null, primary key
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  password_salt        :string(255)     default(""), not null
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer(4)      default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  name                 :string(255)
#  street               :string(255)
#  city                 :string(255)
#  token                :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable #, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :street, :city, :token

  ##has_many :orders, :dependent => :destroy
  
  has_many :orders
  accepts_nested_attributes_for :orders

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  #validates :email, :presence   => true,
  #  :format     => { :with => email_regex },
  #  :uniqueness => { :case_sensitive => false }

  #validates :name, :presence => true, :length => {:within => 3..100}
  #validates :street, :presence => true
  #validates :city, :presence => true

end