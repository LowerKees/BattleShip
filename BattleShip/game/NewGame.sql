CREATE PROCEDURE [game].[NewGame]
AS
BEGIN
	SET NOCOUNT ON;
	TRUNCATE TABLE player.Sea;
	TRUNCATE TABLE opponent.Sea;

	INSERT INTO player.Sea (
		col1,
		col2,
		col3,
		col4,
		col5
	)
	VALUES (41,42,43,44,45),
			(31,32,33,34,35),
			(21,22,23,24,25),
			(11,12,13,14,15),
			(1,2,3,4,5);

	INSERT INTO opponent.Sea (
		col1,
		col2,
		col3,
		col4,
		col5
	)
	VALUES (41,42,43,44,45),
			(31,32,33,34,35),
			(21,22,23,24,25),
			(11,12,13,14,15),
			(1,2,3,4,5);
	
	-- Toon de zeeen
	EXEC game.PrintSea;
END;