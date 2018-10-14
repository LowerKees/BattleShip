CREATE PROCEDURE [game].[PrintOutcome]
	@outcome NVARCHAR(10)
AS
BEGIN
	IF @outcome = 'draw'
	BEGIN
		PRINT '
	 _____ _____ _____    ___   ____________  ___  _    _ 
	|_   _|_   _/  ___|  / _ \  |  _  \ ___ \/ _ \| |  | |
	  | |   | | \ `--.  / /_\ \ | | | | |_/ / /_\ \ |  | |
	  | |   | |  `--. \ |  _  | | | | |    /|  _  | |/\| |
	 _| |_  | | /\__/ / | | | | | |/ /| |\ \| | | \  /\  /
	 \___/  \_/ \____/  \_| |_/ |___/ \_| \_\_| |_/\/  \/ 

';    
	END

	IF @outcome = 'win'
	BEGIN
		PRINT '			
	__   _______ _   _   _    _ _____ _   _ 
	\ \ / /  _  | | | | | |  | |_   _| \ | |
	 \ V /| | | | | | | | |  | | | | |  \| |
	  \ / | | | | | | | | |/\| | | | | . ` |
	  | | \ \_/ / |_| | \  /\  /_| |_| |\  |
	  \_/  \___/ \___/   \/  \/ \___/\_| \_/

';
	END

	IF @outcome = 'lose'
	BEGIN
		PRINT '
	__   _______ _   _   _     _____ _____ _____ 
	\ \ / /  _  | | | | | |   |  _  /  ___|  ___|
	 \ V /| | | | | | | | |   | | | \  --.| |__  
	  \ / | | | | | | | | |   | | | | --. \  __| 
	  | | \ \_/ / |_| | | |___\ \_/ /\__/ / |___ 
	  \_/  \___/ \___/  \_____/\___/\____/\____/ 

'; 
	END

	-- Print de laatste stand van de zee
	EXEC game.PrintSea;
	PRINT '';
	PRINT CONCAT(Char(9), 'BattleShip voor Sql Server');
	PRINT CONCAT(CHar(9), '(c) 2018 - Martijn Beenker');
END
