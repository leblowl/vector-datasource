-- High Road
--
-- This file is a collection of Postgres views that make rendering roads from
-- OpenStreetMap data easier and better-looking. They are broken up by zoom
-- level, corresponding to numbered levels in the traditional web-map spherical
-- mercator projects. Zoom 0 is the entire planet, zoom 10 is where the street
-- details of cities become visible, and zoom 15 is where complex physical road
-- layering such as overpasses and tunnels becomes important.
-- 
-- 
-- Removal, upgrading
-- 
-- High Road can be removed from an existing OpenStreetMap rendering database. 
--
-- NOTE: To upgrade your OSM planet, it will need to be removed, then setup again.
--
--- Using the command-line psql utility, you can remove High Road views like this:
-- 
--     psql -U username -f high_road_views-remove.pgsql databasename
-- 
-- The views here assume that you've created your database using the default
-- settings of osm2pgsql, including the prefix of "planet_osm". If you've chosen
-- a different prefix, you should find every instance of "planet_osm" in the
-- script below and replace is with your chosen prefix.
--

BEGIN;

DROP MATERIALIZED VIEW IF EXISTS roads_z15plus_big;
DROP MATERIALIZED VIEW IF EXISTS roads_z15plus_small;
DROP MATERIALIZED VIEW IF EXISTS roads_z15plus;
DROP MATERIALIZED VIEW IF EXISTS roads_z14;
DROP MATERIALIZED VIEW IF EXISTS roads_z13;
DROP MATERIALIZED VIEW IF EXISTS roads_z12;
DROP MATERIALIZED VIEW IF EXISTS roads_z11;
DROP MATERIALIZED VIEW IF EXISTS roads_z10;

COMMIT;
