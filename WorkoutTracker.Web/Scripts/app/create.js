$(function () {
    $('#Workout_WorkoutTitle').focus();
});


function addCalories() {
    var oCalBurnt = $('#caloriesburnt');
    var calories;

    if (!oCalBurnt.val()) {
        calories = 0;
    } else {
        calories = oCalBurnt.val();
    }

    calories = (calories * 10 + 0.1 * 10) / 10;
    oCalBurnt.val(calories);
}

function subtractCalories() {
    var oCalBurnt = $('#caloriesburnt');
    var calories;

    if (!oCalBurnt.val()) {
        calories = 0;
    } else {
        calories = oCalBurnt.val();
    }

    if (calories > 0) {
        calories = (calories * 10 - 0.1 * 10) / 10;
        oCalBurnt.val(calories);
    }
}

function loadCategoriesModal() {
    var id = $(this).data('assigned-id');    
    var route = './Category/CategoryModal?id=1';
    $('#partial').load(route);
    $('#txtTitle').focus();
}

function reloadCategories() {    
    var req = './Category/GetAllCategories';
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

