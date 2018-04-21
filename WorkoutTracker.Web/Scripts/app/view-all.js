$(function () {
    $('#search').focus();
    $("#search").keyup(function () {
        filterWorkouts();
    });
});


function deleteWorkout(id) {
    var action = './ViewAll/DeleteWorkout?id=' + id;
    $.get(action, function (response) {
        $('#workoutContainer').html(response);        
    });
}

function filterWorkouts(controllerName) {
    var title = $('#search').val();
    var route = './ViewAll/WorkoutFilter?title=' + title;
    $.get(route, function (resp) {
        $('#workoutContainer').html(resp);
    });
}