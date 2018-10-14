CREATE PROCEDURE [game].[CalculateNextMoves]
	@column INT,
	@row INT
AS
BEGIN
	DECLARE 
		@possible_moves TABLE (possible_coordinate INT);

	DECLARE
		@coordinate AS INT;

	SET @coordinate = CAST(CONCAT(CAST(@column AS NVARCHAR(1)), CAST(@row AS NVARCHAR(1))) AS INT);

	-- Insert smart moves for hit
	-- For corner hits
	-- Left upper
	IF @coordinate IN (SELECT coordinate FROM game.config WHERE is_left_upper_corner = 1)
		BEGIN 
			INSERT INTO @possible_moves
			VALUES (42), (31);
		END
	-- Right upper
	IF @coordinate IN (SELECT coordinate FROM game.config WHERE is_right_upper_corner = 1)
		BEGIN 
			INSERT INTO @possible_moves
			VALUES (44), (35);
		END
	-- Left lower
	IF @coordinate IN (SELECT coordinate FROM game.config WHERE is_left_lower_corner = 1)
		BEGIN 
			INSERT INTO @possible_moves
			VALUES (2), (11);
		END
	-- Right lower
	IF @coordinate IN (SELECT coordinate FROM game.config WHERE is_right_lower_corner = 1)
		BEGIN 
			INSERT INTO @possible_moves
			VALUES (4), (15);
		END
	-- For left boundary hits
	IF @coordinate IN (SELECT coordinate FROM game.config WHERE is_left_boundary = 1)
		BEGIN 
			INSERT INTO @possible_moves
			VALUES (@coordinate - 10), (@coordinate + 1);
		END
	-- For right boundary hits
	IF @coordinate IN (SELECT coordinate FROM game.config WHERE is_right_boundary = 1)
		BEGIN 
			INSERT INTO @possible_moves
			VALUES (@coordinate - 10), (@coordinate - 1);
		END
	-- For upper boundary hits
	IF @coordinate IN (SELECT coordinate FROM game.config WHERE is_top_boundary = 1)
		BEGIN 
			INSERT INTO @possible_moves
			VALUES (@coordinate - 1), (@coordinate + 1), (@coordinate - 10);
		END
	-- For lower boundary hits
	IF @coordinate IN (SELECT coordinate FROM game.config WHERE is_bottom_boundary = 1)
		BEGIN 
			INSERT INTO @possible_moves
			VALUES (@coordinate - 1), (@coordinate + 1), (@coordinate + 10);
		END
	IF @coordinate IN (SELECT coordinate 
						FROM game.config 
						WHERE is_bottom_boundary = 0
						  AND is_top_boundary = 0
						  AND is_left_boundary = 0
						  AND is_right_boundary = 0
						  AND is_left_lower_corner = 0
						  AND is_left_upper_corner = 0
						  AND is_right_lower_corner = 0
						  AND is_right_upper_corner = 0)
		BEGIN
			INSERT INTO @possible_moves
			VALUES (@coordinate - 1), (@coordinate + 1), (@coordinate + 10), (@coordinate -10);
		END

	-- Insert from the table var
	-- into the actual table
	INSERT INTO opponent.NextMoves (
		next_move_column
		, next_move_row
		, next_move_order
		, ind_is_stale
	)
	SELECT 
		next_move_column = CASE 
							WHEN LEN(possible_coordinate) = 1 THEN possible_coordinate 
							ELSE CAST(LEFT(possible_coordinate, 1) AS INT) END
		, next_move_row = CASE 
							WHEN LEN(possible_coordinate) = 1 THEN 1
							ELSE CAST(RIGHT(possible_coordinate, 1) AS INT) END
		, game.udf_Random(1, 100)
		, CAST(0 AS BIT)							
	FROM @possible_moves;
END
