CREATE PROCEDURE [game].[OpponentFiresCannon]
	@msg NVARCHAR(100) OUTPUT
AS
BEGIN
	DECLARE
		@coordinates_to_shoot INT;

	DECLARE
		@possibilities TABLE (poss INT NOT NULL, [coordinate_order] INT IDENTITY(1,1));

	-- Check for predefined next turns
	IF EXISTS (SELECT * FROM opponent.NextTurns)
		BEGIN
			PRINT 'Taking a predetermined turn';
		END

	-- If no next turns exist, take a guess
	-- select random column
	DECLARE @column INT;

	SELECT @column = game.udf_Random(1,6);

	-- select random row
	DECLARE @row INT;

	SELECT @row = game.udf_Random(1,6);

	-- check the coordinates
	-- and only accept them if
	-- the shot hasn't been taken
	-- before
	DECLARE 
		@sql AS NVARCHAR(max),
		@coordinates_aimed_at INT = 99;

	WHILE @coordinates_aimed_at IN (99, 999)
		BEGIN
			SET @sql = N'
				SELECT @coordinates_aimed_at_out = col' + CAST(@column AS NCHAR(1)) + '
				FROM player.Sea
				WHERE coordinate_order = ' + CAST(@row AS NCHAR(1)) + ';';

			EXEC sp_executesql @sql
				, N'@coordinates_aimed_at_out INT OUTPUT'
				, @coordinates_aimed_at_out = @coordinates_aimed_at OUTPUT;
		END

	-- take the shot
	DECLARE
		@sql_for_the_shot AS NVARCHAR(MAX),
		@value AS INT;

	SET @value = CASE WHEN @coordinates_aimed_at = 77 THEN 999 ELSE 99 END;

	SET @sql_for_the_shot = '
		UPDATE tgt
		SET tgt.col' + CAST(@column AS NCHAR(1)) + ' = ' + CAST(@value AS NVARCHAR(3)) + '
		FROM player.Sea AS tgt
		WHERE tgt.coordinate_order = ' + CAST(@row AS NCHAR(1)) + ';';
	
	EXEC sp_executesql @sql_for_the_shot;

	-- give some feedback
	SET @msg = CASE WHEN @coordinates_aimed_at = 77 
					THEN 'De kustwacht heeft een van je schepen geraakt!'
					ELSE 'De kustwacht schoot mis!'
			   END;
	RETURN;
END
