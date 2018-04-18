function deleteWorkout(id) {
    var action = './ViewAll/DeleteWorkout?id=' + id;
    $.get(action, function (response) {
        $('#workoutContainer').html(response);        
    });
}