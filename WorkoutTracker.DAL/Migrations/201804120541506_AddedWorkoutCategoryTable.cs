namespace WorkoutTracker.DAL.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddedWorkoutCategoryTable : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.workout_category",
                c => new
                    {
                        category_id = c.Int(nullable: false, identity: true),
                        category_name = c.String(maxLength: 64, unicode: false),
                    })
                .PrimaryKey(t => t.category_id);
            
        }
        
        public override void Down()
        {
            DropTable("dbo.workout_category");
        }
    }
}
