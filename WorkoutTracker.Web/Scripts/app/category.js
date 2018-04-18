$(function () {
    $("#search").keyup(function () {
        filterCategories();
    });
}
);

function filterCategories() {
    var title = $('#search').val();

    $.get('./Category/CategoryFilter?title=' + title, function (resp) {
        $('#categories').html(resp);
    });
}

function editCategory(categoryId) {
    var btnEdit = $('#btnEdit_' + categoryId);
    var spnTitle = $('#spnTitle_' + categoryId);

    if (btnEdit.html() == 'Edit') {
        btnEdit.html('Update');
        btnEdit.removeClass('btn-warning');
        btnEdit.addClass('btn-default');
        spnTitle.attr('contenteditable', true);
        spnTitle.focus();
    } else {
        btnEdit.html('Edit');
        btnEdit.removeClass('btn-default');
        btnEdit.addClass('btn-warning');
        spnTitle.removeAttr('contenteditable');

        var request = { CategoryId: categoryId, Title: spnTitle.html() };
        $.post('./Category/UpdateCategory', request, function (resp) {
            $('#categories').html(resp);
        });
    }
}

function deleteCategory(categoryId) {
    $.get('./Category/DeleteCategory?id=' + categoryId, function (resp) {
        $('#categories').html(resp);
    });
}