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
		WHERE col1 = 77
		UNION ALL
		SELECT col3
		FROM player.Sea
		WHERE col1 = 77
		UNION ALL
		SELECT col4
		FROM player.Sea
		WHERE col1 = 77
		UNION ALL
		SELECT col5
		FROM player.Sea
		WHERE col1 = 77) AS src;

	SELECT @number_of_opponent_boats = COUNT(*) FROM (
		SELECT col1
		FROM opponent.Sea
		WHERE col1 = 77
		UNION ALL
		SELECT col2
		FROM opponent.Sea
		WHERE col1 = 77
		UNION ALL
		SELECT col3
		FROM opponent.Sea
		WHERE col1 = 77
		UNION ALL
		SELECT col4
		FROM opponent.Sea
		WHERE col1 = 77
		UNION ALL
		SELECT col5
		FROM opponent.Sea
		WHERE col1 = 77) AS src;

	IF @number_of_player_boats > 0 AND @number_of_opponent_boats > 0 SET @outcome = 'ingame'; RETURN;
	IF @number_of_player_boats = 0 AND @number_of_opponent_boats = 0 SET @outcome = 'draw'; RETURN;
	IF @number_of_player_boats > 0 AND @number_of_opponent_boats = 0 SET @outcome = 'win'; RETURN;
	IF @number_of_player_boats = 0 AND @number_of_opponent_boats > 0 SET @outcome = 'lose'; RETURN;
END
