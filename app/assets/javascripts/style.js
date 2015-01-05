$(function(){
    var url = window.location.pathname;
    if (url=="/homes/start_exam")
        url = "/";
    id = url.replace(/\//g, '_');
    $("#"+id).attr("class","active");
});