# FuzzyEntityMatch

Implementing various fuzzy match algorithms to find the duplicate names in the customer database.


e.g 


Fullname	        ErrFullname	Levenshtein	  Jaccard	    JaroWinkler	LongestCommonSubsequence


Bruce Smith	      Arude Asmith	0.75	      0.361013986	0.856060606	0.760227273


Carole A Smith	  Arude Asmith	0.714285714	0.401785714	0.849206349	0.732142857


Wade Smith	      Arude Asmith	0.666666667	0.47	      0.883333333	0.7725


Andre Smith	      Arude Asmith	0.666666667	0.435164835	0.892727273	0.760227273


Jared Smith	      Arude Asmith	0.666666667	0.361013986	0.880808081	0.760227273


Andrea Smith	    Arude Asmith	0.666666667	0.405194805	0.895454545	0.75



