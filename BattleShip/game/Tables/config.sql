CREATE TABLE [game].[config] (
	[coordinate]            NVARCHAR(10) NOT NULL,
    [is_left_upper_corner]  BIT NOT NULL,
    [is_right_upper_corner] BIT NOT NULL,
    [is_left_lower_corner]  BIT NOT NULL,
    [is_right_lower_corner] BIT NOT NULL,
    [is_left_boundary]      BIT NOT NULL,
    [is_right_boundary]     BIT NOT NULL,
    [is_top_boundary]       BIT NOT NULL,
    [is_bottom_boundary]    BIT NOT NULL
);

