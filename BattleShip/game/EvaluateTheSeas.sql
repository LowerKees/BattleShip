CREATE PROCEDURE [game].[EvaluateTheSeas]
	@outcome NVARCHAR(10) OUTPUT
AS
BEGIN
	DECLARE
		@number_of_player_boats INT,
		@number_of_opponent_boats INT;

	SELECT @number_of_player_boats = COUNT(*) FROM (
		SELECT col1
		FROM player.Sea
		WHERE col1 = 77
		UNION ALL
		SELECT col2
		FROM player.Sea
		WHERE col2 = 77
		UNION ALL
		SELECT col3
		FROM player.Sea
		WHERE col3 = 77
		UNION ALL
		SELECT col4
		FROM player.Sea
		WHERE col4 = 77
		UNION ALL
		SELECT col5
		FROM player.Sea
		WHERE col5 = 77) AS src;

	SELECT @number_of_opponent_boats = COUNT(*) FROM (
		SELECT col1
		FROM opponent.Sea
		WHERE col1 = 66
		UNION ALL
		SELECT col2
		FROM opponent.Sea
		WHERE col2 = 66
		UNION ALL
		SELECT col3
		FROM opponent.Sea
		WHERE col3 = 66
		UNION ALL
		SELECT col4
		FROM opponent.Sea
		WHERE col4 = 66
		UNION ALL
		SELECT col5
		FROM opponent.Sea
		WHERE col5 = 66) AS src;

	IF @number_of_player_boats > 0 AND @number_of_opponent_boats > 0 BEGIN SET @outcome = 'ingame'; RETURN; END
	IF @number_of_player_boats = 0 AND @number_of_opponent_boats = 0 BEGIN SET @outcome = 'draw'; RETURN; END
	IF @number_of_player_boats > 0 AND @number_of_opponent_boats = 0 BEGIN SET @outcome = 'win'; RETURN; END
	IF @number_of_player_boats = 0 AND @number_of_opponent_boats > 0 BEGIN SET @outcome = 'lose'; RETURN; END
END
