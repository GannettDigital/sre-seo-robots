#!/usr/bin/env bash

arr=('alamogordonews' 'app' 'argusleader' 'azcentral' 'battlecreekenquirer' 'baxterbulletin' 'blackmountainnews' 'bucyrustelegraphforum' 'burlingtonfreepress' 'caller' 'chillicothegazette' 'cincinnati' 'citizen-times' 'clarionledger' 'coloradoan' 'commercialappeal' 'coshoctontribune' 'courier-journal' 'courierpostonline' 'courierpress' 'currentargus' 'daily-times' 'dailyrecord' 'dailyworld' 'delawarebeaches' 'delawareonline' 'delmarvanow' 'demingheadlight' 'democratandchronicle' 'desertsun' 'desmoinesregister' 'dmjuice' 'dnj' 'elpasotimes' 'elpasoymas' 'elsoldesalinas' 'eveningsun' 'farmersadvance' 'fdlreporter' 'floridatoday' 'freep' 'fsunews' 'gosanangelo' 'greatfallstribune' 'greenbaypressgazette' 'greenvilleonline' 'guampdn' 'hattiesburgamerican' 'hawkcentral' 'hometownlife' 'htrnews' 'independentmail' 'indystar' 'inyork' 'ithacajournal' 'jacksonsun' 'jconline' 'jsonline' 'kitsapsun' 'knoxnews' 'lancastereaglegazette' 'lansingstatejournal' 'lavozarizona' 'lcsun-news' 'ldnews' 'livingstondaily' 'lohud' 'mansfieldnewsjournal' 'marconews' 'marionstar' 'marshfieldnewsherald' 'metroparentmagazine' 'montgomeryadvertiser' 'mycentraljersey' 'naplesnews' 'newarkadvocate' 'news-leader' 'news-press' 'newsleader' 'northjersey' 'packersnews' 'pal-item' 'pnj' 'portclintonnewsherald' 'postcrescent' 'poughkeepsiejournal' 'press-citizen' 'pressconnects' 'publicopiniononline' 'redding' 'reno' 'reporternews' 'rgj' 'ruidosonews' 'scsun-news' 'sctimes' 'sheboyganpress' 'shreveporttimes' 'stargazette' 'statesmanjournal' 'stevenspointjournal' 'tallahassee' 'tcpalm' 'tennessean' 'theadvertiser' 'thecalifornian' 'thedailyjournal' 'thegleaner' 'thehammontonnews' 'theleafchronicle' 'thenews-messenger' 'thenewsstar' 'thenorthwestern' 'thespectrum' 'thestarpress' 'thetimesherald' 'thetowntalk' 'timesrecordnews' 'trainuscp' 'upstateparent' 'vcstar' 'visaliatimesdelta' 'wausaudailyherald' 'wisconsinrapidstribune' 'wisfarmer' 'ydr' 'yorkdispatch' 'zanesvilletimesrecorder')

## now loop through the above array
for i in "${arr[@]}"
do
  echo "processing $i"
  curl "https://www.$i.com/robots.txt" >> "$i.txt"
  echo "$i is DONE \n ----------\n"
   # or do whatever with individual element of the array
done
