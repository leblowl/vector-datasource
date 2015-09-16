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
