with DistinctFullname as
(
    select distinct FullName
    from SEOM.dbo.Customers
),
NewData as
(
    select 'Bruce Bahadur Smith' as ErrFullName -- middle name
	union select 'Aruce Smith'	 --typo
    union select 'Aruce Smit' --QWERTY/AZERTY mixup
    union select 'Arude Asmith' --QWERTY/AZERTY mixup x2
)
-- select * from NewData
select DistinctFullname.FullName, NewData.ErrFullName
into #SampleData
from DistinctFullname
cross join NewData
where FullName is not null;




-- drop table #SampleData
-- select * from SEOM.dbo.Customers

select TOP 10 Fullname, ErrFullname,
    MDS.mdq.Similarity(Fullname, ErrFullname, 0, 0.85, 0) as Levenshtein,
    MDS.mdq.Similarity(Fullname, ErrFullname, 1, 0.85, 0) as Jaccard,
    MDS.mdq.Similarity(Fullname, ErrFullname, 2, 0.85, 0) as JaroWinkler,
    MDS.mdq.Similarity(Fullname, ErrFullname, 3, 0.85, 0) as LongestCommonSubsequence
from #SampleData  where ErrFullName = 'Arude Asmith' 
ORDER BY Levenshtein DESC ;

select TOP 10 Fullname, ErrFullname,
    MDS.mdq.Similarity(Fullname, ErrFullname, 0, 0.85, 0) as Levenshtein    
 from #SampleData  where ErrFullName = 'Arude Asmith' 
ORDER BY Levenshtein DESC ;


select TOP 10 * from #SampleData
