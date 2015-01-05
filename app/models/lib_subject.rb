# encoding: utf-8
class LibSubject < ActiveRecord::Base
  attr_accessible :id, :project_id, :name

  has_one :lib_project

  def self.fetch_name id
    find(id).name
  end

end