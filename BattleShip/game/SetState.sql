CREATE PROCEDURE [game].[SetState]
	@ind_block_move BIT = 0
AS
	BEGIN TRY
		UPDATE game.State
		SET ind_block_move = @ind_block_move;
	END TRY
	BEGIN CATCH
		PRINT 'Fatal error: game state could not be altered.';
		PRINT 'Please restart the game.';
		PRINT ERROR_MESSAGE();
	END CATCH
RETURN;
