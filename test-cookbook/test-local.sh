#!/bin/bash -e
function cleanup {
  err=$?
  chef exec kitchen destroy --no-color --no-log-overwrite -c
  exit $err
}
trap cleanup EXIT

chef exec kitchen converge --no-color --no-log-overwrite -c
chef exec kitchen verify --no-color --no-log-overwrite
