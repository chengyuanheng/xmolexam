# encoding: utf-8
Xmolexam::Application.routes.draw do
  root :to                          => "homes#index"

  get "/login"                      => "sessions#login"

  get "/logout"                     => 'sessions#logout'

  post "/sessions/create"           =>"sessions#create"

  scope '/homes' do
    get "test_report"               => "homes#test_report"
    post "start_exam"               => "homes#start_exam"
    post "check_exam_answer"        => "homes#check_exam_answer"
  end

  scope '/question_manage' do
    get "question_manage"           => "question_manage#question_manage"
    get "user_manage"               => "question_manage#user_manage"
    post "add_user"                 =>"question_manage#add_user"
    post "delete_user"              =>"question_manage#delete_user"
    post "update_user"              =>"question_manage#update_user"
    post "add_question"             =>"question_manage#add_question"
    post "update_question"          =>"question_manage#update_question"
    post "delete_question"          =>"question_manage#delete_question"
  end

  #match ':controllers(/:action(/:id))(.:format)'
end
