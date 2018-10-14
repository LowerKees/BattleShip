CREATE PROCEDURE [dbo].[BattleShip]
	@input NVARCHAR(MAX)
AS
	SET NOCOUNT ON;

	IF UPPER(@input) IN ('MANUAL','MAN') EXEC game.PrintManual;
	IF UPPER(@input) IN ('NEWGAME','NEW GAME') EXEC game.NewGame;

	-- Schiet het kannon
	
	IF PATINDEX('%[0-9],[0-9]%', @input) > 0 
		BEGIN
			DECLARE 
				@ind_success BIT = 1,
				@msg NVARCHAR(100),
				@outcome NVARCHAR(10),
				@leftMargin NVARCHAR(100) = REPLICATE(char(9), 1);

			EXEC game.FireCannon @input, @ind_success OUTPUT, @msg OUTPUT;

			-- Er ging iets mis
			IF @ind_success = CAST(0 AS BIT)
				BEGIN
					PRINT CONCAT(@leftMargin, '--------------------------------------------------');
					PRINT CONCAT(@leftMargin, @msg);
					PRINT CONCAT(@leftMargin, '--------------------------------------------------');
					EXEC game.PrintSea;					
				END
			-- Het ging goed
			IF @ind_success = CAST(1 AS BIT)
				BEGIN
					PRINT CONCAT(@leftMargin, '--------------------------------------------------');
					PRINT CONCAT(@leftMargin, @msg);
					PRINT CONCAT(@leftMargin, '--------------------------------------------------');
					
					-- Beurt is nu aan de kustwacht
					PRINT CONCAT(@leftMargin, 'De kustwacht sloeg terug...');
					EXEC game.OpponentFiresCannon @msg OUTPUT;
					PRINT CONCAT(@leftMargin, '--------------------------------------------------');
					PRINT CONCAT(@leftMargin, @msg);
					PRINT CONCAT(@leftMargin, '--------------------------------------------------');
					
					-- Hier evalueren of player heeft gewonnen of verloren
					EXEC game.EvaluateTheSeas @outcome OUTPUT;

					-- Print de zeeen als nog niemand heeft gewonnen
					IF @outcome = 'ingame' EXEC game.PrintSea;	
					ELSE EXEC game.PrintOutcome @outcome;
				END
		END
