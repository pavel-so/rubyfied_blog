# == Schema Information
# Schema version: 20110329124738
#
# Table name: comments
#
#  id         :integer         not null, primary key
#  post_id    :integer
#  message    :text
#  author     :string(255)
#  publish    :boolean
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
  belongs_to :post
  validates :post,
            :presence=>true
  validates :message,
            :presence=>true,
            :length => {:minimum => 2}

  def publish
    self.published=true
    self.save
  end
end

