s3_config=$1
object=$2
stage=$3
rm -rf ./$object_$stage
mkdir ./$object_$stage

aws s3 cp $s3_config ./$object_$stage/config.cfg

source ./$object_$stage/config.cfg

aws s3 cp $s3redshift ./$object_$stage/redshift.cfg

source ./$object_$stage/redshift.cfg

loggingschema="edw_dev_work"
loggingtablename="etl_log_t"

aws s3 cp $s3SQL ./$object_$stage/start.sql
aws s3 cp $s3finishedSQL ./$object_$stage/finished.sql
aws s3 cp $s3errorSQL ./$object_$stage/error.sql


startSQL="$(cat "./$object_$stage/start.sql" | sed -e s^\${loggingschema}^"$loggingschema"^ -e s^\${loggingtablename}^"$loggingtablename"^ -e s^\${redshiftschemaname}^"$redshiftschemaname"^ -e s^\${jobname}^"$jobname"^ -e s^\${columnlist}^"$columnlist"^ -e s^\${sfdcobject}^"$sfdcobject"^ -e s^\${s3jsonpathsfile}^"$s3jsonpathsfile"^ -e s^\${iamrole}^"$iamrole"^ -e s^\${stage}^"$stage"^)"

finishedSQL="$(cat "./$object_$stage/finished.sql" | sed -e s^\${loggingschema}^"$loggingschema"^ -e s^\${loggingtablename}^"$loggingtablename"^ -e s^\${redshiftschemaname}^"$redshiftschemaname"^ -e s^\${jobname}^"$jobname"^ -e s^\${columnlist}^"$columnlist"^ -e s^\${sfdcobject}^"$sfdcobject"^ -e s^\${s3jsonpathsfile}^"$s3jsonpathsfile"^ -e s^\${iamrole}^"$iamrole"^ -e s^\${stage}^"$stage"^)"

errorSQL="$(cat "./$object_$stage/error.sql" | sed  -e s^\${loggingschema}^"$loggingschema"^ -e s^\${loggingtablename}^"$loggingtablename"^ -e s^\${redshiftschemaname}^"$redshiftschemaname"^ -e s^\${jobname}^"$jobname"^ -e s^\${columnlist}^"$columnlist"^ -e s^\${sfdcobject}^"$sfdcobject"^ -e s^\${s3jsonpathsfile}^"$s3jsonpathsfile"^ -e s^\${iamrole}^"$iamrole"^ -e s^\${stage}^"$stage"^)"

export PGPASSWORD="$redshiftpassword"

psql -h ${redshifthostname} -U ${redshiftusername} -p ${redshiftport} -d ${redshiftdatabase} -c ${startSQL}

exitcode=$?

if [ $exitcode -eq 0 ];
	then echo 'hello';
	psql -A -q -h ${redshifthostname} -U ${redshiftusername} -p ${redshiftport} -d ${redshiftdatabase} -c ${finishedSQL}
else echo 'There was an error'
	psql -A -q -h ${redshifthostname} -U ${redshiftusername} -p ${redshiftport} -d ${redshiftdatabase} -c ${errorSQL}
	exit 100;
fi;

echo 'this happened';