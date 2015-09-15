#!/bin/bash

echo "Creating functions..."
psql $@ -f functions.sql

echo -e "\nApplying updates..."
psql $@ -f update-non-planet-tables.sql
psql $@ -f update-planet_osm_polygon.sql
psql $@ -f update-planet_osm_line.sql
psql $@ -f update-planet_osm_point.sql
. high_road_views && setup $@

echo -e '\nApplying triggers...'
psql $@ -f triggers.sql
