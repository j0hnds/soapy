#!/bin/bash

xml=$(cat << EOF
<?xml version="1.0"?>
<care_area_update_request>
  <facility_identifier>12</facility_identifier>
  <care_areas>
    <id>80</id>
    <id>81</id>
  </care_areas>
</care_area_update_request>
EOF
)

echo $xml

curl -v \
  -H 'Content-type: application/xml' \
  -d "${xml}" \
  http://localhost:3000/WebServices/MedlineIntegration/Abaqis/updatefacility
