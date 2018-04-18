﻿DECLARE @CurrentMigration [nvarchar](max)

IF object_id('[dbo].[__MigrationHistory]') IS NOT NULL
    SELECT @CurrentMigration =
        (SELECT TOP (1) 
        [Project1].[MigrationId] AS [MigrationId]
        FROM ( SELECT 
        [Extent1].[MigrationId] AS [MigrationId]
        FROM [dbo].[__MigrationHistory] AS [Extent1]
        WHERE [Extent1].[ContextKey] = N'WorkoutTracker.DAL.Migrations.Configuration'
        )  AS [Project1]
        ORDER BY [Project1].[MigrationId] DESC)

IF @CurrentMigration IS NULL
    SET @CurrentMigration = '0'

IF @CurrentMigration < '201804120541506_AddedWorkoutCategoryTable'
BEGIN
    CREATE TABLE [dbo].[workout_category] (
        [category_id] [int] NOT NULL IDENTITY,
        [category_name] [varchar](64),
        CONSTRAINT [PK_dbo.workout_category] PRIMARY KEY ([category_id])
    )
    CREATE TABLE [dbo].[__MigrationHistory] (
        [MigrationId] [nvarchar](150) NOT NULL,
        [ContextKey] [nvarchar](300) NOT NULL,
        [Model] [varbinary](max) NOT NULL,
        [ProductVersion] [nvarchar](32) NOT NULL,
        CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY ([MigrationId], [ContextKey])
    )
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201804120541506_AddedWorkoutCategoryTable', N'WorkoutTracker.DAL.Migrations.Configuration',  0x1F8B0800000000000400CD57DB6E1B37107D2FD07F20F8EC88BE144563AC12B8921D08B56C23EBA48F01C51DC984B9E486E43AD2B7E5A19FD45FE870AFD2AE2EB69387C22F5E72E6CCEDCC0CF5EFF77FA2F7CB549127B04E1A3DA42783634A400B9348BD18D2DCCFDFFC41DFBFFBF597E8324997E4732D7716E45053BB217DF03E3B67CC890748B91BA45258E3CCDC0F8449194F0C3B3D3E7ECB4E4E182004452C42A28FB9F63285E2033F47460BC87CCED5D424A05C758E3771814A6E780A2EE30286F46F631F4DEEEF2D178F6007E38B6B4A2E94E4E8490C6A4E09D7DA78EED1CFF34F0E626F8D5EC4191E7075BFCA00E5E65C39A8FC3F6FC59F1BCAF1690885B58A3594C89D37E90B014FCEAADCB0AEFAAB324C9BDC61F62E31CB7E15A22E32D8246FC43D2C8C5D51D2B5793E5236C8F7F25C404970830EC411D92178D4B0054915FE8EC828573EB730D4907BCBD511B9CB674A8ABF60756F1E410F75AED4BAFF1801DE6D1CE0D19D351958BFFA08F32AAADA97494209DBD4675D80467D8B6E19F844FBB3534A6ED0193E53D0D0652D49B137163E80068BDAC91DF71E2C567B924091F09E173B6C86AFDA2AF2145B8E92295F5E835EF88721FDFD374AAEE41292FAA072E49396D8A0A8E36D0E9BB622D696BC4F046C33CF257ABDC986AA72E116967E0B27B08D2A5AB8CAE86678257A0C7E17CB5AA7CA26ED92687B108DBBED3860E53CA8E706DB3138A229CF324CE7DA20A94E485C4E91D19BF8E5ED9596184CB82D5DD678DB584292F005746ED1347A7A25ADF363EEF98C878A8E92B427B6BD383B125FDBDC9EFF6E07B5E5A8F5C2FFDB3811C66BAF581DB836B957186F8A2D50840E8D73071D2A3062C115B77BBA7364549EEAF25C54E75F64AFE59F035736DE56405D5CF52123D609B29B54D6CB6A6712758BB58FF15D91C67AC3FC0EC3A38A6D87F7678F7EA5082598AB279904EAC52BE7211D048141FC558D94C4785B8129D7720ECE97439BE20A3BEDACE0FFCF3A64CE25EA653BF1150B680F1D0F6FA00DE57246CA90EE834BA6B7A1F66F9D0EC54B4B4FDC8A076E7B7BA7C5FED125D31F773F7D79940C1ED2646630AED2ED6FA5D017F1A32BA6DF58115B7FBE46637072D14284C7AC061118DB82D632133D37755930E4758F6A914ED5A6E0798299BBB05ECEB9F0782DC0B9E2ADF099AB1C452ED31924137D9BFB2CF717CE413A531BF1466CBFFD628F6EFA1CDD66E1CBFD8C10D04D8921C0ADFE33972A69FCBEEAB37617442051D50AE815BE954255570DD28DD1CF04AAD237860C7468A47B48338560EE56C7FC095EE31BBE8EAE61C1C5AA9E8FBB410E176233EDD158F285E5A9AB305AFDF0938C85DF64EFFE03CEC2CD1DC50D0000 , N'6.2.0-61023')
END

IF @CurrentMigration < '201804120553196_AddedWorkoutCollectionTable'
BEGIN
    CREATE TABLE [dbo].[workout_collection] (
        [workout_id] [int] NOT NULL IDENTITY,
        [workout_title] [varchar](128),
        [workout_note] [varchar](256),
        [calories_burn_per_min] [decimal](18, 2) NOT NULL,
        [category_id] [int] NOT NULL,
        CONSTRAINT [PK_dbo.workout_collection] PRIMARY KEY ([workout_id])
    )
    CREATE INDEX [IX_category_id] ON [dbo].[workout_collection]([category_id])
    ALTER TABLE [dbo].[workout_collection] ADD CONSTRAINT [FK_dbo.workout_collection_dbo.workout_category_category_id] FOREIGN KEY ([category_id]) REFERENCES [dbo].[workout_category] ([category_id]) ON DELETE CASCADE
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201804120553196_AddedWorkoutCollectionTable', N'WorkoutTracker.DAL.Migrations.Configuration',  0x1F8B0800000000000400D559CD6EE33610BE17E83B083A16592BF6B68B6D60EF22EB2485D1CD0FE2ECB6B78096C60EB114A992546AA3E893F5D047EA2B74A83F4BA2645B8E936E914B44CE7C339C3F72C6FFFCF5F7F0FD3264CE234845051FB9FDDEB1EB00F74540F962E4C67AFEEAADFBFEDDB7DF0CCF8370E97CCEE95E1B3AE4E46AE43E681D9D789EF21F2024AA17525F0A25E6BAE78BD02381F006C7C73F7AFDBE0708E12296E30C6F63AE6908C9077E8E05F721D23161972200A6B275DC9926A8CE15094145C48791FB8B905F44ACEF24F1BF80EC9D9D7E749D5346096A320536771DC2B9D044A39E279F144CB5147C318D7081B0BB55044837274C41A6FFC99A7CD7A31C0FCC51BC35630EE5C74A8BB02360FF75661BAFCEBE9785DDC27668BD73B4B25E995327162C8C37261A1642AE5CA72EF364CCA4A1B7EC9C405150BD1AC491D3427854440B0695F93B72C631D3B1841187584BC28E9C9B78C6A8FF33ACEEC417E0231E3356D61F4F807B95055CBA912202A957B730CF4E95EB32095CC7ABF27B758082BD81373DF884EBD703D7B94265C88C41112E25234DB590F0137090C81DDC10AD41A2B727012406B7B4689169BE72A918A79872AE7349961F812FF4C3C87DF3BDEB5CD02504F942A6C8274E31419147CB18AAB286DEDAE53B0582600CFC34D8F60F8502E46B08864C837D62A1C4FA52A190DB8B6AB62914FA83B79D63A155D895D09B640D7E7873005963C28444CF7F8825D737202F29CF659E814F43C25CE746E27FD9C583E79BFAC4D8B8C9E0BBE5D376C7D570AEC8235D247E6CB6D4BA4EDE024BE8D4038DD28BC68EFE7B8BEB428AF056B0A67CAB13DF4F452C7DE317B12BC71D910BD0BB158053A5844F9323B455004BFDAAADCE79E0743E4B1A638DD6C298C30A4023CC79D477E47E6779A78BC4DC160D120B6F54E5F5DD7A2DB9E667C0408373EAA7B7F798289F0476D8A08D83EA0A961F9026E309C3B78CC28246B9B66B15E53E8D08EB7AAA1A50C73BD0285C88AEEF9C4104DCD4AAAEBE7DBA4E85E89A71B7D972E89582D9BEE490472307C85A854D6F24B30B4BDD70DBE15B31BBF05456E1EAD168D0A7A0DB4AC43AF1DA02D08AEF66C4528AB46296686AA825E36C80B66B55896FE70257F7E93E35A2B042A301ACB0D9A728348868F38957355F43652DE26BDDA47869979277335E4B3B33BC245184B76DA9BDC9569C69DADB8C5F4DBB3FFAC314C3F355C3DBBFD0B69084EF15B280DA2E8A464D2FA854FA8C683223E6B21C07A145D69C4D2D719DCB6C4E18DBB379ACE77CE6FFA624364D9F955D7641CA602EF0BCA1A970C9536D432C580849FF4918911BDE1B187E71C8D3753F0F3CDA50F0B6C3A5ED4023204FB66CC8A1573BA455652DAB5A5759D5599D5CB94ED40339B315B0833B3760B479A0F4F02F9BFFF774B9A33BAB4FFA263C9D6E75864C1FEE4D883CD9E912720DAFF36AE4A504F733A4B847D6FB903694E34D12F6CA91670D68AB84D7490AE94529AF95EC61563EB78FA9AC7A9A9298A6473CD2C0D4D2E94A69087B86A037FD8D8D19C5F3AE092E09A773503A6D87DDC1717F509B747D3D53274FA980751B3DEDD1DA6F889DEDCD7D85397D515163EEAD0D7CC766B456B353498F44FA0F445AE39D35F64167397BD8B6BDD66D376D99F7192D5B2B9FED964DA6259B4CDB8ECD4BB39126E86438D20DBAA594A6328243CF42DAC2DCEA7726D87B2D47EE1F09DF8933F9F5BEC47AE45C4B2C4127CEB1F3E716155E72E250BCDAFFA3367F43F3F1D461C7932608ED6FE04E45F469938243487FA19980DDEC1CBCD74FAF7B4CF099C0D048B3272F32FE334F0436CAFEBF4C0E6AB6DEA57BDF96A15D460D879904D8CF458CE5D26F9F98558A2ED610E697509E2AB406CD69267C2EF28CAA699493D42E834BD024C0103F959ACE89AF71DB07A59289FF67C26224390F67104CF875ACA358E391219CB18A614D526E929F8C3BAA3A0FAFA364567E8823A09A148F00D7FC434C5950E87DD17013B540986CCF9E21C697DA3C4716AB02E94AF01D8132F31545EA0EC2882198BAE653F208FBE8F649C14758107F95BFFADB41B63BA26AF6E119250B49429561ACF9F11363380897EFFE050984A48402200000 , N'6.2.0-61023')
END

IF @CurrentMigration < '201804120613339_AddedWorkoutActiveTable'
BEGIN
    CREATE TABLE [dbo].[workout_active] (
        [workout_active_id] [int] NOT NULL IDENTITY,
        [workout_id] [int] NOT NULL,
        [start_date] [datetime],
        [start_time] [time](7),
        [end_date] [datetime],
        [end_time] [time](7),
        [comment] [varchar](64),
        [status] [bit],
        CONSTRAINT [PK_dbo.workout_active] PRIMARY KEY ([workout_active_id])
    )
    CREATE INDEX [IX_workout_id] ON [dbo].[workout_active]([workout_id])
    ALTER TABLE [dbo].[workout_active] ADD CONSTRAINT [FK_dbo.workout_active_dbo.workout_collection_workout_id] FOREIGN KEY ([workout_id]) REFERENCES [dbo].[workout_collection] ([workout_id]) ON DELETE CASCADE
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201804120613339_AddedWorkoutActiveTable', N'WorkoutTracker.DAL.Migrations.Configuration',  0x1F8B0800000000000400D55BDB6EE336107D2FD07F10F45864AD24DB6EB781BD8BACB3298C6E2E88936DDF0C5AA21D6229D225A93446D12FEB433FA9BFD0A16ED65DA2AC6453E4C5A6C833C3E199E168C6F9F7EF7FC6EF1F7D6A3D6021096713FB6874685B98B9DC236C3DB103B57AF5D67EFFEEDB6FC61F3DFFD1FA9CCC7BADE7C14A2627F6BD529B13C791EE3DF6911CF9C4155CF2951AB9DC7790C79DE3C3C39F9CA3230703840D589635BE0998223E0EBFC0D729672EDEA800D10BEE612AE37178320F51AD4BE463B9412E9ED8BF72F18507EA5620F70B16A3B3D34FB6754A09024DE698AE6C0B31C61552A0E7C99DC47325385BCF373080E8ED768361DE0A518963FD4F76D3BB6EE5F0586FC5D92D4CA0DC402AEE1B021EBD8E6DE31497F7B2B09DDA0EACF711ACACB67AD7A10553E39DBA8A3C80058A124FA654E8D9252B874004CB510EE0C0AA997690320508A5FF0EAC69405520F084E14009440FACEB604989FB0BDEDEF22F984D5840695677D01E9EE50660E85AF00D166A7B8357553B9A79B6E5E4419C224A8A5107101960C6D4EB63DBBA04B5D092E294341963CD1517F867CCB0400A7BD748292CE0CC671E0ECD5E52A55A70BBC86698B942429D8106098CFE7C0BCED5696134315AD865D147E6F59105CB4C254DB9EF83219325E0C710926CEB023D7EC26CADEE27F69BEF6DEB9C3C622F1988ED75C708043058A344D0C50A2A9089940F9C538C5869D1257A20EBF0D4AB0F71CA29C56EE4B437988633E53DD9443129EF358B8A35E782FB379C16E9589EBA98F340B8DA90BCDBFC5B24D658E53734767681A14BB8C86ADA3B64EC405E50D8D823607C8550714B14C50D0E7174FC76008F88855D72D524EBF8873703C89A22CA059CFC874030758DC505616968C12EF111B5AD6B019FE2F404F6377791B6B179A09C82E9D75C6C8D036EABF3C7C04DAE9FF1C8D2AA92F3D74FAE73FF861583048054D7FEEE1F43BC04E7CF32C1D4FBBBB36838F74F64EA6FC3DE877544389592BB2454BEEE2A28F138BF05B8F12D6352473BAB741BD829B0816CE0FC41DF89FD5DC968261213A7A89098523D2FEFC82EF2EA8A9D618A15B64EDD28D99F22E922AF1C3FC0C65E7E04A888853E7B44E1D54702B9095365DE12E6920DA2A6BB2A0019BA805638155D7C7286379869D69A9EEDFE3AA5A20BC66DB3E5D8C990B913C76BD3B416BEB5E76C25B6252F62C6DC6ECDF74C7CE9C570BB6D575D58549BD9F52176DB91EEADD0E0AC8EE239AC51B0028B420219DDB9FA297E5415B7F99DC4F1852EE3EBA2C8438D3EC7AABA9EB0BB4CAA695E6275255A96A87588D9391D51D3C05E8B99CE2820664CDDA06C39B1CBACEB9C0D1619D2E71E4D2D5069D21209FB5C9C1522EAACE7E4CDD7DDB4F5AFCBB586ED16BA7B05EFF28EAB59DD2B5A9B9C58834193742E75FF5D21D5892AA949C5D5A929B98E2FD066038965A6041B8F58F3A8FE3A7D35372F4CFA1186E3CA8AFA64AA6D2A09D265B4C685A7BA24E4E17322A42E77A125D2B9EDD4F34BD3AA835D4D90486456C5B3F2B926812359A53F5745585D961E3582ED0C7B0E7BD595AE70DBB89666A5F561751C5124DA0A9A40A5C067D1C33FA2870B143192545C4AADC87598666099BA65164CEAE185178E1B824555C53298AAA8363681A535CE2C14DCD2C65AA555CF2290A946692D340BE4268346660A8B9D051B85636594B1536068297B2939442939CC7B99890F3606EF3E7E580FD8DD179B309EC56BF295C02A3C153D32868CEA7D55888C9BD1BEB2A897636E3C61B184190B58BAF0494562D22461F7A698078ED3946AA37E6542D7A778BDE85C036740E65A8481EDDE0617D5B52A0119AA8E944F7A94A534AA3825959EA65385B4691CA730EDEDEC524E134DD1656FFE403C9DCFCCB752617FA4278CE6BFD3292561D84F265C20465658AAA8266A1F1F1E1D173AE22FA73BED48E9519316758FEA6E6B8AD35EE4AD80885E1789367C6B35D7B03191BD0932624A2FE733E6E1C789FD67B8ECC49AFDB6D8AD3CB0AE0470E1C43AB4FE3256209B73450AE8CF5192B283EAD2CFC9265C1152F439D3C3F9D114739779EDA7DB2EF11A4A3337DFA27E40C2BD47A25493373661A621BD24AA19608F5EEE1EBEB58F533D9337A96CB3B4EA68C26EA9D9D9E433A27AE8B0396AC8A5EA9C28A6FCD0BDD0DC856D1673324B0D824EEF8E630F92366423ED2CADB3CCD0342D6438FD23C873B6F0D212DF57EA9B35542AF7ED1EEED592AB4FC58DD8B95FEB6D08E92FBFC9D6F7C49F96874929B87F876F989670270E34551EFAB6C80610FC4CADB0721179D01657F4FA0657F692031DA2A09D7F9D78AA36589364F749DB658D92FF1F4DB5C26EBB34B6DAA2D3403D9D97D424EBBBBDA690D9B5AF364CDBAB5C97810093F96704887292AC7710FA5F1358B4A91D683267C6563C8972058D922985ACEF022B04EFAFE85428B28270008F5D2C65F84BAECF8806BA69E02FB137635781DA8029A4C4FE92E6B8A7236593FCB0B797D7797CB5097F9638C416404DA25FC1AFD88780502FD5FBBC22E9AF81D021384EA5F5592A9D52AFB729D225671D8162F3A537C72DF63714C0E4159B234D2173DDEE24FE84D7C8DD26E5B57A90F683C89B7D7C46D05A205FC618BBF5F01538ECF98FEFFE035AEB057B93330000 , N'6.2.0-61023')
END

IF @CurrentMigration < '201804130618445_UpdatedCategoryNameOfWorkoutCategoryTableToRequired'
BEGIN
    DECLARE @var0 nvarchar(128)
    SELECT @var0 = name
    FROM sys.default_constraints
    WHERE parent_object_id = object_id(N'dbo.workout_category')
    AND col_name(parent_object_id, parent_column_id) = 'category_name';
    IF @var0 IS NOT NULL
        EXECUTE('ALTER TABLE [dbo].[workout_category] DROP CONSTRAINT [' + @var0 + ']')
    ALTER TABLE [dbo].[workout_category] ALTER COLUMN [category_name] [varchar](64) NOT NULL
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201804130618445_UpdatedCategoryNameOfWorkoutCategoryTableToRequired', N'WorkoutTracker.DAL.Migrations.Configuration',  0x1F8B0800000000000400D55BDB6EE336107D2FD07F10F45864AD24DB6EB781BD8BACB3298C6E2E88936DDF0C5AA21D6229D225A93446D12FEB433FA9BFD0A16ED65DA2AC6C52E4C5A6C833C3E199E168C6F9F7EF7FC6EF1F7D6A3D6021096713FB6874685B98B9DC236C3DB103B57AF5D67EFFEEDB6FC61F3DFFD1FA9CCC7BADE7C14A2627F6BD529B13C791EE3DF6911CF9C4155CF2951AB9DC7790C79DE3C3C39F9CA3230703840D589635BE0998223E0EBFC0D729672EDEA800D10BEE612AE37178320F51AD4BE463B9412E9ED8BF72F18507EA5620F70B16A3B3D34FB6754A09024DE698AE6C0B31C61552A0E7C99DC47325385BCF373080E8ED768361DE0A518963FD4F76D3BB6EE5F0586FC5D92D4CA0DC402AEE1B021EBD8E6DE31497F7B2B09DDA0EACF711ACACB67AD7A10553E39DBA8A3C80058A124FA654E8D9252B874004CB510EE0C0AA997690320508A5FF0EAC69405520F084E14009440FACEB604989FB0BDEDEF22F984D5840695677D01E9EE50660E85AF00D166A7B8357553B9A79B6E5E4419C224A8A5107101960C6D4EB63DBBA04B5D092E294341963CD1517F867CCB0400A7BD748292CE0CC671E0ECD5E52A55A70BBC86698B942429D8106098CFE7C0BCED5696134315AD865D147E6F59105CB4C254DB9EF83219325E0C710926CEB023D7EC26CADEE27F69BEF6DEB9C3C622F1988ED75C708043058A344D0C50A2A9089940F9C538C5869D1257A20EBF0D4AB0F71CA29C56EE4B437988633E53DD9443129EF358B8A35E782FB379C16E9589EBA98F340B8DA90BCDBFC5B24D658E53734767681A14BB8C86ADA3B64EC405E50D8D823603C43A8B8258AE20687383A7E3B8047C4C22EB96A9275FCC39B01644D11E5024EFE432098BAC6E282B034B46097F888DAD6B5804F717A02FB9BBB48DBD83C504EC1F46B2EB6C601B7D5F963E026D7CF78646955C9F9EB27D7B97FC38A410240AA6B7FF78F215E82F3679960EAFDDD59349CFB2732F5B7FDEFC346BAD731E3544AEE92703775774389D8F93D410A6019B33CDA6AA51FC1D6811E640384007D27F677252B9A484CBCA44262CAFDBCBC23BB48B42B76862956D83A75A3EC7F8AA48BBC7240011B7BF911E026169A0C88C2BB9004B613A6CA4426CC251B444D77550032F409AD702ABAF8E40C6F30D334363DDBFD754A45178CDB66CBB1932173278ED7E66D2D7C6B4FE24A6C4BDECC8CB9DD9A009AF8D28BE176DBAEBAB0A836D5EB43ECB623DD5BA1C1591DC57358A3600516858C32BA84F553FCA82AAEF73B89E31B5EC6F74791871A7D8E55758161779954D3BCC4EA4AB42C51EB10B3733AA2A681BD16339D5140CC98BA41D972A69759D7393D2C32A4CF3D9A5AA0D2A42512F6B9382B44D459CFC99BAFBB69EBDF9F6B0DDB2D74F70ADEE51D57B3BA57B43639B1068326E95CEAFEBBCAAA1395569312AC5353831D5FA0CD0632CD4C4D361EB1E6514176FA6A6E5EA9F4230CC7951505CB54DB5412E4CF688D0B4F758DC8C3E744485DFF424BA493D9A9E797A65507BB9A2091C8AC8A67E5734D0247B24A7FAE8AB0BA4E3D6A04DB19F61CF6AA4B5FE1B6712DCD4AEBC37239A248B45538814A81CFA2877F440F17286224A9B8945A91EB30CDC03285CC2C98D4C30B2F1C37048BCA8C653055517E6C024B8B9E5928B8A58DB54ACBA04520538DD2E26816C84D068DCC14563F0B360AC7CA2863A7C0D052F6527288527298F732131F6C0CDE7DFCB01EB0BB2F36617C15AFC99706ABF054F4C818322A005621326E46FBCA2A5F8EB9F184C512662C60E9C2271589499384DD9B621E384E53AA8DFACC84AE4FF17AD1B906CE80CCB50803DBBD0D2E2A74550232541D299FF4284B6954714A2A3D4DA70A69D3384E61DAFBDBA59C269AA2EBE0FC81783A9F996FA5C2FE484F18CD7FA7534AC2B09F4CB8408CACB0545191D43E3E3C3A2EB4C85F4EBBDA91D2A3263DEB1EE5DED614A7BDEA5B0111BD2E126DF8D6F2AE61A7227B1364C4945ECE67CCC38F13FBCF70D98935FB6DB15B79605D09E0C2897568FD65AC4036E78A14D09FA3246507D5A5C1934DB822A4E873A6A9F3A329E62EF3DA4FB75DE23594666EBE67FD80847B8F44A9486F6CC24C877A495433C01ECDDD3D7C6B1FA7FA4ADEA4B2DDD3AAA309DBA7666793CF88EAA1C36EA92197AA73A298F24337477317B659CCC92C35083ABD5B903D48DA908DB4B3B4CE3243D3B490E1748D20CFDCC34B6B7CCFD4386B2855EEDB3EDCAB27579F8B1BD173BFDEDB10D25F7E97ADEF893F2D0F935A70FF16DF303DE14E1C682A3DF4ED910D20F82BF5C2CA55E4417B5CD1FB1BDCD94B0E7488A276FE7DE2A9FA604D92DD27ED97354AFE7F74D50ABBEDD2D96A8B4E0335755E5297ACEFF69A4266D7C6DA307DAF726106024CE6DF1320CA49B2DE41E87F5660D1A676A0C99C195BF124CA15344AA614D2BE0BAC10BCC0A253A1C80AC2013C76B194E16FBB3E231AE8AE81BFC4DE8C5D056A03A69012FB4B9AE39E8E944DF2C3E65E5EE7F1D526FCA1E2105B0035897E07BF621F0242BD54EFF38AD4B4064287E03897D667A9744EBDDEA648979C75048ACD97DE1CB7D8DF500093576C8E3485CC75BB93F8135E23779BD4D7EA41DA0F226FF6F119416B817C1963ECD6C357E0B0E73FBEFB0FB34A1C39A5330000 , N'6.2.0-61023')
END

IF @CurrentMigration < '201804130623124_UpdatedWorkoutTitleOfWorkoutCollectionTableToRequired'
BEGIN
    DECLARE @var1 nvarchar(128)
    SELECT @var1 = name
    FROM sys.default_constraints
    WHERE parent_object_id = object_id(N'dbo.workout_collection')
    AND col_name(parent_object_id, parent_column_id) = 'workout_title';
    IF @var1 IS NOT NULL
        EXECUTE('ALTER TABLE [dbo].[workout_collection] DROP CONSTRAINT [' + @var1 + ']')
    ALTER TABLE [dbo].[workout_collection] ALTER COLUMN [workout_title] [varchar](128) NOT NULL
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201804130623124_UpdatedWorkoutTitleOfWorkoutCollectionTableToRequired', N'WorkoutTracker.DAL.Migrations.Configuration',  0x1F8B0800000000000400D55BDB6EE336107D2FD07F10F45864AD24DB6EB781BD8BACB329826E2E88936DDF0C5A621C6229D225A93446D12FEB433FA9BFD0A16ED685BA50763629F2624BE499E1E8F07034E3FCFBF73FE3F78F21751EB09084B3897B30DA771DCC7C1E10B69CB891BA7BF5D67DFFEEDB6FC61F83F0D1F99C8D7BADC7C14C2627EEBD52AB23CF93FE3D0E911C85C4175CF23B35F279E8A1807B87FBFB3F7907071E060817B01C677C1D3145421C7F81AF53CE7CBC5211A2E73CC054A6D7E1CE2C46752E5088E50AF978E2FECAC5171EA91B81FC2F588C4E8E3FB9CE3125083C99617AE73A8831AE90023F8F6E259E29C1D972B6820B88DEAC5718C6DD212A71EAFFD16678DFA5EC1FEAA5789B8919941F49C5434BC083D7696CBCEAF4411176F3D841F43E4294D55AAF3A8E601EBC635F91078840D5E2D1940A3DBA16E5188860392A01EC390DC3F672A600A1F4DF9E338DA88A049E301C2981E89E73152D28F17FC1EB1BFE05B3098B282DFA0EDEC3BDD205B87425F80A0BB5BEC677A6159D05AEE39541BC2A4A8ED1049004E08CA9D787AE73016EA105C539690AC19A292EF0CF986181140EAE905258C0333F0B701CF69A2B66C3DD26DB61660A0975021E6430FAF30D6CAE5E139381C9C43E933EB260882D98666B69CAC31002994D817D0C92E43AE7E8F113664B753F71DF7CEF3AA7E41107D985345EB78C8080C11C25A23E515091CCAC7CE09C62C46A932ED00359C64FDDFC10A79C52EC279BF61AD378A4BC27AB4493CABB666E98732A7878CD69958EF5A1F3198F84AF03C9FB8DBF416289557941636F230C7DE4A2E8E960C9D880BC20D9D842309E412A6E88A2B865431C1CBEEDB5232C1526B57EC1559BF1C31FDEEC603B4E11E502A8F021124C5D61714E58AE35D82721A2AE7325E0539AAFC082673ED24BB157CE293C8B25176B6B05EE548314B84D0B0A5BB436ABA606CD839BF4A065C64E1421F775B81EA4102F410D8A4CB09583FE2CDA9D1E6436F5B7ED0FC856BA3731E3584AEE9378354D87458DD8E535414EE058B33C59AA711FC1D2811E640584007F27EE77B528DA58CC7689C162CEFDB2BD03B74AB44B76822956D839F693D78129923E0AEA8202310ECA57809B586832200A2F4712D84E98AA1399309FAC10B55D5505C8724F688773D3D53B27788599A6B1EDB3DDDEA7DC7425B85DB11C7B0532F7E2786322D7C1B7EEACAEC6B6EC55CD9ADB9D19A1CD5E7A31DCEE5A551F1635E67E4388DDF548B77668E7AC4EF41CE62898814525C54C0E617D173F2AC3F17E2B717AC2CBF4FCA8F250A3CFB032571C36878999E635561BD18A446D422C8EE9899A0B7B23663EA2825808758BB3F54CAF30AF777A5865C89073348F8031A435120E39380D269AA2E795C3D73FB4CD2FD48D81ED27DD83C4BBBE6233AB07A9B5CD136B096896CEE5DB7F536AF5925A6B5693F51A8AB2E373B45A41A65928D2A6579C5952A19DBE9AD9972EC304C3F3A5A182997B9B5B82FC192D71E5AE2E1A05F89408A90B62688174323B0DC2DA30B3D835884466D3A467F5E79A0947364B7F3629AC2E5C8F5AC136813D85B5EA5A58BC6CDC48B3DAFCB87E8E28125D254FA05214B2E4E61FC9CD394A18490C8752277213A61D58A1B2590493FAF23C88AF5B822575C73A9832D423DBC0F22A68110A4E696BAFF2BA6815C8D6A3BC5A5A04F2B38B56618ACBA19518C5D7EA2863AFC2D05AF652DB10B5E4B0BCCB6CF660AB780FD987CD80FDF7621BC657D935E55AA1094F25B7AC219302A00991713BDA1BAB7C25E6A603E60B183187A9F390181293360B9B37C532709AA69883FACC846E4EF106D1B901CE82CC8D083B8E7B175C52E83202326456CA277D94B534AA3A24B79EA75395B4699CA630DD0DEF5A4E930CD17570FE40029DCFCCD652E170A4078C66BFD32925B1EC6703CE11237758AAA448EA1EEE1F1C567AE62FA77FED4919509B26F680726F678AD35DF5354024AF8B4407BEB3BC6BD9A9289E040533B597F33316E0C789FB673CEDC839FB6DBE99B9E75C0AE0C291B3EFFC65ED4031E74A1CD09F93246503D5A7C1534CB812A4E473A1A9F3A32DE626F3DACEB74DE2B52BCFFC7213FB0109FF1E895A91DE3A848596F582A876802DBABD5BECAD6D36D557DA4DAAD84E353D9AB89F3A109C15BAA526ECB85D6A4926735294727ED7DDD1D2896D273A85A916AA33B8073980A52DE948374D9B22B36B9E56529CBE12F2CC4DBCBCC8F74C9DB3965AE5B6FDC3AD9A72CDC9B8153DB76BBEEDC2FACB6FB30D7DE24FCBC3AC183CBCC7B79BA6702F0EB4D51E8636C97660F82B35C3EA65E49D36B992173838B3171CE890A876F985E2A91A616D96FD276D98B55AFE7FB4D52AABEDD3DAEA52A71D75755E529B6CE8F2DA24B36F676D378DAF7A650604A6F00F0BA072922C3710FADF1758B2A80D6836E68CDDF14CE52A1E65432A69DF395608DE60D1B150E40EE4006EFB58CAF8C75D9F118D74DB205CE0E08C5D466A05A19012870B5AE29E56CA36FB7177AFECF3F87215FF5271174B0037897E09BF641F224283DCEF53436ADA00A12538CDA5F5B3543AA75EAE73A40BCE7A02A5E1CB4F8E1B1CAE2880C94B36439A42F6BEDD4AFC092F91BFCE0A6CCD20DD0FA21CF6F109414B814299626CE6C357E070103EBEFB0F97990F0CB7330000 , N'6.2.0-61023')
END

IF @CurrentMigration < '201804161840131_Add_sp_GetTotalWorkoutTimesReport'
BEGIN
    EXECUTE('
        
                        IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N''[dbo].[sp_GetTotalWorkoutTimesReport]'') and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
                        BEGIN
                          DROP PROCEDURE [dbo].[sp_GetTotalWorkoutTimesReport]
                        END
        
    ')
    CREATE PROCEDURE [dbo].[sp_GetTotalWorkoutTimesReport]
                    AS
                    BEGIN
    	                SELECT DATEPART(DAY,start_date) Duration, ISNULL(SUM(DATEDIFF(MINUTE, start_time, end_time)),0) AS TotalTimeInMinutes
    	                FROM [dbo].[workout_active]
    	                WHERE DATEPART(DAY, start_date) = DATEPART(DAY, GETDATE())
    	                GROUP BY DATEPART(DAY, start_date)
    
    	                SELECT DATEPART(WEEK, start_date) Duration, ISNULL(SUM(DATEDIFF(MINUTE, start_time, end_time)),0) AS TotalTimeInMinutes
    	                FROM [dbo].[workout_active]
    	                WHERE DATEPART(WEEK, start_date) = DATEPART(WEEK, GETDATE())
    	                GROUP BY DATEPART(WEEK, start_date)
    
    	                SELECT DATEPART(MONTH, start_date) Duration, ISNULL(SUM(DATEDIFF(MINUTE, start_time, end_time)),0) AS TotalTimeInMinutes
    	                FROM [dbo].[workout_active]
    	                WHERE DATEPART(MONTH, start_date) = DATEPART(MONTH, GETDATE())
    	                GROUP BY DATEPART(MONTH, start_date)
                    END
                
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201804161840131_Add_sp_GetTotalWorkoutTimesReport', N'WorkoutTracker.DAL.Migrations.Configuration',  0x1F8B0800000000000400D55BDB6EE336107D2FD07F10F45864AD24DB6EB781BD8BACB329826E2E88936DDF0C5A621C6229D225A93446D12FEB433FA9BFD0A16ED685BA50763629F2624BE499E1E8F07034E3FCFBF73FE3F78F21751EB09084B3897B30DA771DCC7C1E10B69CB891BA7BF5D67DFFEEDB6FC61F83F0D1F99C8D7BADC7C14C2627EEBD52AB23CF93FE3D0E911C85C4175CF23B35F279E8A1807B87FBFB3F7907071E060817B01C677C1D3145421C7F81AF53CE7CBC5211A2E73CC054A6D7E1CE2C46752E5088E50AF978E2FECAC5171EA91B81FC2F588C4E8E3FB9CE3125083C99617AE73A8831AE90023F8F6E259E29C1D972B6820B88DEAC5718C6DD212A71EAFFD16678DFA5EC1FEAA5789B8919941F49C5434BC083D7696CBCEAF4411176F3D841F43E4294D55AAF3A8E601EBC635F91078840D5E2D1940A3DBA16E5188860392A01EC390DC3F672A600A1F4DF9E338DA88A049E301C2981E89E73152D28F17FC1EB1BFE05B3098B282DFA0EDEC3BDD205B87425F80A0BB5BEC677A6159D05AEE39541BC2A4A8ED1049004E08CA9D787AE73016EA105C539690AC19A292EF0CF986181140EAE905258C0333F0B701CF69A2B66C3DD26DB61660A0975021E6430FAF30D6CAE5E139381C9C43E933EB260882D98666B69CAC31002994D817D0C92E43AE7E8F113664B753F71DF7CEF3AA7E41107D985345EB78C8080C11C25A23E515091CCAC7CE09C62C46A932ED00359C64FDDFC10A79C52EC279BF61AD378A4BC27AB4493CABB666E98732A7878CD69958EF5A1F3198F84AF03C9FB8DBF416289557941636F230C7DE4A2E8E960C9D880BC20D9D842309E412A6E88A2B865431C1CBEEDB5232C1526B57EC1559BF1C31FDEEC603B4E11E502A8F021124C5D61714E58AE35D82721A2AE7325E0539AAFC082673ED24BB157CE293C8B25176B6B05EE548314B84D0B0A5BB436ABA606CD839BF4A065C64E1421F775B81EA4102F410D8A4CB09583FE2CDA9D1E6436F5B7ED0FC856BA3731E3584AEE9378354D87458DD8E535414EE058B33C59AA711FC1D2811E640584007F27EE77B528DA58CC7689C162CEFDB2BD03B74AB44B76822956D839F693D78129923E0AEA8202310ECA57809B586832200A2F4712D84E98AA1399309FAC10B55D5505C8724F688773D3D53B27788599A6B1EDB3DDDEA7DC7425B85DB11C7B0532F7E2786322D7C1B7EEACAEC6B6EC55CD9ADB9D19A1CD5E7A31DCEE5A551F1635E67E4388DDF548B77668E7AC4EF41CE62898814525C54C0E617D173F2AC3F17E2B717AC2CBF4FCA8F250A3CFB032571C36878999E635561BD18A446D422C8EE9899A0B7B23663EA2825808758BB3F54CAF30AF777A5865C89073348F8031A435120E39380D269AA2E795C3D73FB4CD2FD48D81ED27DD83C4BBBE6233AB07A9B5CD136B096896CEE5DB7F536AF5925A6B5693F51A8AB2E373B45A41A65928D2A6579C5952A19DBE9AD9972EC304C3F3A5A182997B9B5B82FC192D71E5AE2E1A05F89408A90B62688174323B0DC2DA30B3D835884466D3A467F5E79A0947364B7F3629AC2E5C8F5AC136813D85B5EA5A58BC6CDC48B3DAFCB87E8E28125D254FA05214B2E4E61FC9CD394A18490C8752277213A61D58A1B2590493FAF23C88AF5B822575C73A9832D423DBC0F22A68110A4E696BAFF2BA6815C8D6A3BC5A5A04F2B38B56618ACBA19518C5D7EA2863AFC2D05AF652DB10B5E4B0BCCB6CF660AB780FD987CD80FDF7621BC657D935E55AA1094F25B7AC219302A00991713BDA1BAB7C25E6A603E60B183187A9F390181293360B9B37C532709AA69883FACC846E4EF106D1B901CE82CC8D083B8E7B175C52E83202326456CA277D94B534AA3A24B79EA75395B4699CA630DD0DEF5A4E930CD17570FE40029DCFCCD652E170A4078C66BFD32925B1EC6703CE11237758AAA448EA1EEE1F1C567AE62FA77FED4919509B26F680726F678AD35DF5354024AF8B4407BEB3BC6BD9A9289E040533B597F33316E0C789FB673CEDC839FB6DBE99B9E75C0AE0C291B3EFFC65ED4031E74A1CD09F93246503D5A7C1534CB812A4E473A1A9F3A32DE626F3DACEB74DE2B52BCFFC7213FB0109FF1E895A91DE3A848596F582A876802DBABD5BECAD6D36D557DA4DAAD84E353D9AB89F3A109C15BAA526ECB85D6A4926735294727ED7DDD1D2896D273A85A916AA33B8073980A52DE948374D9B22B36B9E56529CBE12F2CC4DBCBCC8F74C9DB3965AE5B6FDC3AD9A72CDC9B8153DB76BBEEDC2FACB6FB30D7DE24FCBC3AC183CBCC7B79BA6702F0EB4D51E8636C97660F82B35C3EA65E49D36B992173838B3171CE890A876F985E2A91A616D96FD276D98B55AFE7FB4D52AABEDD3DAEA52A71D75755E529B6CE8F2DA24B36F676D378DAF7A650604A6F00F0BA072922C3710FADF1758B2A80D6836E68CDDF14CE52A1E65432A69DF395608DE60D1B150E40EE4006EFB58CAF8C75D9F118D74DB205CE0E08C5D466A05A19012870B5AE29E56CA36FB7177AFECF3F87215FF5271174B0037897E09BF641F224283DCEF53436ADA00A12538CDA5F5B3543AA75EAE73A40BCE7A02A5E1CB4F8E1B1CAE2880C94B36439A42F6BEDD4AFC092F91BFCE0A6CCD20DD0FA21CF6F109414B814299626CE6C357E070103EBEFB0F97990F0CB7330000 , N'6.2.0-61023')
END

IF @CurrentMigration < '201804161841521_Add_sp_GetTotalCaloriesReport'
BEGIN
    EXECUTE('
        
                            IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N''[dbo].[sp_GetTotalCaloriesReport]'') and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
                            BEGIN
                              DROP PROCEDURE [dbo].[sp_GetTotalCaloriesReport]
                            END
        
    ')
    CREATE PROCEDURE sp_GetTotalCaloriesReport
                        AS
                        BEGIN
    	                    --Day
    	                    SELECT SUBSTRING(Duration, 1, 3) Duration, ISNULL(SUM(CaloriesBurnt),0) TotalCaloriesBurnt FROM 
    		                    (SELECT 
    			                    DATENAME(dw, start_date) Duration, 
    			                    (calories_burn_per_min * SUM(DATEDIFF(MINUTE, start_time, end_time))) CaloriesBurnt
    		                    FROM [dbo].[workout_collection] WC
    		                    JOIN [dbo].[workout_active] WA
    			                    ON WC.workout_id = WA.workout_id
    		                    WHERE WA.end_date IS NOT NULL AND WA.end_time IS NOT NULL
    		                    GROUP BY DATENAME(dw, start_date), calories_burn_per_min) AS TBL
    	                    GROUP BY DURATION
    
    	                    --Week
    	                    SELECT 'Week ' + CAST(Duration AS VARCHAR) Duration, ISNULL(SUM(CaloriesBurnt),0) TotalCaloriesBurnt FROM 
    		                    (SELECT 
    			                    DATEPART(WEEK, start_date)-DATEPART(WEEK, DATEADD(MM, DATEDIFF(MM,0, start_date), 0))+ 1 Duration, 
    			                    (calories_burn_per_min * SUM(DATEDIFF(MINUTE, start_time, end_time))) CaloriesBurnt
    		                    FROM [dbo].[workout_collection] WC
    		                    JOIN [dbo].[workout_active] WA
    			                    ON WC.workout_id = WA.workout_id
    		                    WHERE WA.end_date IS NOT NULL AND WA.end_time IS NOT NULL
    		                    GROUP BY DATEPART(WEEK, start_date)-DATEPART(WEEK, DATEADD(MM, DATEDIFF(MM,0, start_date), 0))+ 1, calories_burn_per_min) AS TBL
    	                    GROUP BY DURATION
    
    	                    --Year
    	                    SELECT 'Y' + CAST(Duration AS VARCHAR) Duration, ISNULL(SUM(CaloriesBurnt),0) TotalCaloriesBurnt FROM 
    		                    (SELECT 
    			                    DATEPART(MONTH, start_date) Duration, 
    			                    (calories_burn_per_min * SUM(DATEDIFF(MINUTE, start_time, end_time))) CaloriesBurnt
    		                    FROM [dbo].[workout_collection] WC
    		                    JOIN [dbo].[workout_active] WA
    			                    ON WC.workout_id = WA.workout_id
    		                    WHERE WA.end_date IS NOT NULL AND WA.end_time IS NOT NULL
    		                    GROUP BY DATEPART(MONTH, start_date), calories_burn_per_min) AS TBL
    	                    GROUP BY DURATION
                        END
                    
    INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
    VALUES (N'201804161841521_Add_sp_GetTotalCaloriesReport', N'WorkoutTracker.DAL.Migrations.Configuration',  0x1F8B0800000000000400D55BDB6EE336107D2FD07F10F45864AD24DB6EB781BD8BACB329826E2E88936DDF0C5A621C6229D225A93446D12FEB433FA9BFD0A16ED685BA50763629F2624BE499E1E8F07034E3FCFBF73FE3F78F21751EB09084B3897B30DA771DCC7C1E10B69CB891BA7BF5D67DFFEEDB6FC61F83F0D1F99C8D7BADC7C14C2627EEBD52AB23CF93FE3D0E911C85C4175CF23B35F279E8A1807B87FBFB3F7907071E060817B01C677C1D3145421C7F81AF53CE7CBC5211A2E73CC054A6D7E1CE2C46752E5088E50AF978E2FECAC5171EA91B81FC2F588C4E8E3FB9CE3125083C99617AE73A8831AE90023F8F6E259E29C1D972B6820B88DEAC5718C6DD212A71EAFFD16678DFA5EC1FEAA5789B8919941F49C5434BC083D7696CBCEAF4411176F3D841F43E4294D55AAF3A8E601EBC635F91078840D5E2D1940A3DBA16E5188860392A01EC390DC3F672A600A1F4DF9E338DA88A049E301C2981E89E73152D28F17FC1EB1BFE05B3098B282DFA0EDEC3BDD205B87425F80A0BB5BEC677A6159D05AEE39541BC2A4A8ED1049004E08CA9D787AE73016EA105C539690AC19A292EF0CF986181140EAE905258C0333F0B701CF69A2B66C3DD26DB61660A0975021E6430FAF30D6CAE5E139381C9C43E933EB260882D98666B69CAC31002994D817D0C92E43AE7E8F113664B753F71DF7CEF3AA7E41107D985345EB78C8080C11C25A23E515091CCAC7CE09C62C46A932ED00359C64FDDFC10A79C52EC279BF61AD378A4BC27AB4493CABB666E98732A7878CD69958EF5A1F3198F84AF03C9FB8DBF416289557941636F230C7DE4A2E8E960C9D880BC20D9D842309E412A6E88A2B865431C1CBEEDB5232C1526B57EC1559BF1C31FDEEC603B4E11E502A8F021124C5D61714E58AE35D82721A2AE7325E0539AAFC082673ED24BB157CE293C8B25176B6B05EE548314B84D0B0A5BB436ABA606CD839BF4A065C64E1421F775B81EA4102F410D8A4CB09583FE2CDA9D1E6436F5B7ED0FC856BA3731E3584AEE9378354D87458DD8E535414EE058B33C59AA711FC1D2811E640584007F27EE77B528DA58CC7689C162CEFDB2BD03B74AB44B76822956D839F693D78129923E0AEA8202310ECA57809B586832200A2F4712D84E98AA1399309FAC10B55D5505C8724F688773D3D53B27788599A6B1EDB3DDDEA7DC7425B85DB11C7B0532F7E2786322D7C1B7EEACAEC6B6EC55CD9ADB9D19A1CD5E7A31DCEE5A551F1635E67E4388DDF548B77668E7AC4EF41CE62898814525C54C0E617D173F2AC3F17E2B717AC2CBF4FCA8F250A3CFB032571C36878999E635561BD18A446D422C8EE9899A0B7B23663EA2825808758BB3F54CAF30AF777A5865C89073348F8031A435120E39380D269AA2E795C3D73FB4CD2FD48D81ED27DD83C4BBBE6233AB07A9B5CD136B096896CEE5DB7F536AF5925A6B5693F51A8AB2E373B45A41A65928D2A6579C5952A19DBE9AD9972EC304C3F3A5A182997B9B5B82FC192D71E5AE2E1A05F89408A90B62688174323B0DC2DA30B3D835884466D3A467F5E79A0947364B7F3629AC2E5C8F5AC136813D85B5EA5A58BC6CDC48B3DAFCB87E8E28125D254FA05214B2E4E61FC9CD394A18490C8752277213A61D58A1B2590493FAF23C88AF5B822575C73A9832D423DBC0F22A68110A4E696BAFF2BA6815C8D6A3BC5A5A04F2B38B56618ACBA19518C5D7EA2863AFC2D05AF652DB10B5E4B0BCCB6CF660AB780FD987CD80FDF7621BC657D935E55AA1094F25B7AC219302A00991713BDA1BAB7C25E6A603E60B183187A9F390181293360B9B37C532709AA69883FACC846E4EF106D1B901CE82CC8D083B8E7B175C52E83202326456CA277D94B534AA3A24B79EA75395B4699CA630DD0DEF5A4E930CD17570FE40029DCFCCD652E170A4078C66BFD32925B1EC6703CE11237758AAA448EA1EEE1F1C567AE62FA77FED4919509B26F680726F678AD35DF5354024AF8B4407BEB3BC6BD9A9289E040533B597F33316E0C789FB673CEDC839FB6DBE99B9E75C0AE0C291B3EFFC65ED4031E74A1CD09F93246503D5A7C1534CB812A4E473A1A9F3A32DE626F3DACEB74DE2B52BCFFC7213FB0109FF1E895A91DE3A848596F582A876802DBABD5BECAD6D36D557DA4DAAD84E353D9AB89F3A109C15BAA526ECB85D6A4926735294727ED7DDD1D2896D273A85A916AA33B8073980A52DE948374D9B22B36B9E56529CBE12F2CC4DBCBCC8F74C9DB3965AE5B6FDC3AD9A72CDC9B8153DB76BBEEDC2FACB6FB30D7DE24FCBC3AC183CBCC7B79BA6702F0EB4D51E8636C97660F82B35C3EA65E49D36B992173838B3171CE890A876F985E2A91A616D96FD276D98B55AFE7FB4D52AABEDD3DAEA52A71D75755E529B6CE8F2DA24B36F676D378DAF7A650604A6F00F0BA072922C3710FADF1758B2A80D6836E68CDDF14CE52A1E65432A69DF395608DE60D1B150E40EE4006EFB58CAF8C75D9F118D74DB205CE0E08C5D466A05A19012870B5AE29E56CA36FB7177AFECF3F87215FF5271174B0037897E09BF641F224283DCEF53436ADA00A12538CDA5F5B3543AA75EAE73A40BCE7A02A5E1CB4F8E1B1CAE2880C94B36439A42F6BEDD4AFC092F91BFCE0A6CCD20DD0FA21CF6F109414B814299626CE6C357E070103EBEFB0F97990F0CB7330000 , N'6.2.0-61023')
END
