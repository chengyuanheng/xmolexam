# encoding: utf-8
class QuestionManageController < ApplicationController
  before_filter :no_user_authenticate

  def user_manage
    @users = User.paginate(:page => params[:page], :per_page => 10)
  end

  def add_user
    User.add params
    flash[:tip]="用户添加成功"
    redirect_to :action=>"user_manage"
  end

  def delete_user
    User.delete params
    flash[:tip]="用户删除成功"
    redirect_to :action=>"user_manage"
  end

  def update_user
    User.update params
    flash[:tip]="用户更新成功"
    redirect_to :action=>"user_manage"
  end

  def question_manage
    @exam_date = ExamDate.all.collect{|date|[date.year.to_s+"年"+date.month.to_s+"月",date.id]}
    project_id = LibProject.find_by(:name=>Constant::SAT_NAME).id
    @subjects = LibSubject.where(:project_id=>project_id).collect{|subject|[subject.name, subject.id]}
    @subject_section = Constant::SUBJECT_SECTION
    @questions = SatQuestionBank.paginate(:page => params[:page], :per_page => 10)
  end

  def add_question
    SatQuestionBank.add_question params
    flash[:tip]="考题添加成功"
    redirect_to :action=>"question_manage"
  end

  def update_question
    SatQuestionBank.update_question params
    flash[:tip]="考题更新成功"
    redirect_to :action=>"question_manage"
  end

  def delete_question
    SatQuestionBank.delete_question params
    flash[:tip]="考题删除成功"
    redirect_to :action=>"question_manage"
  end

end