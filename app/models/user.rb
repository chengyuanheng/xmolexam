# encoding: utf-8
class User < ActiveRecord::Base
  attr_accessible :id, :name, :email, :password, :is_admin
  validates_uniqueness_of :email,:message=>'此邮箱已存在'
  validates_presence_of :name, :email, :password


  def self.add params
    create(:name=>params[:name], :email=>params[:email], :password=>params[:password])
  end

  def self.delete params
    find(params[:user_id]).destroy
  end

  def self.update params
    find(params[:user_id]).update_attributes(:name=>params[:name],:email=>params[:email],:password=>params[:password])
  end

end
