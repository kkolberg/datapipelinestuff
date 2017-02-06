INSERT INTO $loggingschema.$loggingtablename
						(
						 job_nm,
						 task_nm,
						 job_status,
						 job_status_detail,
						 job_system_msg)
					select 
						'${jobname}',
						'load_${stage}_${sfdcobject}',
						'Dataload Information',
						'This job inserted '||count(*)||' records of ${sfdcobject} data into table ${redshiftschemaname}.${stage}_${sfdcobject} successfully at '||max (meta_created_datetime),
						null
					from ${redshiftschemaname}.${stage}_${sfdcobject}
					where meta_created_datetime = (select max(meta_created_datetime) from ${redshiftschemaname}.${stage}_${sfdcobject})
					and meta_created_datetime>=(select max(log_tmstmp) from edw_dev_work.etl_log_t where job_nm='${jobname}' and task_nm='load_${stage}_${sfdcobject}')";	