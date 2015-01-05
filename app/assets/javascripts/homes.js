function select_all(el){
    if($(el).attr("checked")=="checked"){
        $(el).parents("dd").find("input").attr("checked",true);
        $(el).parents("dd").find("label").attr("class","label-select label-primary");
    }else{
        $(el).parents("dd").find("input").attr("checked",false);
        $(el).parents("dd").find("label").attr("class","label-gray label-unselect");
    }
}

function select_current_checkbox(el){
    if($(el).attr("checked")=="checked"){
        $(el).parent().attr("class","label-select label-primary");
    }else{
        $(el).parent().attr("class","label-gray label-unselect");
        $(el).parents("dd").find("input:first").attr("checked",false);
        $(el).parents("dd").find("label:first").attr("class","label-gray label-unselect");
    }
}


function format_exam_time(exam_time) {
    var _second = parseInt(exam_time);
    var _minute = 0;
    var _hour = 0;
    if(_second >= 60) {
        _minute = parseInt(_second / 60);
        _second = parseInt(_second % 60);
        if(_minute >= 60) {
            _hour = parseInt(_minute / 60);
            _minute = parseInt(_minute % 60);
        }
    }
    return format_number(_hour)+":"+format_number(_minute)+":"+format_number(_second);
}

function format_number(number){
    if(number<10){
        number = "0"+number
    }
    return number;
}

function update_exam_time(exam_time, second){
    if(exam_time-second == 0){
        alert("考试时间到，您还要继续答题吗？");
        second += 1;
    }else if(exam_time-second > 0){
        $("#exam_time").text(format_exam_time(exam_time-second-1));
        $("#hide_exam_time").val(exam_time-second-1);
        second += 1;
    }else{
        clearInterval(1);
    }
}

function clear_my_answer_local_storage(){
    localStorage.removeItem("my_answer");
}

function clear_test_report_local_storage(){
    localStorage.removeItem("test_report");
}

function save_select_answer(question_id){
    var select_id = $("input[type='radio']:checked").val();
    if(select_id != undefined){
        var my_answer = JSON.parse(localStorage.getItem('my_answer')) || [];
        var have_answer = false;
        $(my_answer).each(function(index, el){
            if(el["question_id"]==question_id){
                have_answer=true;
                el["select_id"]= select_id;
            }
        });
        if(have_answer==false){
            my_answer.push({"question_id": question_id, "select_id": select_id})
        }
        localStorage.setItem("my_answer",JSON.stringify(my_answer));
    }
}

function post_answer_to_back(){
    var my_answer = JSON.parse(localStorage.getItem('my_answer')) || [];

    $.ajax({
        type: "post",
        url: "/homes/check_exam_answer",
        data: {my_answer: my_answer},
        success: storage_test_report
    });

    function storage_test_report(date){
        clear_test_report_local_storage();
        save_test_report(date);
        window.location.href="/homes/test_report";
    }
}

function save_test_report(reports) {
    var test_report = JSON.parse(localStorage.getItem('test_report')) || [];
    $(reports).each(function(index, el){
        test_report.push(el);
    });
    localStorage.setItem("test_report",JSON.stringify(test_report));
}
