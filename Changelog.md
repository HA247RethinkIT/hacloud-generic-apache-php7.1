# Change Log
All notable changes to this project will be documented in this file.

##
## [Unreleased]
### Fix
- Accept PHP_* as well as PHP7_* environment variables
- Remove the base image's sh entrypoint so settings with dots in the name (e.g. PHP_session.upload_progress.enabled) are applied

##
## [0.0.1]
### Add
- First release of the project. Intended for use with HA Cloud forked from https://github.com/HA247RethinkIT/hacloud-generic-apache-php5.3
