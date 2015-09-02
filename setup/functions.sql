CREATE OR REPLACE FUNCTION mz_calculate_is_landuse(
    landuse_val text, leisure_val text, natural_val text, highway_val text,
    amenity_val text, aeroway_val text, tourism_val text, man_made_val text)
RETURNS BOOLEAN AS $$
BEGIN
    RETURN
        landuse_val IN ('park', 'forest', 'residential', 'retail', 'commercial',
                        'industrial', 'railway', 'cemetery', 'grass', 'farmyard',
                        'farm', 'farmland', 'wood', 'meadow', 'village_green',
                        'recreation_ground', 'allotments', 'quarry', 'urban', 'rural')
     OR leisure_val IN ('park', 'garden', 'playground', 'golf_course', 'sports_centre',
                        'pitch', 'stadium', 'common', 'nature_reserve')
     OR natural_val IN ('wood', 'land', 'scrub', 'wetland', 'glacier')
     OR highway_val IN ('pedestrian', 'footway')
     OR amenity_val IN ('university', 'school', 'college', 'library', 'fuel',
                        'parking', 'cinema', 'theatre', 'place_of_worship', 'hospital')
     OR aeroway_val IN ('runway', 'taxiway', 'apron', 'aerodrome')
     OR tourism_val IN ('zoo')
     OR man_made_val IN ('pier', 'wastewater_plant', 'works', 'bridge', 'tower',
                         'breakwater', 'water_works', 'groyne', 'dike', 'cutline');
END;
$$ LANGUAGE plpgsql IMMUTABLE;

CREATE OR REPLACE FUNCTION mz_calculate_is_water(
    waterway_val text, natural_val text, landuse_val text)
RETURNS BOOLEAN AS $$
BEGIN
    RETURN (
        waterway_val IN ('riverbank', 'dock')
     OR natural_val IN ('water')
     OR landuse_val IN ('basin', 'reservoir')
    );
END;
$$ LANGUAGE plpgsql IMMUTABLE;

CREATE OR REPLACE FUNCTION mz_calculate_is_building_or_part(
    building_val text, buildingpart_val text)
RETURNS BOOLEAN AS $$
BEGIN
    RETURN (building_val IS NOT NULL OR buildingpart_val IS NOT NULL);
END;
$$ LANGUAGE plpgsql IMMUTABLE;

CREATE OR REPLACE FUNCTION create_matview(NAME, NAME)
  RETURNS VOID
  SECURITY DEFINER
  LANGUAGE plpgsql AS '
    DECLARE
      matview ALIAS FOR $1;
      view_name ALIAS FOR $2;
      entry matviews%ROWTYPE;
    BEGIN
      SELECT * INTO entry FROM matviews WHERE mv_name = matview;
      IF FOUND THEN
        RAISE EXCEPTION ''Materialized view ''''%'''' already exists.'',
         matview;
      END IF;

      EXECUTE ''REVOKE ALL ON '' || view_name || '' FROM PUBLIC'';
      EXECUTE ''GRANT SELECT ON '' || view_name || '' TO PUBLIC'';
      EXECUTE ''CREATE TABLE '' || matview || '' AS SELECT * FROM '' || view_name;
      EXECUTE ''REVOKE ALL ON '' || matview || '' FROM PUBLIC'';
      EXECUTE ''GRANT SELECT ON '' || matview || '' TO PUBLIC'';

      INSERT INTO matviews (mv_name, v_name, last_refresh)
       VALUES (matview, view_name, CURRENT_TIMESTAMP);

      RETURN;
    END
  ';

CREATE OR REPLACE FUNCTION drop_matview(NAME) RETURNS VOID
  SECURITY DEFINER
  LANGUAGE plpgsql AS '
    DECLARE
      matview ALIAS FOR $1;
      entry matviews%ROWTYPE;
    BEGIN
      SELECT * INTO entry FROM matviews WHERE mv_name = matview;
      IF NOT FOUND THEN
        RAISE EXCEPTION ''Materialized view % does not exist.'', matview;
      END IF;

      EXECUTE ''DROP TABLE '' || matview;
      DELETE FROM matviews WHERE mv_name=matview;

      RETURN;
    END
  ';

CREATE OR REPLACE FUNCTION refresh_matview(name) RETURNS VOID
  SECURITY DEFINER
  LANGUAGE plpgsql AS '
    DECLARE
      matview ALIAS FOR $1;
      entry matviews%ROWTYPE;
    BEGIN
      SELECT * INTO entry FROM matviews WHERE mv_name = matview;
      IF NOT FOUND THEN
        RAISE EXCEPTION ''Materialized view % does not exist.'', matview;
      END IF;

      EXECUTE ''DELETE FROM '' || matview;
      EXECUTE ''INSERT INTO '' || matview || '' SELECT * FROM '' || entry.v_name;

      UPDATE matviews
      SET last_refresh=CURRENT_TIMESTAMP
      WHERE mv_name=matview;

      RETURN;
    END
  ';
