# encoding: utf-8

user = User.find_by(:email=>"237178842@qq.com")
User.create(:name=>"cckkll", :email=>"237178842@qq.com", :password=>"12345678") unless user.present?

lib_project = LibProject.find_by(:name=>"sat")
unless lib_project.present?
  project = LibProject.create(:name=>"sat")
  ["语法","阅读"].each do |name|
    LibSubject.create(:project_id=>project.id,:name=>name)
  end
end

["2006-1","2006-5","2006-6","2006-11","2006-12","2007-1","2007-5","2007-6",
"2007-11","2007-12","2008-1","2008-5","2008-6","2008-11","2008-12","2009-1",
 "2009-5","2009-6","2009-11","2009-12","2010-1","2010-5","2010-6","2010-11",
 "2010-12","2011-1","2011-5","2011-6","2011-11","2011-12","2012-1","2012-5",
 "2012-6","2012-11","2012-12","2013-1","2013-5","2013-6","2013-11","2013-12",
 "2014-1","2014-5","2014-6","2014-11","2014-12"].each do |date|
  exam_date = ExamDate.find_by(:year=>date.split('-')[0], :month=>date.split('-')[1])
  unless exam_date.present?
    ExamDate.create(:year=>date.split('-')[0], :month=>date.split('-')[1])
  end
end