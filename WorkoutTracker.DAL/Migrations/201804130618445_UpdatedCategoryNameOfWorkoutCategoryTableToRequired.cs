namespace WorkoutTracker.DAL.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class UpdatedCategoryNameOfWorkoutCategoryTableToRequired : DbMigration
    {
        public override void Up()
        {
            AlterColumn("dbo.workout_category", "category_name", c => c.String(nullable: false, maxLength: 64, unicode: false));
        }
        
        public override void Down()
        {
            AlterColumn("dbo.workout_category", "category_name", c => c.String(maxLength: 64, unicode: false));
        }
    }
}
