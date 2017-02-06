sudo yum -y install postgresql
s3_config=$1
 
aws s3 cp $s3_config ./load_ods_account.cfg

source ./load_ods_account.cfg

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
					
					
					