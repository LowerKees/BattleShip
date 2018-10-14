CREATE PROCEDURE [game].[PlaceBoats]
	@who SYSNAME
AS
	DECLARE
		@random INT,
		@boat INT;
		
	SELECT @random = game.udf_Random(1,6); -- Genereer random nummer tussen 0 en 5

	-- 77 is a boat coordinate for the player
	-- 66 is a boat coordinate for the opponent
	SET @boat = CASE @who WHEN 'player' THEN 77 WHEN 'opponent' THEN 66 ELSE NULL END;
	DECLARE @sql AS NVARCHAR(MAX);
	IF @random = 1 
		BEGIN
			SET @sql = '
			UPDATE sea
			SET col1 = CASE WHEN col1 IN (21,31) THEN @boat ELSE col1 END
				, col2 = CASE WHEN col2 IN (2) THEN @boat ELSE col2 END
				, col3 = CASE WHEN col3 IN (3, 23) THEN @boat ELSE col3 END
				, col4 = CASE WHEN col4 IN (4, 24) THEN @boat ELSE col4 END
				, col5 = CASE WHEN col5 IN (5, 25) THEN @boat ELSE col5 END
			FROM ' + @who + '.Sea as sea';

			EXEC sp_executesql 
				  @stmt = @sql
				, @params = N'@boat INT'
				, @boat = @boat;
		END;
		IF @random = 2 
		BEGIN
			SET @sql = '
			UPDATE sea
			SET col1 = CASE WHEN col1 IN (1, 11, 21, 41) THEN @boat ELSE col1 END
				, col2 = CASE WHEN col2 IN (12, 22, 42) THEN @boat ELSE col2 END
				, col3 = CASE WHEN col3 IN (43) THEN @boat ELSE col3 END
				, col4 = CASE WHEN col4 IN (44) THEN @boat ELSE col4 END
				, col5 = CASE WHEN col5 IN (0) THEN @boat ELSE col5 END
			FROM ' + @who + '.Sea as sea';

			EXEC sp_executesql 
				  @stmt = @sql
				, @params = N'@boat INT'
				, @boat = @boat;
		END;
		IF @random = 3
		BEGIN
			SET @sql = '
			UPDATE sea
			SET col1 = CASE WHEN col1 IN (21) THEN @boat ELSE col1 END
				, col2 = CASE WHEN col2 IN (2, 22) THEN @boat ELSE col2 END
				, col3 = CASE WHEN col3 IN (3, 23) THEN @boat ELSE col3 END
				, col4 = CASE WHEN col4 IN (4, 34) THEN @boat ELSE col4 END
				, col5 = CASE WHEN col5 IN (5, 35) THEN @boat ELSE col5 END
			FROM ' + @who + '.Sea as sea';

			EXEC sp_executesql 
				  @stmt = @sql
				, @params = N'@boat INT'
				, @boat = @boat;
		END;
		IF @random = 4
		BEGIN
			SET @sql = '
			UPDATE sea
			SET col1 = CASE WHEN col1 IN (31) THEN @boat ELSE col1 END
				, col2 = CASE WHEN col2 IN (32) THEN @boat ELSE col2 END
				, col3 = CASE WHEN col3 IN (33) THEN @boat ELSE col3 END
				, col4 = CASE WHEN col4 IN (14, 24, 34, 44) THEN @boat ELSE col4 END
				, col5 = CASE WHEN col5 IN (5, 15) THEN @boat ELSE col5 END
			FROM ' + @who + '.Sea as sea';

			EXEC sp_executesql 
				  @stmt = @sql
				, @params = N'@boat INT'
				, @boat = @boat;
		END;
		IF @random = 5
		BEGIN
			SET @sql = '
			UPDATE sea
			SET col1 = CASE WHEN col1 IN (31) THEN @boat ELSE col1 END
				, col2 = CASE WHEN col2 IN (2, 12, 22, 32) THEN @boat ELSE col2 END
				, col3 = CASE WHEN col3 IN (33) THEN @boat ELSE col3 END
				, col4 = CASE WHEN col4 IN (34) THEN @boat ELSE col4 END
				, col5 = CASE WHEN col5 IN (5, 15) THEN @boat ELSE col5 END
			FROM ' + @who + '.Sea as sea';

			EXEC sp_executesql 
				  @stmt = @sql
				, @params = N'@boat INT'
				, @boat = @boat;
		END;

