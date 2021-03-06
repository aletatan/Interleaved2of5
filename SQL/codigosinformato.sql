
CREATE FUNCTION [dbo].barcodeVerificationCode(@Cadena NVARCHAR(100))
	RETURNS NVARCHAR(100)
AS

BEGIN

	DECLARE @codigo NVARCHAR(100) = ''
	DECLARE @valorx INT = 0
	DECLARE @cnt INT = 1;
	DECLARE @array AS TABLE (caracter CHAR, rowid INT)
	DECLARE @i INT = 0
	DECLARE @residuo INT = 0
	DECLARE @codigoVerificador INT = 0
	DECLARE @valor NVARCHAR(10) = ''
	
	IF(LEN(@Cadena) <= 0)
	BEGIN
		RETURN  ''
	END

	WHILE @cnt <= LEN(@Cadena)
	BEGIN
		DECLARE @pair INT
	   
		SET @pair = CAST(SUBSTRING(@Cadena, @cnt, 1) AS INT)
		
		INSERT INTO @array
		VALUES(@pair, @cnt)
		 
		SET @cnt = @cnt + 1;
	END
	
	WHILE @i < LEN(@Cadena)
	BEGIN
		
		IF(((@i + 1) % 2) = 0)
		BEGIN
			SELECT @valor = ISNULL((CAST(a.caracter AS INT) * 1), 0) FROM @array AS a WHERE a.rowid = @i + 1
		END
		ELSE
		BEGIN
			SELECT @valor = ISNULL((CAST(a.caracter AS INT) * 3), 0) FROM @array AS a WHERE a.rowid = @i + 1
		END
		
		SET @valorx = @valorx + (CASE @valor WHEN '' THEN 0 ELSE @valor END)
				
		SET @i = @i + 1
	END
	
	SET @residuo = @valorx % 10
	SET @codigoVerificador = 10 - @residuo
		
	SET @codigo = @Cadena + CAST(@codigoVerificador AS NVARCHAR(5))

	RETURN @codigo
END
GO