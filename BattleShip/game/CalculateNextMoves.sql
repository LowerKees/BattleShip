CREATE PROCEDURE [game].[CalculateNextMoves]
	@column INT,
	@row INT
AS
BEGIN
	DECLARE 
		@possible_moves TABLE (possible_coordinate INT);

	DECLARE @coordinate INT;

	-- De rij wijkt af van het daadwerkelijke coordinate
	-- dus hier vind correctie plaats.
	SET @coordinate = CAST(CONCAT(CAST(@row AS NVARCHAR(1)), CAST(@column AS NVARCHAR(1))) AS INT);

	-- Insert smart moves for hit
	-- For corner hits
	-- Left upper
	IF @coordinate IN (SELECT coordinate FROM game.config WHERE is_left_upper_corner = 1)
		BEGIN 
			INSERT INTO @possible_moves
			VALUES (52), (41);
		END
	ELSE
	-- Right upper
	IF @coordinate IN (SELECT coordinate FROM game.config WHERE is_right_upper_corner = 1)
		BEGIN 
			INSERT INTO @possible_moves
			VALUES (54), (45);
		END
	ELSE
	-- Left lower
	IF @coordinate IN (SELECT coordinate FROM game.config WHERE is_left_lower_corner = 1)
		BEGIN 
			INSERT INTO @possible_moves
			VALUES (12), (21);
		END
	ELSE
	-- Right lower
	IF @coordinate IN (SELECT coordinate FROM game.config WHERE is_right_lower_corner = 1)
		BEGIN 
			INSERT INTO @possible_moves
			VALUES (14), (25);
		END
	ELSE
	-- For left boundary hits
	IF @coordinate IN (SELECT coordinate FROM game.config WHERE is_left_boundary = 1)
		BEGIN 
			INSERT INTO @possible_moves
			VALUES (@coordinate - 10), (@coordinate + 1), (@coordinate + 10);
		END
	ELSE
	-- For right boundary hits
	IF @coordinate IN (SELECT coordinate FROM game.config WHERE is_right_boundary = 1)
		BEGIN 
			INSERT INTO @possible_moves
			VALUES (@coordinate - 10), (@coordinate - 1), (@coordinate + 10);
		END
	ELSE
	-- For upper boundary hits
	IF @coordinate IN (SELECT coordinate FROM game.config WHERE is_top_boundary = 1)
		BEGIN 
			INSERT INTO @possible_moves
			VALUES (@coordinate - 1), (@coordinate + 1), (@coordinate - 10);
		END
	ELSE
	-- For lower boundary hits
	IF @coordinate IN (SELECT coordinate FROM game.config WHERE is_bottom_boundary = 1)
		BEGIN 
			INSERT INTO @possible_moves
			VALUES (@coordinate - 1), (@coordinate + 1), (@coordinate + 10);
		END
	ELSE
	-- all others
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
		  next_move_row
		, next_move_column
		, next_move_order
		, ind_is_stale
	)
	SELECT 
		  next_move_row = CAST(LEFT(possible_coordinate, 1) AS INT)
		, next_move_column = CAST(RIGHT(possible_coordinate, 1) AS INT) 
		, game.udf_Random(1, 100)
		, CAST(0 AS BIT)							
	FROM @possible_moves;
END
