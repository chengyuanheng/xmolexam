#encoding=UTF-8
module CurrentUserHelper

  def current_user
    session[:user_id].present? ? User.find(session[:user_id]) : nil
  end

  def current_user_id
    session[:user_id] || nil
  end

  def no_user_authenticate
    redirect_to '/login' if current_user.blank?
  end

  def user_authenticate
    redirect_to '/question_manage/user_manage' if current_user.present? && current_user.is_admin
    redirect_to '/question_manage/question_manage' if current_user.present? && !current_user.is_admin
  end

end