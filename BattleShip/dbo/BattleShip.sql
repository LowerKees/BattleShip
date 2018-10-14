CREATE PROCEDURE [dbo].[BattleShip]
	@input NVARCHAR(MAX)
AS
	IF UPPER(@input) IN ('MANUAL','MAN') EXEC game.PrintManual;
	IF UPPER(@input) IN ('NEWGAME','NEW GAME') EXEC game.NewGame;

	-- Schiet het kannon
	
	IF PATINDEX('%[0-9],[0-9]%', @input) > 0 
		BEGIN
			DECLARE 
				@ind_success BIT = 1,
				@msg NVARCHAR(100);

			EXEC game.FireCannon @input, @ind_success OUTPUT, @msg OUTPUT;

			-- Er ging iets mis
			IF @ind_success = CAST(0 AS BIT)
				BEGIN
					PRINT '-----';
					PRINT @msg;
					PRINT '-----';
					EXEC game.PrintSea;					
				END
			-- Het ging goed
		END
