#!/bin/bash

# Change 

# Create DB & User for Drupal

sudo -u postgres psql

create database drupal;
create user drupal with encrypted password 'drupal';
grant all privileges on database drupal to drupal;