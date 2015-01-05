# encoding: utf-8
class SatQuestionBank < ActiveRecord::Base
  attr_accessible :id, :exam_date_id, :subject_id, :section, :question

  has_many :sat_answer_banks, :foreign_key => :question_id, :dependent => :destroy

  def self.add_question params
    question = create(:exam_date_id=>params[:exam_date_id], :subject_id=>params[:subject_id], :section=>params[:section], :question=>params[:question])

    SatAnswerBank.add_answer params, question.id
  end

  def self.update_question params
    question = find(params[:question_id])
    question.update_attributes(:exam_date_id=>params[:exam_date_id], :subject_id=>params[:subject_id], :section=>params[:section], :question=>params[:question])
    SatAnswerBank.update_answer params, question.id
  end

  def self.delete_question params
    find(params[:question_id]).destroy
  end

end