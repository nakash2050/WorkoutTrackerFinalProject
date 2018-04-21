$(function () {
    var route = './Track/GetTrackReports';
    $.get(route, function (resp) {
       
        //$('#totalWorkoutTimeOfDay').html(Math.abs(resp.TotalWorkoutTimeOfDay) + ' mins');
        //$('#totalWorkoutTimeOfWeek').html(Math.abs(resp.TotalWorkoutTimeOfMonth) + ' mins');
        //$('#totalWorkoutTimeOfMonth').html(Math.abs(resp.TotalWorkoutTimeOfWeek) + ' mins');

        $('#totalWorkoutTimeOfDay').html('45 mins');
        $('#totalWorkoutTimeOfWeek').html('240 mins');
        $('#totalWorkoutTimeOfMonth').html('1005 mins');

        //var weekDataLabels = [];
        //var weekData = [];
        //var monthData = [];
        //var monthDataLabels = [];
        //var yearData = [];
        //var yearDataLabels = [];

        var weekDataLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        var weekData = [850, 1000, 1100, 650, 500, 550, 950, 1250];
        var monthData = [1000, 1200, 1300, 1100, 1250];
        var monthDataLabels = ['Week1', 'Week 2', 'Week 3', 'Week 4', 'Week 5'];
        var yearData = [1000, 1500, 1750, 1250, 1300, 1550, 1600, 1270, 1430, 980, 1625, 1330];
        var yearDataLabels = ['M1', 'M2', 'M3', 'M4', 'M5', 'M6', 'M7', 'M8', 'M9', 'M10', 'M11', 'M12'];

        //$.each(resp.TotalCaloriesBurntPerWeek, function (i, v) {
        //    weekDataLabels.push(v.Duration);
        //    weekData.push(Math.abs(v.TotalCaloriesBurnt));
        //});

        //$.each(resp.TotalCaloriesBurntPerMonth, function (i, v) {
        //    monthDataLabels.push(v.Duration);
        //    monthData.push(Math.abs(v.TotalCaloriesBurnt));
        //});

        //$.each(resp.TotalCaloriesBurntPerYear, function (i, v) {
        //    yearDataLabels.push(v.Duration);
        //    yearData.push(Math.abs(v.TotalCaloriesBurnt));
        //});

        var backgroundColors = [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)',
                        'rgba(50 ,205, 50, 0.2)',
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
                        'rgba(50, 205 ,50, 1)',
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
                    label: 'Week Total Calories Burnt: 4800',
                    data: weekData,
                    backgroundColor: backgroundColors,
                    borderColor: borderColors,
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
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
                    label: 'Month Total Calories Burnt: 18000',
                    data: monthData,
                    backgroundColor: backgroundColors,
                    borderColor: borderColors,
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
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
                    label: 'Year Total Calories Burnt: 190000',
                    data: yearData,
                    backgroundColor: backgroundColors,
                    borderColor: borderColors,
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
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