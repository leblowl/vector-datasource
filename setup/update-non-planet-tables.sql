ALTER TABLE ne_110m_ocean ADD COLUMN way_area REAL;
UPDATE ne_110m_ocean SET way_area=ST_Area(the_geom) WHERE the_geom IS NOT NULL;
CREATE INDEX ne_110m_ocean_wayarea_index ON ne_110m_ocean(way_area);

ALTER TABLE ne_110m_lakes ADD COLUMN way_area REAL;
UPDATE ne_110m_lakes SET way_area=ST_Area(the_geom) WHERE the_geom IS NOT NULL;
CREATE INDEX ne_110m_lakes_wayarea_index ON ne_110m_lakes(way_area);

ALTER TABLE ne_50m_ocean ADD COLUMN way_area REAL;
UPDATE ne_50m_ocean SET way_area=ST_Area(the_geom) WHERE the_geom IS NOT NULL;
CREATE INDEX ne_50m_ocean_wayarea_index ON ne_50m_ocean(way_area);

ALTER TABLE ne_50m_lakes ADD COLUMN way_area REAL;
UPDATE ne_50m_lakes SET way_area=ST_Area(the_geom) WHERE the_geom IS NOT NULL;
CREATE INDEX ne_50m_lakes_wayarea_index ON ne_50m_lakes(way_area);

ALTER TABLE ne_10m_ocean ADD COLUMN way_area REAL;
UPDATE ne_10m_ocean SET way_area=ST_Area(the_geom) WHERE the_geom IS NOT NULL;
CREATE INDEX ne_10m_ocean_wayarea_index ON ne_10m_ocean(way_area);

ALTER TABLE ne_10m_lakes ADD COLUMN way_area REAL;
UPDATE ne_10m_lakes SET way_area=ST_Area(the_geom) WHERE the_geom IS NOT NULL;
CREATE INDEX ne_10m_lakes_wayarea_index ON ne_10m_lakes(way_area);

ALTER TABLE water_polygons ADD COLUMN way_area REAL;
UPDATE water_polygons SET way_area=ST_Area(the_geom) WHERE the_geom IS NOT NULL;
CREATE INDEX water_polygons_wayarea_index ON water_polygons(way_area);
