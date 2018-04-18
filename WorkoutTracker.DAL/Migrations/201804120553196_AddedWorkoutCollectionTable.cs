namespace WorkoutTracker.DAL.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddedWorkoutCollectionTable : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.workout_collection",
                c => new
                    {
                        workout_id = c.Int(nullable: false, identity: true),
                        workout_title = c.String(maxLength: 128, unicode: false),
                        workout_note = c.String(maxLength: 256, unicode: false),
                        calories_burn_per_min = c.Decimal(nullable: false, precision: 18, scale: 2),
                        category_id = c.Int(nullable: false),
                    })
                .PrimaryKey(t => t.workout_id)
                .ForeignKey("dbo.workout_category", t => t.category_id, cascadeDelete: true)
                .Index(t => t.category_id);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.workout_collection", "category_id", "dbo.workout_category");
            DropIndex("dbo.workout_collection", new[] { "category_id" });
            DropTable("dbo.workout_collection");
        }
    }
}
