$(function () {
    var route = './Track/GetTrackReports';
    $.get(route, function (resp) {
       
        $('#totalWorkoutTimeOfDay').html(Math.abs(resp.TotalWorkoutTimeOfDay) + ' mins');
        $('#totalWorkoutTimeOfWeek').html(Math.abs(resp.TotalWorkoutTimeOfMonth) + ' mins');
        $('#totalWorkoutTimeOfMonth').html(Math.abs(resp.TotalWorkoutTimeOfWeek) + ' mins');

        var weekDataLabels = [];
        var weekData = [];
        var monthData = [];
        var monthDataLabels = [];
        var yearData = [];
        var yearDataLabels = [];

        $.each(resp.TotalCaloriesBurntPerWeek, function (i, v) {
            weekDataLabels.push(v.Duration);
            weekData.push(Math.abs(v.TotalCaloriesBurnt));
        });

        $.each(resp.TotalCaloriesBurntPerMonth, function (i, v) {
            monthDataLabels.push(v.Duration);
            monthData.push(Math.abs(v.TotalCaloriesBurnt));
        });

        $.each(resp.TotalCaloriesBurntPerYear, function (i, v) {
            yearDataLabels.push(v.Duration);
            yearData.push(Math.abs(v.TotalCaloriesBurnt));
        });

        var backgroundColors = [
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

        ];

        var borderColors = [
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
        ];

        var ctx = document.getElementById("chartWeekData").getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: weekDataLabels,
                datasets: [{
                    label: 'Calories Burnt Per Week',
                    data: weekData,
                    backgroundColor: backgroundColors,
                    borderColor: borderColors,
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

        var ctx = document.getElementById("chartMonthData").getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: monthDataLabels,
                datasets: [{
                    label: 'Calories Burnt Per Month',
                    data: monthData,
                    backgroundColor: backgroundColors,
                    borderColor: borderColors,
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

        var ctx = document.getElementById("chartYearData").getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: yearDataLabels,
                datasets: [{
                    label: 'Calories Burnt Per Year',
                    data: yearData,
                    backgroundColor: backgroundColors,
                    borderColor: borderColors,
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