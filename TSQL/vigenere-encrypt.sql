DECLARE @keyph varcher(100), @cleartext varchar(100)
SELECT @keyph = 'thisisamountain', @cleartext = 'The quick brown fox.'

;WITH t1 AS (SELECT 1 N UNION ALL SELECT 1 N),       
	 t2 AS (SELECT 1 N FROM t1 x, t1 y),            
	 t3 AS (SELECT 1 N FROM t2 x, t2 y),         
	 tally AS (SELECT ROW_NUMBER() OVER (PARTITION BY 1 ORDER BY x.N)AS  N from t3 x, t3 y, t3 z),
	 letters AS (SELECT N
					  , SUBSTRING (@cleartext, N, 1) AS ct
					  , ASCII(LOWER(SUBSTRING (@keyph, CASE WHEN N % LEN(@keyph) = 0 THEN LEN(@keyph) ELSE N % LEN(@keyph) END , 1))) - ASCII('a') AS AsciiKpOffset
					  , ASCII(SUBSTRING (@cleartext, N, 1)) AS AsciiCt
					  , ASCII('A') AS AsciiAUc
					  , ASCII('Z') AS AsciiZUc
					  , ASCII('a') AS AsciiALc
					  , ASCII('z') AS AsciiZLc
	             FROM tally),
	logic AS (SELECT CASE WHEN AsciiCt BETWEEN AsciiAUc AND AsciiZUc  
								  AND AsciiCt + AsciiKpOffset > AsciiZUc
					         THEN CHAR(AsciiCt + AsciiKpOffset - 26)
						  WHEN AsciiCt BETWEEN AsciiAUc AND AsciiZUc  
								  AND AsciiCt + AsciiKpOffset <= AsciiZUc
					         THEN CHAR(AsciiCt + AsciiKpOffset)
						  WHEN AsciiCt BETWEEN AsciiALc AND AsciiZLc  
								  AND AsciiCt + AsciiKpOffset > AsciiZLc
					         THEN CHAR(AsciiCt + AsciiKpOffset - 26)
						  WHEN AsciiCt BETWEEN AsciiALc AND AsciiZLc  
								  AND AsciiCt + AsciiKpOffset <= AsciiZLc
					         THEN CHAR(AsciiCt + AsciiKpOffset)
						  ELSE ct END AS CypherChar
			  FROM letters
			  WHERE AsciiCt IS NOT NULL)
SELECT (SELECT CypherChar [text()] 
				 FROM logic  
		         FOR XML PATH, TYPE).value(N'.[1]', N'nvarchar(max)') AS CypherText