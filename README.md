# QNA
[![Build Status](https://app.travis-ci.com/vetolmedzol/qna.svg?branch=master)](https://app.travis-ci.com/vetolmedzol/qna)

<p>Things you may want to cover:</p>

* Ruby version 3.0.0

* RAILS version 6.1.4

* PostgresQL version 12

### Before bundle install run
sudo apt update
<br>
sudo apt install g++ qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x
<br>
gem install capybara-webkit

### Database
rake db:create db:migrate

### How to run the test suite
spring rspec spec/
<p><strong>How to run the parallel tests</strong></p>
rake parallel:spec

### How to run the guard
guard
<p><strong>How to run the rails server with guard</strong></p>
guard -g server
