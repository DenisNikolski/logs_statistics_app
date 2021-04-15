# Logs statistics application

**Task description**

Create an app that receives path to log file as parameter and shows statistics of all and unique page visits

**Approach description**

Basic idea is to create structure with pages and array of all related IP addresses,
then count unique and all IPs in order to get statistics.

Besides basic file and file path checks, app provides validations for IP address and page. All lines that didn't pass checks are skipping
with proper warning message  

**Installation**

`bundle install`

**How to run app**

`ruby bin/logs_statistics.rb path/to/file/file.log`

**How to run specs**

`bundle exec rspec spec`

**Possible Improvements**

- use factory_bot gem for rspec tests
- add documentation
- extend validators checks
- generate file with results
- provide possibility to choose shown statistics 
