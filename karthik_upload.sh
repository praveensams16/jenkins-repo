#!/bin/bash


uploads()
    {
    version=$(cat /hybris/share/workspace/hybris-package-dev/temp/hybris/hybrisServer/version)
    
    if [ $( grep $version /etc/pack_karthik_old | wc -c ) -gt 4  ]
    then
        echo "veron is already there"
    else 
        cd /hybris/play
        rm -rf /hybris/play/*
        cp /hybris/share/workspace/hybris-package-dev/temp/hybris/hybrisServer/hybrisServer-AllExtensions.zip /hybris/play/
        unzip /hybris/play/hybrisServer-AllExtensions.zip
       #(
       #cd /hybris/play/hybris/bin/custom/extrastorefront/web/webroot/_ui/responsive/theme-extra
       #azcopy --source . --destination https://exprdstrgcdn.blob.core.windows.net/exprdeccdn01/ImagesSections/hybris/ --dest-key zqireCeb6SebWU1xS9uleijwSnE+Sf0JCwqrBIKx44DxEpAnDpp0yZdLenN6rojte/58/aS0gQ6toi/fL80NSg== --quiet --recursive   --resume "/mnt/myjournal"
       #ls -l 
       #)
        (
        cd /hybris/play/hybris/bin/custom/extrastorefront/web/webroot/_ui
        azcopy --source . --destination https://exprdstrgcdn.blob.core.windows.net/exprdeccdn01/ImagesSections/hybris/_ui --dest-key zqireCeb6SebWU1xS9uleijwSnE+Sf0JCwqrBIKx44DxEpAnDpp0yZdLenN6rojte/58/aS0gQ6toi/fL80NSg== --quiet --recursive   --resume "/mnt/myjournal"
       ls -l 
       )

       (
		cd /hybris/play/hybris/bin/custom/extrastorefront/web/webroot/_ui/responsive/theme-extra/css


azcopy --set-content-type 'text/css'  --source .  --destination https://exprdstrgcdn.blob.core.windows.net/exprdeccdn01/ImagesSections/hybris/_ui/responsive/theme-extra/css --dest-key zqireCeb6SebWU1xS9uleijwSnE+Sf0JCwqrBIKx44DxEpAnDpp0yZdLenN6rojte/58/aS0gQ6toi/fL80NSg== --quiet   --resume "/mnt/myjournal" --recursive
       )
       echo $version >> /etc/pack_karthik_old
    fi
    }


while true
do
    stat=$(curl -I -s  http://51.136.48.111:3000/daily/hybrisServer/version  | perl -ane 'if(/HTTP\/1.1\s(\d+)/) {print $1}')

    if  [ $stat -eq 200 ]
    then
        uploads
    else
       echo "error in loading the files"
    fi
    sleep 60

done
