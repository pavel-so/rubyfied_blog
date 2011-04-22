# == Schema Information
# Schema version: 20110329124738
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  author_id  :integer
#  title      :string(255)
#  message    :text
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user,:foreign_key => :author_id
  validates :message,
            :presence=>true,
            :length=>{:minimum=>10}
end

