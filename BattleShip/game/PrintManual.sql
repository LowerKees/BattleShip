CREATE PROCEDURE [game].[PrintManual]
AS
BEGIN
	EXEC game.PrintLogo;

	DECLARE
		@leftMargin NVARCHAR(100) = REPLICATE(char(9), 1);

	PRINT CONCAT(@leftMargin, '');
	PRINT CONCAT(@leftMargin, 'SPELUITLEG');
	PRINT CONCAT(@leftMargin, '-----------');
	PRINT CONCAT(@leftMargin, '');
	PRINT CONCAT(@leftMargin, 'ALGEMEEN');
	PRINT CONCAT(@leftMargin, '-------');
	PRINT CONCAT(@leftMargin, 'Als een van de weinige Nederlandse piraten');
	PRINT CONCAT(@leftMargin, 'maken jij en je bemanning al jarenlang de');
	PRINT CONCAT(@leftMargin, 'Waddenzee onveilig.');
	PRINT CONCAT(@leftMargin, '');
	PRINT CONCAT(@leftMargin, 'Vorige week begon de Nederlandse kustwacht');
	PRINT CONCAT(@leftMargin, 'een nieuwe campagne om jouw vloot tot zinken');
	PRINT CONCAT(@leftMargin, 'te brengen. Hiervoor hebben ze hun eigen vloot');
	PRINT CONCAT(@leftMargin, 'ingezet.');
	PRINT CONCAT(@leftMargin, '');
	PRINT CONCAT(@leftMargin, 'De enige manier om te overleven, is om terug te');
	PRINT CONCAT(@leftMargin, 'vechten...');
	PRINT CONCAT(@leftMargin, '');
	PRINT CONCAT(@leftMargin, 'SPELREGELS');
	PRINT CONCAT(@leftMargin, '----------');
	PRINT CONCAT(@leftMargin, 'Zink alle schepen van de kustwacht om het spel');
	PRINT CONCAT(@leftMargin, 'te winnen. Je verliest als de kustwacht jouw');
	PRINT CONCAT(@leftMargin, 'vloot weet te zinken voor het eind van het spel');
	PRINT CONCAT(@leftMargin, '');
	PRINT CONCAT(@leftMargin, 'Zowel de kustwachtvloot als jouw eigen vloot');
	PRINT CONCAT(@leftMargin, 'kennen drie schepen. Eentje met een lengte van');
	PRINT CONCAT(@leftMargin, 'twee eenheden, eentje van drie, en een van vier.');
	PRINT CONCAT(@leftMargin, '');
	PRINT CONCAT(@leftMargin, 'COMMANDOS');
	PRINT CONCAT(@leftMargin, '---------');
	PRINT CONCAT(@leftMargin, 'Nieuw spel: BattleShip ''NewGame''');
	PRINT CONCAT(@leftMargin, 'Afvuren kannon: BattleShip ''<int>,<int>''');
	PRINT CONCAT(@leftMargin, char(9), '- het linker coordinaat geeft de ');
	PRINT CONCAT(@leftMargin, char(9), '  breedtegraad (kolom) aan.');
	PRINT CONCAT(@leftMargin, char(9), '- het rechter coordinaat geeft de ');
	PRINT CONCAT(@leftMargin, char(9), '  hoogtegraad (rij) aan.');
	PRINT CONCAT(@leftMargin, '');
	PRINT CONCAT(@leftMargin, 'SYMBOLEN');
	PRINT CONCAT(@leftMargin, '---------');
	PRINT CONCAT(@leftMargin, char(9), '- S: eigen schip');
	PRINT CONCAT(@leftMargin, char(9), '- O: geschoten & gemist');
	PRINT CONCAT(@leftMargin, char(9), '- X: geschoten & geraakt');
END
