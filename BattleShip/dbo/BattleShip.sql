CREATE PROCEDURE [dbo].[BattleShip]
	@input NVARCHAR(MAX)
AS
	IF UPPER(@input) IN ('MANUAL','MAN') EXEC game.PrintManual;
	IF UPPER(@input) IN ('NEWGAME','NEW GAME') EXEC game.NewGame;
