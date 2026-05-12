// Forecast demand and future sales
/*
Our retail chains sell seasonal cold beverages and I need to forecast demand for summer. How many days in July of last year, did the temperature exceed 85℉ in Los Angeles?
*/
SELECT 
    count(*) as days_exceeding
FROM 
    pws_bi_sample.point_history_day h
WHERE
    city_name = 'los_angeles'
    AND DATE_PART(month, date_valid_std) = 7
    AND max_temperature_air_2m_f > 85
;

// Plan for energy demand and grid management schedules
/*
Our utility company needs to model summer AC usage. What was the maximum daily temperature in New York City for the month of June?
*/
SELECT 
    MAX(max_temperature_air_2m_f)
FROM 
    pws_bi_sample.point_history_day h
WHERE
    city_name = 'new_york'
    AND DATE_PART(month, date_valid_std) = 6
;

// Use temperature data to create sales forecast.
/*
Our company sells 70% more product when the temperature is in excess of 80 degrees and I am trying to create a product sales forecast for this upcoming July. How can we use your climatology data to quickly ascertain what days “normally” exceed 80 degrees during the month of July?
*/
SELECT COUNTRY_CODE, CITY_NAME, DATEADD(day, DOY_STD-1, '2024-01-01') AS DATE_FROM_DOY
FROM pws_bi_sample.point_climatology_day 
WHERE AVG_OF__DAILY_MAX_TEMPERATURE_AIR_2M_F > 80 
  AND DOY_STD >= 182 AND DOY_STD <= 213 
  AND COUNTRY_CODE = 'US' 
ORDER BY CITY_NAME, DOY_STD;

// Forecast outdoor dining demand for staffing
/*
Our restaurant has a significant amount of outdoor dining space. We need to determine staffing and demand based on the forecasted weather for next week.
*/
SELECT DATE_VALID_STD, CITY_NAME, 
    MAX_TEMPERATURE_AIR_2M_F,
    PROBABILITY_OF_PRECIPITATION_PCT,
    AVG_CLOUD_COVER_TOT_PCT
FROM PWS_BI_SAMPLE.POINT_FORECAST_DAY
WHERE CITY_NAME = 'los_angeles'
    AND DATE_VALID_STD BETWEEN CURRENT_DATE AND DATEADD(day, 7, CURRENT_DATE)
ORDER BY DATE_VALID_STD;

