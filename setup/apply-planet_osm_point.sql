DO $$
BEGIN

--------------------------------------------------------------------------------
-- planet_osm_point
--------------------------------------------------------------------------------

CREATE INDEX planet_osm_point_place_index ON planet_osm_point(place) WHERE name IS NOT NULL AND place IN ('city', 'continent', 'country', 'county', 'district', 'hamlet', 'island', 'isolated_dwelling', 'lake', 'locality', 'neighbourhood', 'ocean', 'province', 'sea', 'state', 'suburb', 'town', 'village');

END $$;
