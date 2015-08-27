#!/bin/bash

# subsequent sql depends on functions installed
echo "Creating functions..."
psql $@ -f functions.sql
echo "done."

# apply updates
echo -e "\nApplying updates..."
psql $@ -f apply-updates-non-planet-tables.sql
psql $@ -f apply-planet_osm_polygon.sql
psql $@ -f apply-planet_osm_line.sql
psql $@ -f apply-planet_osm_point.sql
echo "done."

echo -e '\nApplying triggers...'
psql $@ -f triggers.sql
echo 'done.'

echo -e "\nAll updates complete. Exiting."
