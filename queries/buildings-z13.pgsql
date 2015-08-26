SELECT
    name,
    way_area::bigint AS area,
    osm_id AS __id__,
    "building:part",
    building,
    amenity,
    shop,
    tourism,
    "building:levels",
    "building:min_levels",
    height,
    min_height,
    way AS __geometry__,
    %#tags AS tags

FROM
    planet_osm_polygon

WHERE
    building IS NOT NULL
    AND way_area::bigint > 1600 -- 4px
