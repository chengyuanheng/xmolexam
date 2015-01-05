# encoding: utf-8
#bundle exec rake db:drop db:create db:migrate xmnewcrm:load db:init db:seed insert:user --trace
namespace :db do
  desc "insert test question"
  task :insert => :environment do
    insert_test_question
  end

  def insert_test_question
    10000.times.each do |index|
      p "----------------------#{index}_start---------------"
      exam_date_id= rand((1..45))
      subject_id= rand((1..2))
      section = rand((5..9))

      question = SatQuestionBank.create(:exam_date_id=>exam_date_id, :subject_id=>subject_id,:section=>section,:question=>"what is "+index.to_s+" plus "+(2*index+1).to_s+" ?")
      right_tag_index = rand((0..4))
      right_answer = 3*index+1
      ["A","B","C","D","E"].each do |tag|
        wrong_answer = rand((1..30000))
        wrong_answer = (wrong_answer==right_answer) ? right_answer+1 : wrong_answer
        SatAnswerBank.create(:question_id=>question.id, :tag=>tag, :answer=>(["A","B","C","D","E"][right_tag_index]==tag) ? right_answer : wrong_answer, :is_right_answer=>(["A","B","C","D","E"][right_tag_index]==tag) ? true : false )
      end
      p "----------------------#{index}_finish---------------"
    end
  end

end