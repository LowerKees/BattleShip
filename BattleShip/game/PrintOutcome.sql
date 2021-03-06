﻿CREATE PROCEDURE [game].[PrintOutcome]
	@outcome NVARCHAR(10)
AS
BEGIN
	IF @outcome = 'draw'
	BEGIN
		PRINT '
	 _____  _____ _     _____   ___ _   __ ___________ _____ _     
	|  __ \|  ___| |   |_   _| |_  | | / //  ___| ___ \  ___| |    
	| |  \/| |__ | |     | |     | | |/ / \ `--.| |_/ / |__ | |    
	| | __ |  __|| |     | |     | |    \  `--. \  __/|  __|| |    
	| |_\ \| |___| |_____| |_/\__/ / |\  \/\__/ / |   | |___| |____
	 \____/\____/\_____/\___/\____/\_| \_/\____/\_|   \____/\_____/

';    
	END

	IF @outcome = 'win'
	BEGIN
		PRINT '			
	   ___ _____   ___   _    _ _____ _   _ _____ _ 
	  |_  |_   _| |_  | | |  | |_   _| \ | |_   _| |
	    | | | |     | | | |  | | | | |  \| | | | | |
	    | | | |     | | | |/\| | | | | . ` | | | | |
	/\__/ /_| |_/\__/ / \  /\  /_| |_| |\  | | | |_|
	\____/ \___/\____/   \/  \/ \___/\_| \_/ \_/ (_)
                                                
';
	END

	IF @outcome = 'lose'
	BEGIN
		PRINT '
	 _   _ ___________ _     ___________ _____ _   _ 
	| | | |  ___| ___ \ |   |  _  | ___ \  ___| \ | |
	| | | | |__ | |_/ / |   | | | | |_/ / |__ |  \| |
	| | | |  __||    /| |   | | | |    /|  __|| . ` |
	\ \_/ / |___| |\ \| |___\ \_/ / |\ \| |___| |\  |
	 \___/\____/\_| \_\_____/\___/\_| \_\____/\_| \_/

'; 
	END

	-- Print de laatste stand van de zee
	EXEC game.PrintSea;
	PRINT '';
	PRINT CONCAT(CHAR(9), 'BattleShip voor Sql Server');
	PRINT CONCAT(CHAR(9), '(c) 2018 - Martijn Beenker');
	PRINT CONCAT(CHAR(9), '--------------------------');
	PRINT CONCAT(CHAR(9), 'Special thanks to the ASCII');
	PRINT CONCAT(CHAR(9), 'ART GENERATOR at:');
	PRINT CONCAT(CHAR(9), 'http://patorjk.com/software/taag/');
END
