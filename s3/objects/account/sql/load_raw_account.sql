INSERT INTO $loggingschema.$loggingtablename
						(
						 job_nm,
						 task_nm,
						 job_status,
						 job_status_detail,
						 job_system_msg)
					values
						(
						'${jobname}',
						'load_raw_${sfdcobject}',
						'started',
						null,
						null
						)
					;
                    DELETE FROM ${redshiftschemaname}.raw_${sfdcobject};
					COPY ${redshiftschemaname}.raw_${sfdcobject} ${columnlist}
					FROM '${s3datafile}' COMPUPDATE OFF credentials 'aws_iam_role=${iamrole}' 
					JSON '${s3jsonpathsfile}${sfdcobject}_staging_JSONPathsFile.json';

					INSERT INTO $loggingschema.$loggingtablename
						(
						 job_nm,
						 task_nm,
						 job_status,
						 job_status_detail,
						 job_system_msg)
					values
						(
						'${jobname}',
						'load_raw_${sfdcobject}',
						'completed',
						null,
						null
						)
					;