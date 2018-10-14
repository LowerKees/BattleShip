CREATE PROCEDURE [game].[PrintSea]
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE
		@col1 INT,
		@col2 INT,
		@col3 INT,
		@col4 INT,
		@col5 INT,
		@verticalLine NVARCHAR(100) = REPLICATE('-', 21),
		@leftMargin NVARCHAR(50) = REPLICATE(char(9), 4);

	-- Print the logo
	EXEC game.PrintLogo;

	-- Print player sea
	PRINT CONCAT(@leftMargin, 'JOUW VLOOT');
	PRINT CONCAT(@leftMargin, '----------');

	DECLARE print_player_sea CURSOR FAST_FORWARD 
	FOR
	SELECT col1, col2, col3, col4, col5
	FROM player.sea
	
	OPEN print_player_sea
	FETCH NEXT FROM print_player_sea
	INTO @col1, @col2, @col3, @col4, @col5;

	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT CONCAT(@leftMargin, @verticalLine);
		PRINT CONCAT(@leftMargin, '|'
				, CASE @col1 WHEN 99 THEN ' O ' WHEN 999 THEN ' X ' ELSE '   ' END, '|'
				, CASE @col2 WHEN 99 THEN ' O ' WHEN 999 THEN ' X ' ELSE '   ' END, '|'
				, CASE @col3 WHEN 99 THEN ' O ' WHEN 999 THEN ' X ' ELSE '   ' END, '|'
				, CASE @col4 WHEN 99 THEN ' O ' WHEN 999 THEN ' X ' ELSE '   ' END, '|'
				, CASE @col5 WHEN 99 THEN ' O ' WHEN 999 THEN ' X ' ELSE '   ' END, '|'
				);
			
		FETCH NEXT FROM print_player_sea
		INTO @col1, @col2, @col3, @col4, @col5;
	END 
	
	CLOSE print_player_sea;
	DEALLOCATE print_player_sea;

	PRINT CONCAT(@leftMargin, @verticalLine);

	-- Print opponent sea
	PRINT '';
	PRINT CONCAT(@leftMargin, 'VLOOT KUSTWACHT');
	PRINT CONCAT(@leftMargin, '---------------');

	DECLARE print_opponent_sea CURSOR FAST_FORWARD 
	FOR
	SELECT col1, col2, col3, col4, col5
	FROM opponent.sea
	
	OPEN print_opponent_sea
	FETCH NEXT FROM print_opponent_sea
	INTO @col1, @col2, @col3, @col4, @col5;

	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT CONCAT(@leftMargin, @verticalLine);
		PRINT CONCAT(@leftMargin, '|'
				, CASE @col1 WHEN 99 THEN ' O ' WHEN 999 THEN ' X ' ELSE '   ' END, '|'
				, CASE @col2 WHEN 99 THEN ' O ' WHEN 999 THEN ' X ' ELSE '   ' END, '|'
				, CASE @col3 WHEN 99 THEN ' O ' WHEN 999 THEN ' X ' ELSE '   ' END, '|'
				, CASE @col4 WHEN 99 THEN ' O ' WHEN 999 THEN ' X ' ELSE '   ' END, '|'
				, CASE @col5 WHEN 99 THEN ' O ' WHEN 999 THEN ' X ' ELSE '   ' END, '|'
				);
			
		FETCH NEXT FROM print_opponent_sea
		INTO @col1, @col2, @col3, @col4, @col5;
	END 
	
	CLOSE print_opponent_sea;
	DEALLOCATE print_opponent_sea;

	PRINT CONCAT(@leftMargin, @verticalLine);
END
