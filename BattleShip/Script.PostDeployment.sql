/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

EXEC dbo.BattleShip 'NewGame';

-- Load initial game state
TRUNCATE TABLE game.State;
INSERT INTO game.State (
	ind_block_move
)
VALUES (CAST(0 AS BIT));