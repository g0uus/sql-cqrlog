-- Count unique 4-character gridsquares from QSO locations (loc field)
-- Extracts the first 4 characters from the locator field

SELECT COUNT(DISTINCT SUBSTRING(loc, 1, 4)) AS unique_4char_gridsquares
FROM view_cqrlog_main_by_qsodate
WHERE
    loc IS NOT NULL
    AND loc != '';