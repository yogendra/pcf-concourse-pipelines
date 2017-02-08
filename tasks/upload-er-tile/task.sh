#!/bin/bash
chmod + om-cli/om-linux

FILE_PATH=`find ./pivnet-er-product -name *.pivotal`

STEMCELL_VERSION=`cat ./pivnet-er-product/metadata.json | jq '.Dependencies[32].Release.Version'`

echo "Downloading stemcell"
pivnet-cli download-product-files -p stemcells -r $STEMCELL_VERSION -g "*vsphere*"

SC_FILE_PATH=`find ./ -name *.tgz`

./om-cli/om-linux -t https://$OPS_MGR_HOST -u $OPS_MGR_USR -p $OPS_MGR_PWD -k upload-product -p $FILE_PATH

./om-cli/om-linux -t https://$OPS_MGR_HOST -u $OPS_MGR_USR -p $OPS_MGR_PWD -k upload-stemcell -p $SC_FILE_PATH