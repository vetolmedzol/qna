$(document).ready(function () {
    $('.edit-question-link').click(function (e) {
        e.preventDefault();
        $('.delete-question-link').hide();
        $(this).hide();
        $('.edit-question').show();
        $('.edit-question').find('#question_title').val('');
        $('.edit-question').find('#question_body').val('');
    });
});
