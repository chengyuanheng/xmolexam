# encoding: utf-8
class HomesController < ApplicationController
  before_filter :user_authenticate

  def index
    @exam_dates = ExamDate.all.group_by{|x|x.year}
    project_id = LibProject.find_by(:name=>Constant::SAT_NAME).id
    @sat_subjects = LibSubject.where(:project_id=>project_id)
  end

  def test_report

  end

  def start_exam
    if params[:exam_time].blank? || params[:date].blank? || params[:subject].blank?
      flash[:tip] = "请正确设置考期，考试项目以及考试时间"
      return  redirect_to :action=>"index"
    end
    if session[:start_time].present? && session[:examer_id] != params[:examer_id].to_i
      session[:start_time] = nil
    end
    if session[:start_time].nil? && session[:examer_id] != params[:examer_id].to_i
      session[:start_time] = Time.now.to_datetime.to_i
      session[:examer_id] = params[:examer_id].to_i
    end
    @examer_id = params[:examer_id]
    @exam_time = params[:exam_time].to_i
    rest_time=params[:exam_time].to_i - (Time.now.to_datetime.to_i - session[:start_time])
    @current_time = rest_time <= 0 ? 0 : rest_time
    @start_time = session[:start_time]
    @date_ids=params[:date]
    @subject_ids=params[:subject]
    current_exam_question_id= params[:question_id]
    is_next=params[:next]
    is_prev=params[:prev]
    sql="select count(*) from sat_question_banks where exam_date_id in (#{@date_ids.join(',')}) and subject_id in (#{@subject_ids.join(',')})"
    @exam_questions_count = SatQuestionBank.count_by_sql(sql)
    if @exam_questions_count==0
      flash[:tip] = "没有选中的考题，请重新选择考题"
      return redirect_to :action=>"index"
    end
    sql = "select * from sat_question_banks where exam_date_id in (#{@date_ids.join(',')}) and subject_id in (#{@subject_ids.join(',')})"
    sql += "and id > #{current_exam_question_id} order by id asc " if current_exam_question_id.present? && is_next=="true"
    sql += "and id < #{current_exam_question_id} order by id desc " if current_exam_question_id.present? && is_prev=="true"
    sql += " limit 1"
    @current_exam_question = SatQuestionBank.find_by_sql(sql).first
    sql = "select count(*) from sat_question_banks where exam_date_id in (#{@date_ids.join(',')}) and subject_id in (#{@subject_ids.join(',')})"
    sql += " and id <= #{@current_exam_question.id}"
    @current_exam_question_index = SatQuestionBank.count_by_sql(sql)
    sql="select * from sat_question_banks where exam_date_id in (#{@date_ids.join(',')}) and subject_id in (#{@subject_ids.join(',')})"
    sql1 = sql+ " and id < #{@current_exam_question.id} limit 1"
    @is_first_question = SatQuestionBank.find_by_sql(sql1).blank?
    sql2 = sql+" and id > #{@current_exam_question.id} limit 1"
    @is_last_question = SatQuestionBank.find_by_sql(sql2).blank?
  end

  protect_from_forgery :with=> :null_session
  def check_exam_answer
    my_answer = params[:my_answer].values
    test_report = []
    my_answer.each do |answer|
      question = SatQuestionBank.find_by_id(answer["question_id"])
      answer = SatAnswerBank.find_by_id(answer["select_id"])
      test_report << {
        :question_id=>question.id,
        :question=>question.question,
        :my_answer=>answer.present? ? answer.tag : "未选择",
        :right_answer=>question.sat_answer_banks.find_by_is_right_answer(true).tag
      }
    end
    use_time = Time.now.to_datetime.to_i - params[:start_time].to_i

    render :json=>{:report=>test_report, :use_time=>use_time}
  end

  def question_detail
    @question = SatQuestionBank.find_by_id(params[:question_id])
    @my_answer = params[:my_answer]
  end
end