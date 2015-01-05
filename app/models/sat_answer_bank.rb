# encoding: utf-8
class SatAnswerBank < ActiveRecord::Base
  attr_accessible :id, :question_id, :tag, :answer, :is_right_answer

  has_one :sat_question_bank

  def self.add_answer params, question_id
    ["A","B","C","D","E"].each do |tag|
      create(:question_id=>question_id, :tag=>tag, :answer=>params["answer_"+tag], :is_right_answer=>params[:right_answer]==tag)
    end
  end

  def self.update_answer params, question_id
    ["A","B","C","D","E"].each do |tag|
      find_by(:question_id=>question_id, :tag=>tag).update_attributes(:answer=>params["answer_"+tag], :is_right_answer=>params[:right_answer]==tag)
    end
  end
end