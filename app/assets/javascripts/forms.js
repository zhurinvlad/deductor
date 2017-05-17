checkboxLogic = function(limit, selector) {
    $(selector).on('change', function(evt) {
        if($(selector+":checked").length >= limit) {
            $(selector+":not(:checked)").attr("disabled", true);
        }
        else{
            $(selector+":disabled").attr("disabled", false)      
        }
    });
}

otherField = "input[name$='questionnare[social_other]']";

$(function() {
    questions.map(function(q) {
        checkboxLogic(q.max, q.selector);
    });
    validateForm(questions)
    resetOtherField(otherField);
    radioLogicWithOther();
});
var questions =[
    {
        selector: "input[name$='questionnare[q1_problems][]']",
        max: 5,
        number: 1,
        min:5,
        parent: '.question1'
    },
    {
        selector: "input[name$='questionnare[q2_worths][]']",
        max: 5,
        number: 2,
        min: 1,
        parent: '.question2'
    },
    {
        selector: "input[name$='questionnare[q4_funs][]']",
        max: 3,
        number: 4,
        min: 1,
        parent: '.question4'
    }
]
validateForm = function(questions){
    $( "#questions_form" ).submit(function( event ) {
        var is_form_invalid = false
        messages = $(".message").remove();
        questions.forEach(function(q, index, arr) {
            if($(q.selector+":checked").length > q.max || $(q.selector+":checked").length < q.min) {
                is_form_invalid = true;
                $(`<div class="message alert alert-danger"><strong>Выбрано некорректное количество элементов в вопросе №${q.number}</strong></div>`).insertAfter(".messages");
            }
        });
        if(is_form_invalid){
            event.preventDefault();
            $('html, body').animate({ scrollTop: $('.messages').offset().top }, 'slow');
        }
        else{
            $(".send_form").addClass('disabled');
        }
        return;
    });
}

radioLogicWithOther = function(){
    $("input[name$='questionnare[social]']").change(function(){
        if(this.value == "other"){
            $(otherField).show();
        }
        else{
            resetOtherField(otherField);
        }
        });
}

resetOtherField = function(field){
    $(field).val('');
    $(field).hide();
}

