DO $$
BEGIN

--------------------------------------------------------------------------------
-- planet_osm_line
--------------------------------------------------------------------------------

CREATE INDEX planet_osm_line_waterway_index ON planet_osm_line(waterway) WHERE waterway IS NOT NULL;
CREATE INDEX planet_osm_line_admin_boundaries_index ON planet_osm_line(boundary) WHERE boundary='administrative';

END $$;
