$(function () {
    $("#search").keyup(function () {
        filterCategories();
    });
}
);

function filterCategories(controllerName) {
    var title = $('#search').val();
    var route = getRoute() + 'CategoryFilter?title=' + title;
    console.log(route);
    $.get(route, function (resp) {
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

        var request = { CategoryId: categoryId, CategoryName: spnTitle.html() };
        var route = getRoute() + 'UpdateCategory';
        console.log(route);
        $.post(route, request, function (resp) {
            $('#categories').html(resp);
        });
    }
}

function deleteCategory(categoryId) {
    var route = getRoute() + 'DeleteCategory?id=' + categoryId;
    $.get(route, function (resp) {
        $('#categories').html(resp);
    });
}
