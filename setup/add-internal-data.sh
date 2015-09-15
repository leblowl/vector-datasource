#!/usr/bin/env bash

shapefiles=(ne_10m_admin_0_boundary_lines_land
            ne_50m_admin_0_boundary_lines_land
            ne_110m_admin_0_boundary_lines_land
            ne_10m_admin_1_states_provinces_lines
            ne_50m_admin_1_states_provinces_lines)

shapefiles_utf8=(ne_10m_lakes ne_10m_ocean
                 ne_50m_lakes ne_50m_ocean
                 ne_110m_lakes ne_110m_ocean
                 ne_10m_land_tiled ne_50m_land ne_110m_land)

import_shapefile () {
	shp2pgsql -dID -s 900913 -W Windows-1252 -g the_geom "$@"
}

ls *.zip | xargs -n1 unzip -qq

for file in "${shapefiles[@]}"; do
    import_shapefile -W UTF-8 $file-merc.shp $file
done

for file in "${shapefiles_utf8[@]}"; do
    import_shapefile $file-merc.shp $file
done

rm *.dbf *.prj *.shp *.shx *.cpg
