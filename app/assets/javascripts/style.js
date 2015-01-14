$(function(){
    var url = window.location.pathname;
    if (url=="/homes/start_exam")
        url = "/";
    if (url=="/homes/question_detail")
        url = "/homes/test_report";
    id = url.replace(/\//g, '_');
    $("#"+id).attr("class","active");
});