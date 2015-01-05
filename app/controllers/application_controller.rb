# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery :with=> :exception
  layout 'application'
  include CurrentUserHelper
end
