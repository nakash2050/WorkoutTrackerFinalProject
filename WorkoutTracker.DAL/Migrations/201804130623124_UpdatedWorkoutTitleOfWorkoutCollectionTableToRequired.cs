namespace WorkoutTracker.DAL.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class UpdatedWorkoutTitleOfWorkoutCollectionTableToRequired : DbMigration
    {
        public override void Up()
        {
            AlterColumn("dbo.workout_collection", "workout_title", c => c.String(nullable: false, maxLength: 128, unicode: false));
        }
        
        public override void Down()
        {
            AlterColumn("dbo.workout_collection", "workout_title", c => c.String(maxLength: 128, unicode: false));
        }
    }
}
