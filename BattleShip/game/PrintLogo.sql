CREATE PROCEDURE [game].[PrintLogo]
AS
BEGIN
	DECLARE
		@printLabel AS NVARCHAR(MAX),
		@starLine AS NVARCHAR(80);

	SET @printLabel = 
	'
	______       _   _   _        _____ _     _       
	| ___ \     | | | | | |      /  ___| |   (_)      
	| |_/ / __ _| |_| |_| | ___  \ `--.| |__  _ _ __  
	| ___ \/ _` | __| __| |/ _ \  `--. \  _ \| |  _ \ 
	| |_/ / (_| | |_| |_| |  __/ /\__/ / | | | | |_) |
	\____/ \__,_|\__|\__|_|\___| \____/|_| |_|_| .__/ 
	                                           | |    
	                                           |_|    
	';
	SET @starLine = CONCAT(char(9), REPLICATE('-', 50));

	PRINT @starLine;
	PRINT @printLabel;
	PRINT @starLine;
END;
