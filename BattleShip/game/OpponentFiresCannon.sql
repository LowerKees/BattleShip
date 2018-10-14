CREATE PROCEDURE [game].[OpponentFiresCannon]
	@msg NVARCHAR(100) OUTPUT
AS
BEGIN
	DECLARE
		@coordinates_to_shoot INT;

	-- Smart shot

	-- Check for predefined next turns
	IF EXISTS (SELECT * FROM opponent.NextMoves)
		BEGIN
			PRINT 'Smart Shot'
			DECLARE
				@sql_for_the_smart_shot AS NVARCHAR(MAX),
				@value_smart_shot AS INT,
				@column_smart_shot INT,
				@row_smart_shot INT,
				@coordinates_aimed_at_smart_shot INT,
				@sql_smart_shot NVARCHAR(max);

			-- Get the smart coordinates
			SELECT TOP(1) @column_smart_shot = next_move_column
				, @row_smart_shot = next_move_row + 1 -- correctie voor afwijking in regelaantallen
			FROM opponent.NextMoves
			ORDER BY next_move_order ASC;

			-- Vind de waarde waarop geschoten wordt
			SET @sql_smart_shot = N'
				SELECT @coordinates_aimed_at_out = col' + CAST(@column_smart_shot AS NCHAR(1)) + '
				FROM player.Sea
				WHERE coordinate_order = ' + CAST(@row_smart_shot AS NCHAR(1)) + ';';

			EXEC sp_executesql @sql_smart_shot
				, N'@coordinates_aimed_at_out INT OUTPUT'
				, @coordinates_aimed_at_out = @coordinates_aimed_at_smart_shot OUTPUT;

			PRINT '@coordinates_aimed_at_smart_shot: ' + CAST(@coordinates_aimed_at_smart_shot AS NVARCHAR(10));
						PRINT '@column_smart_shot: ' + CAST(@column_smart_shot AS NVARCHAR(10));
			PRINT '@row_smart_shot: ' + CAST(@row_smart_shot AS NVARCHAR(10));
			PRINT '@row_smart_shot - 1: ' + CAST(@row_smart_shot - 1 AS NVARCHAR(10));

			SET @value_smart_shot = CASE WHEN @coordinates_aimed_at_smart_shot = 77 THEN 999 ELSE 99 END;

			SET @sql_for_the_smart_shot = '
				UPDATE tgt
				SET tgt.col' + CAST(@column_smart_shot AS NCHAR(1)) + ' = ' + CAST(@value_smart_shot AS NVARCHAR(3)) + '
				FROM player.Sea AS tgt
				WHERE tgt.coordinate_order = ' + CAST(@row_smart_shot AS NCHAR(1)) + ';';
			
			EXEC sp_executesql @sql_for_the_smart_shot;

			-- give some feedback
			SET @msg = CASE WHEN @coordinates_aimed_at_smart_shot = 77 
							THEN 'De kustwacht heeft een van je schepen geraakt!'
							ELSE 'De kustwacht schoot mis!'
					   END;

			-- Delete the suggestion from the 
			-- Next Moves table
			PRINT 'Now deleting with following values'
			PRINT '@column_smart_shot: ' + CAST(@column_smart_shot AS NVARCHAR(10));
			PRINT '@row_smart_shot: ' + CAST(@row_smart_shot AS NVARCHAR(10));
			PRINT '@row_smart_shot - 1: ' + CAST(@row_smart_shot - 1 AS NVARCHAR(10));

			DELETE 
			FROM opponent.NextMoves
			WHERE next_move_column = @column_smart_shot
			  AND next_move_row = @row_smart_shot - 1;

				-- If a hit has been made, the 
				-- engine should calculate the next 
				-- moves.
				IF @coordinates_aimed_at_smart_shot = 77
					BEGIN
						EXEC game.CalculateNextMoves @column_smart_shot, @row_smart_shot;
					END
			RETURN;
		END

	-- Dumb shot:
	PRINT 'Dumb shot'
	-- check the coordinates and only accept them if
	-- the shot hasn't been taken before
	DECLARE 
		@sql AS NVARCHAR(max),
		@coordinates_aimed_at INT = 99;

	WHILE @coordinates_aimed_at IN (99, 999)
		BEGIN
			-- If no next turns exist, take a guess
			-- select random column
			DECLARE @column INT;

			SELECT @column = game.udf_Random(1,6);

			-- select random row
			DECLARE @row INT;

			SELECT @row = game.udf_Random(1,6);

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

	-- If a hit has been made, the 
	-- engine should calculate the next 
	-- moves.
	IF @coordinates_aimed_at = 77
		BEGIN
			EXEC game.CalculateNextMoves @column, @row;
		END
	RETURN;
END
