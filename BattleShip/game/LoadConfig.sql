CREATE PROCEDURE [game].[LoadConfig]
AS
BEGIN
	-- Empty the table
	TRUNCATE TABLE [game].[Config];

	-- Insert base values 
	INSERT INTO game.Config (
		[coordinate]             
	)
	SELECT col1
	FROM player.Sea
	UNION ALL
	SELECT col2
	FROM player.Sea
	UNION ALL
	SELECT col3
	FROM player.Sea
	UNION ALL
	SELECT col4
	FROM player.Sea
	UNION ALL
	SELECT col5
	FROM player.Sea;

	-- Fill in the metadata
	UPDATE tgt
	SET is_left_upper_corner = CASE WHEN coordinate = 41 THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END
		, is_right_upper_corner = CASE WHEN coordinate = 45 THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END
		, is_left_lower_corner = CASE WHEN coordinate = 1 THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END
		, is_right_lower_corner = CASE WHEN coordinate = 5 THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END
		, is_left_boundary = CASE WHEN RIGHT(coordinate, 1) = 1 THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END
		, is_right_boundary = CASE WHEN RIGHT(coordinate, 1) = 5 THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END
		, is_top_boundary = CASE WHEN LEFT(coordinate, 1) = 4 THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END
		, is_bottom_boundary = CASE WHEN LEN(coordinate) = 1 THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END
	FROM game.Config AS tgt;
END