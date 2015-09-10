#!/bin/bash

echo "Creating functions..."
psql $@ -f functions.sql
echo "done."

echo -e "\nApplying updates..."
psql $@ -f update-non-planet-tables.sql
psql $@ -f update-planet_osm_polygon.sql
psql $@ -f update-planet_osm_line.sql
psql $@ -f update-planet_osm_point.sql
psql $@ -f high_road_views-setup.pgsql
psql $@ -f create-matviews.sql
echo "done."

echo -e '\nApplying triggers...'
psql $@ -f triggers.sql
echo 'done.'

echo -e "\nAll updates complete. Exiting."
