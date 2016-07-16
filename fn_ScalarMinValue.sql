CREATE FUNCTION dbo.ScalarMinValue
(@Value1 int, @Value2 int)
RETURNS int
BEGIN
	declare @return int	
	Select @return = Case When @Value1 < @Value2 Then @Value1 Else @Value2 End	
	return @return
END