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

