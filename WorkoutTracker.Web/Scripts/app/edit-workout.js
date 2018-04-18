function loadCategoriesModal() {
    var id = $(this).data('assigned-id');
    var route = getRoute() + 'CategoryModal?id=1';
    $('#partial').load(route);
    $('#txtTitle').focus();
}

function reloadCategories() {
    var req = getRoute() + 'GetAllCategories';
    $.get(req, function (resp) {
        if (resp.categories) {
            $('#Workout_CategoryId')
                .find('option')
                .remove()
                .end()
                .append('<option value="">select</option>')
                .val('');

            $.each(resp.categories, function (index, category) {
                var key = category.CategoryId;
                var val = category.CategoryName;

                $('#Workout_CategoryId')
                    .append($("<option></option>")
                    .attr("value", key)
                    .text(val));
            });
        }
    });
}