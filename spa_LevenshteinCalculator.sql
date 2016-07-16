-- USAGE :  exec LevenshteinCalculator @source='lay'

CREATE procedure LevenshteinCalculator
@source nvarchar(256)
as
	select dbo.CalculateLevenshteinValue(@source,Words) Levenshtein, Words 
	from Words wout
	where dbo.CalculateLevenshteinValue(@source,Words) = (
	select MIN(m.Levenshtein)
	from
	(select dbo.CalculateLevenshteinValue(@source,Words) Levenshtein, Words 
	from Words w) m)
go