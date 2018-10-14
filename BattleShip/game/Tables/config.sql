CREATE TABLE [game].[config] (
	[coordinate]            INT NOT NULL,
    [is_left_upper_corner]  BIT		NULL,
    [is_right_upper_corner] BIT		NULL,
    [is_left_lower_corner]  BIT		NULL,
    [is_right_lower_corner] BIT		NULL,
    [is_left_boundary]      BIT		NULL,
    [is_right_boundary]     BIT		NULL,
    [is_top_boundary]       BIT		NULL,
    [is_bottom_boundary]    BIT		NULL
);

