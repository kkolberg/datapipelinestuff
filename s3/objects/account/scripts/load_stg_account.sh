sudo yum -y install postgresql
redshiftpassword=$1
redshiftdatabase=$2
redshiftusername=$3
redshifthostname=$4
redshiftport=$5
redshiftschemaname=$6
jobname=$7
sfdcobject=$8
iamrole=$9
loggingschema="edw_dev_work"
loggingtablename="etl_log_t"

echo $redshiftpassword
echo $redshiftdatabase
echo $redshiftusername
echo $redshifthostname
echo $redshiftport
echo $redshiftschemaname
echo $jobname
echo $sfdcobject
echo $iamrole