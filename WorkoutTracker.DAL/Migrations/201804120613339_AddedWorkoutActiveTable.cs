namespace WorkoutTracker.DAL.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddedWorkoutActiveTable : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.workout_active",
                c => new
                    {
                        workout_active_id = c.Int(nullable: false, identity: true),
                        workout_id = c.Int(nullable: false),
                        start_date = c.DateTime(),
                        start_time = c.Time(precision: 7),
                        end_date = c.DateTime(),
                        end_time = c.Time(precision: 7),
                        comment = c.String(maxLength: 64, unicode: false),
                        status = c.Boolean(),
                    })
                .PrimaryKey(t => t.workout_active_id)
                .ForeignKey("dbo.workout_collection", t => t.workout_id, cascadeDelete: true)
                .Index(t => t.workout_id);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.workout_active", "workout_id", "dbo.workout_collection");
            DropIndex("dbo.workout_active", new[] { "workout_id" });
            DropTable("dbo.workout_active");
        }
    }
}
