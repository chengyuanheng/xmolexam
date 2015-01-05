class SessionsController < ApplicationController
  layout 'login_application'

  def login
    redirect_to "/question_manage/user_manage" if current_user.present?
  end

  def create
    user = User.find_by_email_and_password(params[:email], params[:password])

    if user.present?
      session[:user_id] = user.id
      redirect_to "/question_manage/user_manage"
    else
      redirect_to "/login"
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to "/login"
  end
end