CREATE TABLE [opponent].[NextMoves]
(
	next_move_row INT NOT NULL,
	next_move_column INT NOT NULL,
	next_move_order INT NOT NULL,
	ind_is_stale BIT NOT NULL
)
