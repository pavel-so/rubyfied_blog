require 'spec_helper'

describe Post do
  it { should have_many(:comments) }
  it { should belong_to(:user) }
  describe "some actions to perform(TBD:add more actions)"  do
    before{
      Post.delete_all
      @user=Factory(:user,:username=>"User")

    }
    it 'should create an instance with given attributes' do
      Post.create!(:message=>"Some",:user=>@user)
    end
    it 'should validate message presence' do
      post_without_message=Post.new(:message=>nil)
      post_without_message.should_not be_valid
    end
  end
end

