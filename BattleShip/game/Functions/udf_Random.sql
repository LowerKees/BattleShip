CREATE FUNCTION [game].[udf_Random]
(
	@lowerLimit int,
	@upperLimit int
)
RETURNS INT AS
BEGIN
	DECLARE
		@return AS INT;

	SELECT @return = FLOOR(Random * (@upperLimit - @lowerLimit) + @lowerLimit)
	FROM game.Random
	RETURN @return;
END
