function getRoute() {
    var route = '';
    var controllerName = $('#controller').val();

    switch (controllerName) {
        case "Category":
        case "Create":
            route = './Category/';
            break;
        default:
            route = '../../Category/';
    }

    return route;
}