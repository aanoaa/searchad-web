# Overview #

- Client 마다의 설정을 반영해서 hubot worker 를 띄워줍니다.
- Web service 에서 client 의 설정을 변경합니다.
- client 의 설정에 따라 bell manager 가 채널을 통해 hubot 에 명령을 내립니다.
- hubot worker 가 실행 결과를 채널에 알려줍니다.

# Hubot searchad workers #

## Installation ##

    $ cpanm Hubot
    ## Suck!! making CPAN distribution file and type oneliner via `cpanm`
    $ git clone git://github.com/aanoaa/Hubot-Scripts-searchad.git
    $ cd Hubot-Scripts-searchad/
    $ dzil build
    $ cd Hubot-Scripts-searchad-x.x.x/
    $ perl Makefile.PL
    $ make
    $ make install

## Configuration ##

http://searchad.naver.com/ 의 `username`과 `salogin.js`로 encoding 된 `password`

    $ node salogin.js password    # require nodejs
    99fc288bed7238d16d567aa5b3ccd4f58d2451d127fe11a26ddbbaa6d0d3063772926cd8f65e0d15174082ad898488e5

    export HUBOT_SEARCHAD_NAVER_USERNAME=aanoaa
    export HUBOT_SEARCHAD_NAVER_PASSWORD=99fc288bed7238d16d567aa5b3ccd4f58d2451d127fe11a26ddbbaa6d0d3063772926cd8f65e0d15174082ad898488e5

    ## for irc connection
    export HUBOT_IRC_ROOMS='#aanoaa'
    export HUBOT_IRC_SERVER=irc.example.com
    export HUBOT_IRC_PORT=6667

`hubot-scripts.json` 파일을 작성합니다.

    ["help","searchad"]

## Run ##

    $ hubot -a irc -n $HUBOT_SEARCHAD_NAVER_USERNAME

# Web service #

## Create SQLite Database ##

    $ sqlite3 db/searchad.db < db/schema.sql
    $ sqlite3 db/searchad.db < db/data.sql

## Run ##

    $ plackup -Ilib

# Bell manager #

## Configuration ##

    ## SBM? Searchad Bell Manager
    $ export SBM_ROOM='#aanoaa'
    $ export SBM_SERVER=irc.example.com
    $ export SBM_PORT=6667

## Run ##

    $ perl bell.pl
