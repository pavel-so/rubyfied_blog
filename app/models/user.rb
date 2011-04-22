# == Schema Information
# Schema version: 20110329124738
#
# Table name: users
#
#  id              :integer         not null, primary key
#  username        :string(255)
#  email           :string(255)
#  password_hash   :string(255)
#  active          :boolean
#  activation_code :string(255)
#  reset_code      :string(255)
#  banned          :boolean
#  role_id         :integer
#  created_at      :datetime
#  updated_at      :datetime
#

require 'digest/md5'
class User < ActiveRecord::Base
  belongs_to :role
  validates :username,
            :presence => true,
            :uniqueness=>true
  validates :email,
            :presence => true,
            :uniqueness=>true,
            :format=>{:with=>/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
  validates :password,
            :on => :create,
            :presence => true,
            :confirmation=>true,
            :length => {:minimum => 6}

  attr_accessor :password, :password_confirmation



  before_save :hash_password
  after_create :notify_activation

  def initialize(args={})
    super(args)
    self.activation_code=Digest::MD5.hexdigest(DateTime.now.hash.to_s+rand(10000000).to_s)
  end

  def activate
    self.active =true
    self.activation_code=""
  end



  def send_reset_code
    begin
      self.reset_code= Digest::MD5.hexdigest(DateTime.now.hash.to_s+rand(10000000).to_s)
      self.save
      Notification.reset_email(self).deliver
    rescue Exception=>e
      return false
    end

  end

  def self.find_by_credentials(email, password)
    password_hash= Digest::MD5.hexdigest(password)
    User.where("email=? and password_hash=?", email, password_hash).first
  end

  def notify_activation
    Notification.activation_email(self).deliver
  end

  private
  def hash_password
    self.password_hash=Digest::MD5.hexdigest(password)    if password and password.length > 0
  end
end

