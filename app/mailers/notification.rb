class Notification < ActionMailer::Base
  default :from => "informer.email@gmail.com"

  def url
    if RAILS_ENV =='development'
      "localhost:3000"
    else
      ''
    end
  end

  def activation_email(user)
    @user=user
    @url = url
    mail(:to=>@user.email, :subject=>"Activate You account")
  end

  def activated_email(user)
    @user=user
    @url = url
    mail(:to=>@user.email, :subject=>"Welcome Aboard")
  end

  def reset_email(user)
    @user=user
    @url = url
    mail(:to=>@user.email, :subject=>"Password Reset Code")
  end

  def was_reset_email(user)
    @user=user
    @url = url
    mail(:to=>@user.email, :subject=>"Password Was Reset")
  end
end

