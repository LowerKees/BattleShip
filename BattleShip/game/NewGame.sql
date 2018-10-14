CREATE PROCEDURE [game].[NewGame]
AS
BEGIN
	SET NOCOUNT ON;
	TRUNCATE TABLE player.Sea;
	TRUNCATE TABLE opponent.Sea;
	TRUNCATE TABLE opponent.NextMoves;

	INSERT INTO player.Sea (
		col1,
		col2,
		col3,
		col4,
		col5,
		[coordinate_order]
	)
	VALUES 	(41,42,43,44,45,5),
			(31,32,33,34,35,4),
			(21,22,23,24,25,3),
			(11,12,13,14,15,2),
			(1,2,3,4,5,1);

	INSERT INTO opponent.Sea (
		col1,
		col2,
		col3,
		col4,
		col5,
		[coordinate_order]
	)
	VALUES 	(41,42,43,44,45,5),
			(31,32,33,34,35,4),
			(21,22,23,24,25,3),
			(11,12,13,14,15,2),
			(1,2,3,4,5,1);
	
	-- Laad de config tabel
	EXEC game.LoadConfig;

	-- Plaats de boten
	EXEC game.PlaceBoats @who='player';
	EXEC game.PlaceBoats @who='opponent';
	
	-- Toon de zeeen
	EXEC game.PrintSea;
END;