CREATE FUNCTION dbo.CalculateLevenshteinValue(@source nvarchar(max), @target nvarchar(max))
RETURNS int
BEGIN  
     declare @sourceLength int, @targetLength int

     set @sourceLength = len(@source);
     set @targetLength = len(@target);

     declare @array table ( i int, j int, value int);
     declare @i int, @j int, @result int

     set @i = 0;
     set @j = 0;

     WHILE @i <= @sourceLength
     BEGIN
	     insert @array( i, j, [value])
	     values( @i, 0, @i) 
  	     SET @i = @i + 1;
     END
     WHILE @j <= @targetLength
     BEGIN
	     insert @array ( i, j, [value])
	     values ( 0, @j, @j) 
  	     SET @j = @j + 1;
     END

     set @i = 1;
     set @j = 1;

     declare @equal int, @minInsert int, @minDelete int;
	 declare @minInterchange int, @equalValue int, @insertValue int
     declare @sourceChar nvarchar(1), @targetChar nvarchar(1)

     WHILE @i <= @sourceLength
     BEGIN
	     WHILE @j <= @targetLength
	     BEGIN
		     SET @sourceChar = substring(@source, @i, 1);		
		     SET @targetChar = substring(@target, @j, 1);
		     SET @equal = 2;
		     if(@sourceChar = @targetChar)
		     begin
			     SET @equal = 0;	
		     end
		     select @minInsert = value + 1 
                     from @array a where a.i = @i - 1 and a.j = @j
		     select @minDelete = value + 1 
                     from @array a 
                     where a.i = @i and a.j = @j - 1
		     select @minInterchange = [value] + @equal 
                     from @array a 
                     where a.i = @i - 1 and a.j = @j - 1
		     select @insertValue = 
                     dbo.ScalarMinValue(dbo.ScalarMinValue(@minInsert, @minDelete), @minInterchange)
		     insert @array ( i, j, [value])
		     values ( @i, @j, @insertValue) 
	  	     SET @j = @j + 1;
	     END
	     SET @i = @i + 1;
	     SET @j = 1
     END
     select @result = [value] 
     from @array a 
     where a.i = @sourceLength and a.j = @targetLength
RETURN @result;
END;
