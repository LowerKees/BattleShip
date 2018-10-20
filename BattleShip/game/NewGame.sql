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
	VALUES 	(51,52,53,54,55,5),
			(41,42,43,44,45,4),
			(31,32,33,34,35,3),
			(21,22,23,24,25,2),
			(11,12,13,14,15,1);

	INSERT INTO opponent.Sea (
		col1,
		col2,
		col3,
		col4,
		col5,
		[coordinate_order]
	)
	VALUES 	(51,52,53,54,55,5),
			(41,42,43,44,45,4),
			(31,32,33,34,35,3),
			(21,22,23,24,25,2),
			(11,12,13,14,15,1);
	
	-- Laad de config tabel
	EXEC game.LoadConfig;

	-- Laad de juiste state
	EXEC game.SetState @ind_block_move = 0;

	-- Plaats de boten
	EXEC game.PlaceBoats @who='player';
	EXEC game.PlaceBoats @who='opponent';
	
	-- Toon de zeeen
	EXEC game.PrintSea;
END;