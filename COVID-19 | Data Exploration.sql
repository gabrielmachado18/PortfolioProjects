-- Selecionar os dados que serão analisados

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2

-- Total de Casos x Total de Mortes (% de Mortalidade Casos → Total de Mortes / Total de Casos) no Brasil

SELECT location, date, total_cases, total_deaths, (CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0)) * 100 AS Taxa_Mortalidade_Casos
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL AND location = 'Brazil'
ORDER BY 1,2

-- Total de Casos x População (% de Contaminação → Total de Casos / População Total) no Brasil

SELECT location, date, population, total_cases, (NULLIF(CONVERT(float, total_cases), 0) / CONVERT(float, population)) * 100 AS Taxa_Contaminação
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL AND location = 'Brazil'
ORDER BY 1,2

-- Países com maior Número de Contaminados x População (% de Contaminação → Total de Casos / População Total)

SELECT location, population, MAX(CONVERT(float, total_cases)) AS Maior_Número_Contaminados, MAX(CONVERT(float, total_cases) / CONVERT(float, population)) * 100 AS Taxa_Contaminação
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY 4 DESC

-- Países com maior Número de Mortes x População (% de Mortalidade População → Total de Mortes / População)

SELECT location, population, MAX(CONVERT(float, total_deaths)) AS Maior_Número_Mortes, MAX(CONVERT(float, total_deaths) / CONVERT(float, population)) * 100 AS Taxa_Mortalidade_População
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY 4 DESC

-- Continentes com maior Número de Mortes x População (% de Mortalidade População → Total de Mortes / População)

SELECT location, population, MAX(CONVERT(float, total_deaths)) AS Maior_Número_Mortes, MAX(CONVERT(float, total_deaths) / CONVERT(float, population)) * 100 AS Taxa_Mortalidade_População
FROM PortfolioProject..CovidDeaths
WHERE continent IS NULL
GROUP BY location, population
ORDER BY 4 DESC

-- População Total x Vacinações (Aqui, uniremos as duas tabela por 'Location' e 'Date')

SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations
FROM PortfolioProject..CovidDeaths AS d
JOIN PortfolioProject..CovidVaccinations AS v
	ON d.location = v.location
	AND d.date = v.date
WHERE d.continent IS NOT NULL
ORDER BY 2,3

-- Soma Acumulada de Vacinações por Dia (Cenário que considera que não temos uma coluna com o total de vacinações)

SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations
, SUM(CONVERT(float, v.new_vaccinations)) OVER (PARTITION BY d.Location Order by d.location, d.Date) as SomaAcumuladaVacinação
FROM PortfolioProject..CovidDeaths AS d
JOIN PortfolioProject..CovidVaccinations AS v
	ON d.location = v.location
	AND d.date = v.date
WHERE d.continent is not null 
ORDER BY 2,3

-- Usando CTE para realizar os cálculos da query anterior

WITH NúmeroVacinados (Continent, Location, Date, Population, New_Vaccinations, SomaAcumuladaVacinação)
AS
(
SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations
, SUM(CONVERT(float, v.new_vaccinations)) OVER (PARTITION BY d.Location Order by d.location, d.Date) as SomaAcumuladaVacinação
FROM PortfolioProject..CovidDeaths AS d
JOIN PortfolioProject..CovidVaccinations AS v
	ON d.location = v.location
	AND d.date = v.date
WHERE d.continent is not null
)
SELECT *
FROM NúmeroVacinados

-- Usando TEMP TABLE para realizar os cálculos da query anterior

DROP TABLE IF EXISTS #NúmeroVacinados
CREATE TABLE #NúmeroVacinados
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
SomaAcumuladaVacinação numeric
)

INSERT INTO #NúmeroVacinados
SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations
, SUM(CONVERT(float, v.new_vaccinations)) OVER (PARTITION BY d.Location Order by d.location, d.Date) as SomaAcumuladaVacinação
FROM PortfolioProject..CovidDeaths AS d
JOIN PortfolioProject..CovidVaccinations AS v
	ON d.location = v.location
	AND d.date = v.date

SELECT *
FROM #NúmeroVacinados

-- Criando Views para uso posterior (PowerBI ou Tableau)

CREATE VIEW NúmeroVacinados AS
SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations
, SUM(CONVERT(float, v.new_vaccinations)) OVER (PARTITION BY d.Location Order by d.location, d.Date) as SomaAcumuladaVacinação
FROM PortfolioProject..CovidDeaths AS d
JOIN PortfolioProject..CovidVaccinations AS v
	ON d.location = v.location
	AND d.date = v.date
WHERE d.continent is not null
