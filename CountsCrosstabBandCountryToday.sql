-- Crosstab: counts of QSOs with columns = bands and rows = countries
-- Contains: 1) Static MySQL pivot example, 2) Dynamic MySQL pivot (prepared statement),
-- 3) PostgreSQL crosstab and FILTER-based variants.
-- Replace the band list in the static examples to match the bands used in your DB.

-- -----------------------------------------------------------------------------
-- 1) Static MySQL pivot (list bands explicitly)
-- Example: replace '160m','80m','40m' with your actual band values
-- -----------------------------------------------------------------------------
SELECT
    country,
    CASE
        WHEN SUM(
            CASE
                WHEN band = '160M' THEN 1
                ELSE 0
            END
        ) = 0 THEN ''
        ELSE CAST(
            SUM(
                CASE
                    WHEN band = '160M' THEN 1
                    ELSE 0
                END
            ) AS CHAR
        )
    END AS `160m`,
    CASE
        WHEN SUM(
            CASE
                WHEN band = '80M' THEN 1
                ELSE 0
            END
        ) = 0 THEN ''
        ELSE CAST(
            SUM(
                CASE
                    WHEN band = '80M' THEN 1
                    ELSE 0
                END
            ) AS CHAR
        )
    END AS `80m`,
    CASE
        WHEN SUM(
            CASE
                WHEN band = '60M' THEN 1
                ELSE 0
            END
        ) = 0 THEN ''
        ELSE CAST(
            SUM(
                CASE
                    WHEN band = '60M' THEN 1
                    ELSE 0
                END
            ) AS CHAR
        )
    END AS `60m`,
    CASE
        WHEN SUM(
            CASE
                WHEN band = '40M' THEN 1
                ELSE 0
            END
        ) = 0 THEN ''
        ELSE CAST(
            SUM(
                CASE
                    WHEN band = '40M' THEN 1
                    ELSE 0
                END
            ) AS CHAR
        )
    END AS `40m`,
    CASE
        WHEN SUM(
            CASE
                WHEN band = '30M' THEN 1
                ELSE 0
            END
        ) = 0 THEN ''
        ELSE CAST(
            SUM(
                CASE
                    WHEN band = '30M' THEN 1
                    ELSE 0
                END
            ) AS CHAR
        )
    END AS `30m`,
    CASE
        WHEN SUM(
            CASE
                WHEN band = '20M' THEN 1
                ELSE 0
            END
        ) = 0 THEN ''
        ELSE CAST(
            SUM(
                CASE
                    WHEN band = '20M' THEN 1
                    ELSE 0
                END
            ) AS CHAR
        )
    END AS `20m`,
    CASE
        WHEN SUM(
            CASE
                WHEN band = '17M' THEN 1
                ELSE 0
            END
        ) = 0 THEN ''
        ELSE CAST(
            SUM(
                CASE
                    WHEN band = '17M' THEN 1
                    ELSE 0
                END
            ) AS CHAR
        )
    END AS `17m`,
    CASE
        WHEN SUM(
            CASE
                WHEN band = '15M' THEN 1
                ELSE 0
            END
        ) = 0 THEN ''
        ELSE CAST(
            SUM(
                CASE
                    WHEN band = '15M' THEN 1
                    ELSE 0
                END
            ) AS CHAR
        )
    END AS `15m`,
    CASE
        WHEN SUM(
            CASE
                WHEN band = '12M' THEN 1
                ELSE 0
            END
        ) = 0 THEN ''
        ELSE CAST(
            SUM(
                CASE
                    WHEN band = '12M' THEN 1
                    ELSE 0
                END
            ) AS CHAR
        )
    END AS `12m`,
    CASE
        WHEN SUM(
            CASE
                WHEN band = '10M' THEN 1
                ELSE 0
            END
        ) = 0 THEN ''
        ELSE CAST(
            SUM(
                CASE
                    WHEN band = '10M' THEN 1
                    ELSE 0
                END
            ) AS CHAR
        )
    END AS `10m`,
    CASE
        WHEN SUM(
            CASE
                WHEN band = '6M' THEN 1
                ELSE 0
            END
        ) = 0 THEN ''
        ELSE CAST(
            SUM(
                CASE
                    WHEN band = '6M' THEN 1
                    ELSE 0
                END
            ) AS CHAR
        )
    END AS `6m`,
    SUM(1) AS total
FROM view_cqrlog_main_by_qsodate
WHERE
    country IS NOT NULL
    AND country <> ''
    AND qsodate = CURRENT_DATE
GROUP BY
    country
ORDER BY country;

-- -----------------------------------------------------------------------------
-- 2) Dynamic MySQL pivot (builds SQL using distinct bands)
-- This uses GROUP_CONCAT to create the SUM(CASE ...) list and executes it.
-- Note: if you have many distinct bands, increase group_concat_max_len if needed.
-- -----------------------------------------------------------------------------
-- SET SESSION group_concat_max_len = 1000000; -- optional if result is truncated
--
-- SELECT
--   GROUP_CONCAT(CONCAT("CASE WHEN SUM(CASE WHEN band = '", REPLACE(band, "'", "''"), "' THEN 1 ELSE 0 END) = 0 THEN '' ELSE CAST(SUM(CASE WHEN band = '", REPLACE(band, "'", "''"), "' THEN 1 ELSE 0 END) AS CHAR) END AS `", band, "`") ORDER BY band SEPARATOR ', ')
-- INTO @cols
-- FROM (SELECT DISTINCT band FROM view_cqrlog_main_by_qsodate WHERE band IS NOT NULL AND band <> '') x;
--
-- SET @sql = CONCAT('SELECT country, ', @cols, ' FROM view_cqrlog_main_by_qsodate WHERE country IS NOT NULL AND country <> '''' GROUP BY country ORDER BY country');
-- PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- -----------------------------------------------------------------------------
-- 3) PostgreSQL variants
-- a) FILTER aggregate (explicit band list)
-- -----------------------------------------------------------------------------
-- SELECT
--   country,
--   CASE WHEN COUNT(*) FILTER (WHERE band = '160m') = 0 THEN '' ELSE CAST(COUNT(*) FILTER (WHERE band = '160m') AS text) END AS "160m",
--   CASE WHEN COUNT(*) FILTER (WHERE band = '80m') = 0 THEN '' ELSE CAST(COUNT(*) FILTER (WHERE band = '80m') AS text) END AS "80m",
--   CASE WHEN COUNT(*) FILTER (WHERE band = '40m') = 0 THEN '' ELSE CAST(COUNT(*) FILTER (WHERE band = '40m') AS text) END AS "40m"
-- FROM view_cqrlog_main_by_qsodate
-- WHERE country IS NOT NULL AND country <> ''
-- GROUP BY country
-- ORDER BY country;

-- b) crosstab() from tablefunc (dynamic columns defined in second param)
-- You must install the tablefunc extension and provide a static column definition for the output
-- Example: if bands are 160m,80m,40m the result type must be (country text, "160m" int, "80m" int, "40m" int)
--
-- CREATE EXTENSION IF NOT EXISTS tablefunc;
-- SELECT * FROM crosstab(
--   'SELECT country, band, COUNT(*) FROM view_cqrlog_main_by_qsodate WHERE country IS NOT NULL AND country <> '''' GROUP BY country, band ORDER BY 1,2',
--   'SELECT DISTINCT band FROM view_cqrlog_main_by_qsodate WHERE band IS NOT NULL AND band <> '''' ORDER BY 1'
-- ) AS ct(country text, "160m" bigint, "80m" bigint, "40m" bigint);

-- -----------------------------------------------------------------------------
-- Notes:
-- - The dynamic MySQL variant builds the column expressions automatically; the static
--   variants are simpler and may be preferred if your band set is small/stable.
-- - Band names that contain special characters should be quoted properly (backticks for MySQL, double quotes for Postgres column names).
-- - If you want to include rows for countries with zero counts on all bands, you can generate a distinct country list and LEFT JOIN the pivot to that list.
-- -----------------------------------------------------------------------------