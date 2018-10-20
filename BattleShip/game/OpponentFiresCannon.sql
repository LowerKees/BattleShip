CREATE PROCEDURE [game].[OpponentFiresCannon]
	@msg NVARCHAR(100) OUTPUT
AS
BEGIN
	DECLARE
		@coordinates_to_shoot INT;

	-- Preventing double shooting at coordinate
	DECLARE
		@shot_coordinates TABLE (coordinates INT NOT NULL);

	INSERT INTO @shot_coordinates (coordinates)
	SELECT coordinate_order * 10 + 1
	FROM player.Sea
	WHERE col1 IN (99, 999)
	UNION ALL
	SELECT coordinate_order * 10 + 2
	FROM player.Sea
	WHERE col2 IN (99, 999)
	UNION ALL
	SELECT coordinate_order * 10 + 3
	FROM player.Sea
	WHERE col3 IN (99, 999)
	UNION ALL
	SELECT coordinate_order * 10 + 4
	FROM player.Sea
	WHERE col4 IN (99, 999)
	UNION ALL
	SELECT coordinate_order * 10 + 5
	FROM player.Sea
	WHERE col5 IN (99, 999);

	-- Smart shot
	-- Delete already shot possibilities
	DELETE moves
	FROM opponent.NextMoves AS moves
	JOIN @shot_coordinates AS shot
		ON shot.coordinates = moves.next_move_row * 10 + moves.next_move_column;
	-- Check for predefined next turns
	IF EXISTS (SELECT * FROM opponent.NextMoves)
		BEGIN
			DECLARE
				@sql_for_the_smart_shot NVARCHAR(MAX),
				@value_smart_shot INT,
				@column_smart_shot INT,
				@row_smart_shot INT,
				@coordinates_aimed_at_smart_shot INT,
				@sql_smart_shot NVARCHAR(max);

			-- Get the smart coordinates
			SELECT TOP(1) @column_smart_shot = next_move_column
				, @row_smart_shot = next_move_row
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

			-- Als ze een schip raken, zet dan de waarde op 
			-- 999 (geraakt schip), en anders op 99 (gemist schot)
			SET @value_smart_shot = CASE WHEN @coordinates_aimed_at_smart_shot in (77, 999) THEN 999 ELSE 99 END;

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
			DELETE 
			FROM opponent.NextMoves
			WHERE next_move_column = @column_smart_shot
			  AND next_move_row = @row_smart_shot;

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
