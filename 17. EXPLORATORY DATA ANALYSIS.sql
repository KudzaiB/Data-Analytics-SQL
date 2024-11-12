-- Exploratory Data Analysis

SELECT* 
FROM layoffs_stagging2;

SELECT
	MAX(total_laid_off)
FROM layoffs_stagging2;

SELECT
	MAX(total_laid_off),
    MAX(percentage_laid_off)
FROM layoffs_stagging2;

SELECT * 
FROM layoffs_stagging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

SELECT * 
FROM layoffs_stagging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

SELECT 
	company,
    SUM(total_laid_off)
FROM layoffs_stagging2
GROUP BY company
ORDER BY 2 DESC;


SELECT 
	MIN(`date`),
    MAX(`date`)
FROM layoffs_stagging2;

#what industry had the most layoffs
SELECT 
	industry,
    SUM(total_laid_off)
FROM layoffs_stagging2
GROUP BY industry
ORDER BY 2 DESC;


SELECT * 
FROM layoffs_stagging2;

#what country had the most layoffs
SELECT 
	country,
    SUM(total_laid_off)
FROM layoffs_stagging2
GROUP BY country
ORDER BY 2 DESC;

#individual year showing total layoffs

SELECT YEAR (`date`),
    SUM(total_laid_off)
FROM layoffs_stagging2
GROUP BY YEAR (`date`)
ORDER BY 1 DESC;

#stage of the company

SELECT 
	stage,
    SUM(total_laid_off)
FROM layoffs_stagging2
GROUP BY stage
ORDER BY 1 DESC;

SELECT 
	stage,
    SUM(total_laid_off)
FROM layoffs_stagging2
GROUP BY stage
ORDER BY 2 DESC;

#percentage of a company

SELECT 
	company,
    AVG(percentage_laid_off)
FROM layoffs_stagging2
GROUP BY company
ORDER BY 2 DESC;

#rolling total of layoffs

SELECT 
	SUBSTRING(`date`,1,7) MONTH,
    SUM(total_laid_off)
FROM layoffs_stagging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY MONTH
ORDER BY 1 ASC;

WITH Rolling_Total AS
(SELECT 
	SUBSTRING(`date`,1,7) MONTH,
    SUM(total_laid_off) total_off
FROM layoffs_stagging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY MONTH
ORDER BY 1 ASC
)
SELECT 
	MONTH,
    total_off,
    SUM(total_off) OVER (ORDER BY MONTH) rolling_total
FROM  Rolling_Total;


SELECT 
	company,
    SUM(total_laid_off)
FROM layoffs_stagging2
GROUP BY company
ORDER BY 2 DESC;


SELECT 
	company,
	YEAR(`date`),
    SUM(total_laid_off)
FROM layoffs_stagging2
GROUP BY company, YEAR(`date`)
ORDER BY company ASC;

#year that they dismissed the most employees

SELECT 
	company,
	YEAR(`date`),
    SUM(total_laid_off)
FROM layoffs_stagging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;


WITH Company_Year (company, years, total_laid_off) AS
(SELECT 
	company,
	YEAR(`date`),
    SUM(total_laid_off)
FROM layoffs_stagging2
GROUP BY company, YEAR(`date`)
)
SELECT * 
FROM Company_Year;


#who laid off the most employees

WITH Company_Year (company, years, total_laid_off) AS 
(SELECT 
	company,
	YEAR(`date`),
    SUM(total_laid_off)
FROM layoffs_stagging2
GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS
(SELECT *, 
DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <= 5;




