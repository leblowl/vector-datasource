CREATE TABLE matviews (
  mv_name NAME NOT NULL PRIMARY KEY
  , v_name NAME NOT NULL
  , last_refresh TIMESTAMP WITH TIME ZONE
);

SELECT create_matview('planet_osm_line_z10_mv', 'planet_osm_line_z10');
SELECT create_matview('planet_osm_line_z11_mv', 'planet_osm_line_z11');
SELECT create_matview('planet_osm_line_z12_mv', 'planet_osm_line_z12');
SELECT create_matview('planet_osm_line_z13_mv', 'planet_osm_line_z13');
SELECT create_matview('planet_osm_line_z14_mv', 'planet_osm_line_z14');
SELECT create_matview('planet_osm_line_z15plus_mv', 'planet_osm_line_z15plus');
SELECT create_matview('planet_osm_line_z15plus_small_mv', 'planet_osm_line_z15plus_small');
SELECT create_matview('planet_osm_line_z15plus_big_mv', 'planet_osm_line_z15plus_big');
