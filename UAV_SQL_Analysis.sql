-- ============================================
-- UAV PROJECT - COMPLETE SQL ANALYSIS
-- ============================================

-- 1. Create table
DROP TABLE IF EXISTS uav_results;

CREATE TABLE uav_results (
    id INTEGER PRIMARY KEY,
    configuration TEXT,
    mass_kg REAL,
    mission_energy_wh REAL,
    energy_saving_percent REAL
);

-- 2. Insert project data
INSERT INTO uav_results (
    id,
    configuration,
    mass_kg,
    mission_energy_wh,
    energy_saving_percent
)
VALUES
    (1, 'Original UAV', 12.00, 334.46, 0.00),
    (2, 'Battery Optimized', 8.51, 293.50, 12.25),
    (3, 'Battery + CFRP Optimized', 7.80, 286.53, 14.33);

-- 3. Show all data
SELECT *
FROM uav_results;

-- 4. Order configurations by lowest mission energy
SELECT
    configuration,
    mission_energy_wh
FROM uav_results
ORDER BY mission_energy_wh ASC;

-- 5. Order configurations by lowest mass
SELECT
    configuration,
    mass_kg
FROM uav_results
ORDER BY mass_kg ASC;

-- 6. Order configurations by highest energy saving
SELECT
    configuration,
    energy_saving_percent
FROM uav_results
ORDER BY energy_saving_percent DESC;

-- 7. Find configuration with minimum mission energy
SELECT
    configuration,
    mission_energy_wh
FROM uav_results
WHERE mission_energy_wh = (
    SELECT MIN(mission_energy_wh)
    FROM uav_results
);

-- 8. Find configuration with minimum mass
SELECT
    configuration,
    mass_kg
FROM uav_results
WHERE mass_kg = (
    SELECT MIN(mass_kg)
    FROM uav_results
);

-- 9. Find configuration with maximum energy saving
SELECT
    configuration,
    energy_saving_percent
FROM uav_results
WHERE energy_saving_percent = (
    SELECT MAX(energy_saving_percent)
    FROM uav_results
);

-- 10. Compare each configuration with the original UAV
SELECT
    configuration,
    mass_kg,
    mission_energy_wh,
    12.00 - mass_kg AS mass_reduction_kg,
    334.46 - mission_energy_wh AS energy_saved_wh
FROM uav_results;

-- 11. Calculate mass reduction percentage vs original UAV
SELECT
    configuration,
    ROUND(
        ((12.00 - mass_kg) / 12.00) * 100,
        2
    ) AS mass_reduction_percent
FROM uav_results;

-- 12. Calculate energy reduction percentage vs original UAV
SELECT
    configuration,
    ROUND(
        ((334.46 - mission_energy_wh) / 334.46) * 100,
        2
    ) AS calculated_energy_saving_percent
FROM uav_results;

-- 13. Summary statistics
SELECT
    ROUND(AVG(mass_kg), 2) AS average_mass_kg,
    ROUND(MIN(mass_kg), 2) AS minimum_mass_kg,
    ROUND(MAX(mass_kg), 2) AS maximum_mass_kg,
    ROUND(AVG(mission_energy_wh), 2) AS average_energy_wh,
    ROUND(MIN(mission_energy_wh), 2) AS minimum_energy_wh,
    ROUND(MAX(mission_energy_wh), 2) AS maximum_energy_wh
FROM uav_results;

-- 14. Best configuration according to lowest energy consumption
SELECT
    configuration,
    mass_kg,
    mission_energy_wh,
    energy_saving_percent
FROM uav_results
ORDER BY mission_energy_wh ASC
LIMIT 1;

-- 15. Configurations with energy saving greater than 10%
SELECT
    configuration,
    energy_saving_percent
FROM uav_results
WHERE energy_saving_percent > 10
ORDER BY energy_saving_percent DESC;

-- ============================================
-- END OF UAV SQL ANALYSIS
-- ============================================
