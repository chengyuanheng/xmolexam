# encoding: utf-8
class LibProject < ActiveRecord::Base
  attr_accessible :id, :name

  has_many :lib_subjects, :foreign_key => :project_id, :dependent => :destroy

  def self.fetch_name id
    find(id).name
  end
end