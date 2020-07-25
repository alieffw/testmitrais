-- =============================================
-- Author:		<Alief Fitriyanto W,,Name>
-- Create date: <23 July 2020,,>
-- Description:	<Store procedure to save data in registration form,,>
-- =============================================
ALTER PROCEDURE SP_SaveRegistration 
	-- Add the parameters for the stored procedure here
	@PhoneNumber int,
	@FirstName varchar(max),
	@LastName varchar(max),
	@DateofBirth varchar(50),
	@Gender varchar(50),
	@Email varchar(max)
AS
BEGIN
	IF NOT EXISTS (SELECT @PhoneNumber FROM Registration where PhoneNumber=@PhoneNumber)
		BEGIN 
			INSERT INTO Registration 
			VALUES(
					@PhoneNumber,
					@FirstName,
					@LastName,
					@DateofBirth,
					@Gender,
					@Email,
					getdate()
			)
		END
	ELSE
		BEGIN			
			ROLLBACK TRAN
		END
END
GO