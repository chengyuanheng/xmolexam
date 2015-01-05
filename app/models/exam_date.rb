# encoding: utf-8
class ExamDate < ActiveRecord::Base
  attr_accessible :id, :year, :month

  def self.fetch_date date_id
    exam_date = find(date_id)
    exam_date.year.to_s+"年"+exam_date.month.to_s+"月"
  end
end