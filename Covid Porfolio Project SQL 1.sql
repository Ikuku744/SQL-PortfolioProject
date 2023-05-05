-- Selecting the Data i will be working on:

select location, date, total_cases, new_cases, total_deaths, population
from coviddeaths
order by 1,2

--Calculating the percentage of Total_cases Vs Total_Deaths:

select location, date, cast(total_cases as int) as Int_total_cases, cast(total_deaths as int) as Int_total_death, (cast(total_deaths AS float)/cast(total_cases AS float))*100 as Deathpercentage
from coviddeaths
order by 1,2


--Calculating the percentage of Total_cases Vs Total_Deaths in Nigeria as at 24th 2020 by the given data:

select location, date, cast(total_cases as int) as Int_total_cases, cast(total_deaths as int) as Int_total_death, (cast(total_deaths AS float)/cast(total_cases AS float))*100 as Deathpercentage
from coviddeaths
where location like '%nigeri%' and date between '2020-01-01' and '2020-12-24' and continent is not null
order by 1,2 desc


--Looking at Total Cases Vs Population:

select location, date, cast(total_cases as int) as Int_total_cases, population, (cast(total_cases AS float)/population)*100 as Case_Pop_percentage
from coviddeaths
where continent is not null
order by 1,2


--Looking at Total Cases Vs Population:

select location, date, cast(total_cases as int) as Int_total_cases, population, (cast(total_cases AS float)/population)*100 as Case_Pop_percentage
from coviddeaths
where continent is not null
group by total_cases
order by 1,2 desc


--I needed to convert the respective columns permanently

alter table coviddeaths
alter column total_deaths INT
alter column total_cases INT


--Countries with the highest infection Rate compared to Population:

select location, population, Max(total_cases) as Infectioncount,  max(total_cases/population)*100 as PercentagePopulationInfected
from coviddeaths
where continent is not null
group by location, population
order by PercentagePopulationInfected desc


--Countries with the Highest death Rate:

select location, Max(total_deaths) as TotalDeathcount
from coviddeaths
where continent is not null
group by location
order by TotalDeathcount desc


--Analyse by Continent with the Highest death Rate:

select continent, Max(total_deaths) as TotalDeathcount
from coviddeaths
where continent is not null
group by continent
order by TotalDeathcount desc


select location, Max(total_deaths) as TotalDeathcount
from coviddeaths
where continent is not null
group by location
order by TotalDeathcount desc

--select *
--from covidvaccinations
--order by 3,4

select continent, Max(total_deaths) as TotalDeathcount
from coviddeaths
where continent is not null and continent = 'North America'
group by continent
order by TotalDeathcount desc



ANALYSIS BY GLOBAL CASES:

select date, sum(new_cases) as Total_cases, sum(new_deaths) as Total_deaths,
	case when sum(new_cases)>0
		Then sum(new_deaths)/sum(new_cases)*100
		else null
	end as Percents
from coviddeaths
where continent is not null
group by date
order by 1,2 desc


select sum(new_cases) as Total_cases, sum(new_deaths) as Total_deaths,
	case when sum(new_cases)>0
		Then sum(new_deaths)/sum(new_cases)*100
		else null
	end as Percents
from coviddeaths
where continent is not null
--group by date
order by 1,2 desc


--Looking at Total Population Vs vaccination

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 1,2,3 desc


select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null and new_vaccinations is not null
order by 1,2,3 desc


--USE CTE

with PopVac (continent, locarion, date, population, new_vaccinations, Sum_Aggregate)
as
(
select dea.continent, dea.location, dea.date, dea.population, convert(int, vac.new_vaccinations) as New_vaccinations, SUM(convert(int, vac.new_vaccinations)) over (partition by dea.location order by 
dea.location, dea.date) as SUm_Aggregate---
--(SUm_Aggregate/population)*100
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)
select *, (SUm_Aggregate/population)*100 as PercentageVac
from popvac



--Temp TABLE
drop table if exists #PercentPopulationVaccinated 
CREATE TABLE #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population bigint,
New_vaccinations bigint,
Sum_Aggregate bigint
)

insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, convert(bigint, vac.new_vaccinations), SUM(convert(bigint, vac.new_vaccinations)) over (partition by dea.location order by 
dea.location, dea.date) as Sum_Aggregate
--(Sum_Aggregate/population)*100
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
--order by 2,3

select *, (Sum_Aggregate/population)*100 as PercentageVac
from #PercentPopulationVaccinated




--Creaing View:

create view PercentPopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, convert(bigint, vac.new_vaccinations) as new_vaccinations, SUM(convert(bigint, vac.new_vaccinations)) over (partition by dea.location order by 
dea.location, dea.date) as Sum_Aggregate
--(Sum_Aggregate/population)*100
from CovidDeaths dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
--order by 2,3


select *
from PercentPopulationVaccinated








----New Code

--CREATE TABLE #PercentPopulationVaccinated
--(
--  Continent nvarchar(255),
--  Location nvarchar(255),
--  Date datetime,
--  Population numeric,
--  New_vaccinations bigint,  -- changed data type to bigint to avoid overflow errors
--  Sum_Aggregate bigint     -- changed data type to bigint to avoid overflow errors
--)

--INSERT INTO #PercentPopulationVaccinated
--SELECT
--  dea.continent,
--  dea.location,
--  dea.date,
--  dea.population,
--  CONVERT(bigint, vac.new_vaccinations) AS New_vaccinations,  -- updated to use bigint data type
--  SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.date) AS Sum_Aggregate  -- updated to use bigint data type
--FROM
--  CovidDeaths dea
--  JOIN CovidVaccinations vac ON dea.location = vac.location AND dea.date = vac.date
--WHERE
--  dea.continent IS NOT NULL

--SELECT
--  Continent,
--  Location,
--  Date,
--  Population,
--  New_vaccinations,
--  Sum_Aggregate,
--  (Sum_Aggregate / Population) * 100 AS PercentPopulationVaccinated
--FROM
--  #PercentPopulationVaccinated;
