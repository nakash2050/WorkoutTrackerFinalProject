import { Component, OnInit } from "@angular/core";
import { Workout } from "../_models/workout";
import { ActivatedRoute, Router } from "@angular/router";
import * as _ from "underscore";

@Component({
  selector: "app-track",
  templateUrl: "./track.component.html",
  styleUrls: ["./track.component.css"]
})
export class TrackComponent implements OnInit {
  report: any;
  workouts: Workout[];
  totalWorkoutTime: number = 0;

  constructor(
    private router: Router,
    private route: ActivatedRoute
  ) { }

  public barChartOptions: any = {
    scaleShowVerticalLines: true,
    responsive: true
  };

  public barChartWeekLabels: string[] = [];
  public barChartMonthLabels: string[] = [];
  public barChartYearLabels: string[] = [];

  public barChartType: string = "bar";
  public barChartLegend: boolean = true;
  public chartColors = [
    {
      backgroundColor: [
        "#e03c31",
        "#006699",
        "#ce534b",
        "#0088cc",
        "#539536",
        "#ff6633",
        "#e7ab08",
        "#38424a",
        "#ce3607",
        "#07ce99",
        "#ff2233",
        "#9907ce"
      ]
    }
  ];

  public barChartWeekData: any[] = [
    {
      data: [],
      label: ''
    }
  ];

  public barChartMonthData: any[] = [
    {
      data: [],
      label: ''
    }
  ];

  public barChartYearData: any[] = [
    {
      data: [],
      label: ''
    }
  ];

  ngOnInit() {
    this.route.data.subscribe(data => {
      this.report = data["report"];

      //Weekly Calories Report
      const totalCaloriesBurntPerWeek = this.report.totalCaloriesBurntPerWeek;
      let totalWeeklyCalories = 0;
      if (totalCaloriesBurntPerWeek) {
        for (let data of totalCaloriesBurntPerWeek) {
          this.barChartWeekLabels.push(data.duration);
          this.barChartWeekData[0].data.push(data.totalCaloriesBurnt);
          totalWeeklyCalories = totalWeeklyCalories + +data["totalCaloriesBurnt"];
        }
        this.barChartWeekData[0].label = "Weekly Calories Burnt: " + totalWeeklyCalories;
      }

      //Monthly Calories Report
      const totalCaloriesBurntPerMonth = this.report.totalCaloriesBurntPerMonth;
      let totalMonthlyCalories = 0;
      if (totalCaloriesBurntPerMonth) {
        for (let data of totalCaloriesBurntPerMonth) {
          this.barChartMonthLabels.push(data.duration);
          this.barChartMonthData[0].data.push(data.totalCaloriesBurnt);
          totalMonthlyCalories = totalMonthlyCalories + +data["totalCaloriesBurnt"];
        }
        this.barChartMonthData[0].label = "Monthly Calories Burnt: " + totalMonthlyCalories;
      }

      //Monthly Calories Report
      const totalCaloriesBurntPerYear = this.report.totalCaloriesBurntPerYear;
      let totalYearlyCalories = 0;
      if (totalCaloriesBurntPerYear) {
        for (let data of totalCaloriesBurntPerYear) {
          this.barChartYearLabels.push(data.duration);
          this.barChartYearData[0].data.push(data.totalCaloriesBurnt);
          totalYearlyCalories = totalYearlyCalories + +data["totalCaloriesBurnt"];
        }
        this.barChartYearData[0].label = "Yearly Calories Burnt: " + totalYearlyCalories;
      }

    });
  }
}
