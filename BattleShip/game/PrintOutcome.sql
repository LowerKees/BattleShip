CREATE PROCEDURE [game].[PrintOutcome]
	@outcome NVARCHAR(10)
AS
BEGIN
	IF @outcome = 'draw'
	BEGIN
		EXEC game.PrintLogo;
		PRINT '
	 _____ _____ _____    ___   ____________  ___  _    _ 
	|_   _|_   _/  ___|  / _ \  |  _  \ ___ \/ _ \| |  | |
	  | |   | | \ `--.  / /_\ \ | | | | |_/ / /_\ \ |  | |
	  | |   | |  `--. \ |  _  | | | | |    /|  _  | |/\| |
	 _| |_  | | /\__/ / | | | | | |/ /| |\ \| | | \  /\  /
	 \___/  \_/ \____/  \_| |_/ |___/ \_| \_\_| |_/\/  \/ 
';    
		EXEC game.PrintSea;

	END

	IF @outcome = 'win'
	BEGIN
		EXEC game.PrintLogo;
		PRINT '			
	__   _______ _   _   _    _ _____ _   _ 
	\ \ / /  _  | | | | | |  | |_   _| \ | |
	 \ V /| | | | | | | | |  | | | | |  \| |
	  \ / | | | | | | | | |/\| | | | | . ` |
	  | | \ \_/ / |_| | \  /\  /_| |_| |\  |
	  \_/  \___/ \___/   \/  \/ \___/\_| \_/
';
		EXEC game.PrintSea;

	END

	IF @outcome = 'lose'
	BEGIN
		EXEC game.PrintLogo;
		PRINT '
	__   _______ _   _   _     _____ _____ _____ 
	\ \ / /  _  | | | | | |   |  _  /  ___|  ___|
	 \ V /| | | | | | | | |   | | | \  --.| |__  
	  \ / | | | | | | | | |   | | | | --. \  __| 
	  | | \ \_/ / |_| | | |___\ \_/ /\__/ / |___ 
	  \_/  \___/ \___/  \_____/\___/\____/\____/ 
'; 
		EXEC game.PrintSea;

	END
END
