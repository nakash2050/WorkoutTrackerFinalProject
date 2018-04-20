$(function () {
    var route = './Track/GetTrackReports';
    $.get(route, function (resp) {
        console.log(resp);
        $('#totalWorkoutTimeOfDay').html(Math.abs(resp.TotalWorkoutTimeOfDay) + ' mins');
        $('#totalWorkoutTimeOfWeek').html(Math.abs(resp.TotalWorkoutTimeOfMonth) + ' mins');
        $('#totalWorkoutTimeOfMonth').html(Math.abs(resp.TotalWorkoutTimeOfWeek) + ' mins');

        var ctx = document.getElementById("myChart").getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange", "Sunday", "Monday", "Trim", "Trim2", "TRIM", "TREE"],
                datasets: [{
                    label: '# of Votes',
                    data: [12, 19, 3, 5, 2, 3, 4, 5, 10, 5, 6, 9],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)',
                        'rgba(56, 66, 74, 0.2)',
                        'rgba(206, 54, 7, 0.2)',
                        'rgba(7, 206, 153, 0.2)',
                        'rgba(255, 34, 51, 0.2)',
                        'rgba(153, 7, 206, 0.2)',
                        'rgb(0, 136, 204, 0.2)'

                    ],
                    borderColor: [
                        'rgba(255,99,132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)',
                        'rgba(56, 66, 74, 1)',
                        'rgba(206, 54, 7, 1)',
                        'rgba(7, 206, 153, 1)',
                        'rgba(255, 34, 51, 1)',
                        'rgba(153, 7, 206, 1)',
                        'rgb(0, 136, 204, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }]
                }
            }
        });
    });
})