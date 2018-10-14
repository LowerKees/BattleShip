CREATE PROCEDURE [game].[FireCannon]
	@coordinates NVARCHAR(100),
	@ind_success BIT OUTPUT,
	@msg NVARCHAR(100) OUTPUT
AS
BEGIN
	DECLARE
		@column INT,
		@row INT,
		@i INT,
		@leftMargin NVARCHAR(100) = REPLICATE(char(9), 1);

	-- extract coordinates from input string
	SELECT @i = CHARINDEX(',', @coordinates);
	SELECT @column = TRY_PARSE(SUBSTRING(@coordinates, 1, @i - 1) AS INT);
	SELECT @row = TRY_PARSE(SUBSTRING(@coordinates, @i + 1, LEN(@coordinates) - @i) AS INT);

	SET @msg = '';

	-- validate the input string
	IF (@column IS NULL OR @column > 5)
	BEGIN
		SET @ind_success = CAST(0 AS BIT);
		SET @msg += @leftMargin + 'De ingevoerde kolom bestaat niet. ';
	END
	IF (@row IS NULL OR @row > 5)
	BEGIN
		SET @ind_success = CAST(0 AS BIT);
		SET @msg += @leftMargin + 'De ingevoerde rij bestaat niet. '
	END

	-- complete failure message
	IF @ind_success = CAST(0 AS BIT)
	BEGIN
		SET @msg += 'Probeer opnieuw.';
		RETURN;
	END

	-- update the sea of the opponent
	DECLARE 
		@sql AS NVARCHAR(MAX),
		@column_txt AS NVARCHAR(100),
		@row_txt AS NVARCHAR(100) = CAST(@row AS NVARCHAR(100));

	SET @column_txt = CONCAT('col', CAST(@column AS NVARCHAR(100)));

	-- Determine type of outcome
	DECLARE 
		@outcome INT;

	SET @sql = '
	WITH CTE AS (
		SELECT ' + @column_txt + ' as col
			, ROW_NUMBER() OVER (ORDER BY [order] ASC) AS rn
		FROM opponent.Sea
	)
	
	SELECT @outcome_out = col
	FROM CTE
	WHERE rn = ' + @row_txt + ';'

	EXEC sp_executesql @sql
		, N'@outcome_out INT OUTPUT'
		, @outcome_out = @outcome OUTPUT;

	SET @msg = CASE WHEN @outcome = 66 THEN 'Je schot was raak!'
					WHEN @outcome = 99 THEN 'Hier schoot je eerder ook al mis!'
					WHEN @outcome = 999 THEN 'Hier schoot je eerder al raak!'
					ELSE 'Je schot raakte niets dan water...'
					END;

	-- fire the cannon!
	SET @sql = '
	WITH CTE AS (
		SELECT ' + @column_txt + ' as col
			, ROW_NUMBER() OVER (ORDER BY [order] ASC) AS rn
		FROM opponent.Sea
	)
	
	UPDATE CTE
	SET col = CASE WHEN col = 66 THEN 999 ELSE 99 END
	WHERE rn = ' + @row_txt + ';';

	EXEC sp_executesql @sql;
	RETURN;
END