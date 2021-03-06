

CREATE FUNCTION [dbo].Interleaved2of5(@Cadena NVARCHAR(100))
	RETURNS NVARCHAR(100)
AS

BEGIN

	DECLARE @result NVARCHAR(100) = ''
	DECLARE @codigo NVARCHAR(100) = ''
	DECLARE @cnt INT = 1;
	
	IF(LEN(@Cadena) <= 0)
	BEGIN
		RETURN ''
	END

	IF(LEN(@Cadena) % 2 != 0)
	BEGIN
		SET @Cadena = '0' + @Cadena
	END
	
	WHILE @cnt <= LEN(@Cadena)
	BEGIN
	   DECLARE @pair INT
   
	   SET @pair = CAST(SUBSTRING(@Cadena, @cnt, 2) AS INT)
    
	   IF(@pair <= 93)
	   BEGIN
   			SET @pair = @pair  + 33;
	   END
	   ELSE IF(@pair = 99)
	   BEGIN
			SET @pair = @pair + 113;
	   END
	   ELSE IF(@pair = 98)
	   BEGIN
			SET @pair = @pair + 30;
	   END
	   ELSE IF(@pair = 97)
	   BEGIN
			SET @pair = @pair + 49;
	   END
	   ELSE IF(@pair >= 95)
	   BEGIN
			SET @pair = @pair + 47;
	   END
	   ELSE IF(@pair = 94)
	   BEGIN
			SET @pair = @pair + 105;
	   END
	   ELSE IF(@pair > 93)
	   BEGIN
   			SET @pair = @pair + 101;
	   END
      
	   SET @result = @result + CHAR(@pair)
     
	   SET @cnt = @cnt + 2;
	END
	
	SET @codigo = CHAR(144) + @result + CHAR(210)
	
	RETURN @codigo;

END
GO