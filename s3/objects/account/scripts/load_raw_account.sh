s3_config=$1
rm -rf ./account
mkdir ./account

aws s3 cp $s3_config ./account/load_ods_account.cfg

source ./account/load_ods_account.cfg

aws s3 cp $s3redshift ./account/redshift.cfg

source .account/redshift.cfg

loggingschema="edw_dev_work"
loggingtablename="etl_log_t"
stage=rawSQL

echo $redshiftpassword
echo $redshiftdatabase
echo $redshiftusername
echo $redshifthostname
echo $redshiftport
echo $redshiftschemaname
echo $s3jsonpathsfile
echo $s3datafile
echo $jobname
echo $columnlist
echo $sfdcobject
echo $iamrole
echo $s3rawSQL
echo $s3finishedSQL
echo $s3errorSQL
echo $stage

aws s3 cp $s3rawSQL ./account/account_raw.sql
aws s3 cp $s3finishedSQL ./account/finished.sql
aws s3 cp $s3errorSQL ./account/error.sql

sedSubs="-e s/\${redshiftschemaname}/$redshiftschemaname/ \
-e s/\${jobname}/$jobname/ \
-e s/\${columnlist}/$columnlist/ \
-e s/\${sfdcobject}/$sfdcobject/ \
-e s/\${iamrole}/$iamrole/ \
-e s/\${stage}/$stage/"

rawSQL="$(cat "./account/account_raw.sql" | sed -n $sedSubs)"
finishedSQL="$(cat "./account/finished.sql" | sed -n $sedSubs)"
errorSQL="$(cat "./account/error.sql" | sed -n $sedSubs)"

echo $rawSQL
echo "-----"
echo $finishedSQL
echo "-----"
echo $errorSQL