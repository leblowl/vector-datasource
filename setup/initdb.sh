#!/bin/sh

psql -c "create database $@"
psql -d "$@" -c "create extension postgis; create extension hstore"
