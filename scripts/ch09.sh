if [ "$#" -ne 2 ]; then
  echo -e "Usage: ch9.sh \$SOLR_IN_ACTION \$SOLR_INSTALL"
  exit 0
fi
SOLR_IN_ACTION=${1%/}
SOLR_INSTALL=${2%/}
for ID in `ps waux | grep java | grep start.jar | awk '{print $2}' | sort -r`
  do
    kill -9 $ID
    echo "Killed process $ID"
done
echo -e "----------------------------------------\n"
echo -e "CHAPTER 9"
echo -e "----------------------------------------\n"
echo -e "\n\n"
echo -e "pg 284"
echo -e "\n"

cd $SOLR_INSTALL/example/
echo -e "Starting Solr example server on port 8983; see $SOLR_INSTALL/example/solr.log for errors and log messages"
java -jar start.jar 1>solr.log 2>&1 &
sleep 10 
tail -30 solr.log

# chapter 9 relies on the user manually creating the ufo core
if [ ! -d "$SOLR_INSTALL/example/solr/ufo" ]; then
  echo -e "\n\n"
  echo -e "pg 284"
  echo -e "\n"
  cd $SOLR_INSTALL/example/solr
  cp -r collection1 ufo
  rm -rf ufo/data
  rm ufo/core.properties
  echo -e "\n\n"
  echo -e "Manually create the ufo core as documented in chapter 9 and then re-run this script."
  exit 0
fi

echo -e "\n\n"
echo -e "pg 286"
echo -e "\n"

# TODO: Need to set the path to the ufo_awesome.json file after downloading/extracting as documented in chapter 9
UFO_DATA_JSON=

if [ "$UFO_DATA_JSON" == "" ] || [ ! -e $UFO_DATA_JSON ]; then
  echo -e "UFO data $UFO_DATA_JSON file not found!"
  echo -e "Please download the UFO data set from http://www.infochimps.com/datasets/60000-documented-ufo-sightings-with-text-descriptions-and-metada"
  echo -e "After downloading, extract the zip to a temp directory and set the UFO_DATA_JSON variable in this script to the ufo_awesome.json file."
  echo -e "\n\n"
  exit 1
fi

java -jar $SOLR_IN_ACTION/solr-in-action.jar ufo -jsonInput $UFO_DATA_JSON
echo -e "\n\n"
echo -e "pg 288"
echo -e "\n"
java -jar $SOLR_IN_ACTION/solr-in-action.jar listing 9.1 
echo -e "\n\n"
echo -e "pg 289"
echo -e "\n"
java -jar $SOLR_IN_ACTION/solr-in-action.jar listing 9.2 
echo -e "\n\n"
echo -e "pg 296"
echo -e "\n"
java -jar $SOLR_IN_ACTION/solr-in-action.jar listing 9.4 
echo -e "\n\n"
echo -e "pg 297"
echo -e "\n"
java -jar $SOLR_IN_ACTION/solr-in-action.jar listing 9.5 
echo -e "\n\n"
echo -e "pg 298"
echo -e "\n"
java -jar $SOLR_IN_ACTION/solr-in-action.jar listing 9.6 
echo -e "\n\n"
echo -e "pg 301"
echo -e "\n"
java -jar $SOLR_IN_ACTION/solr-in-action.jar listing 9.7 
