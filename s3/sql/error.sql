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
						'Error',
						'JobFailed',
						reason || ' on input line number ' || line_number
						from (
						select distinct 
							sl.tbl
							, trim(name) as table_name
							, sl.query
							, starttime
							, trim(filename) as input
							, line_number
							, colname
							, err_code
							, trim(err_reason) as reason
						from stl_load_errors sl, stv_tbl_perm sp, 
							(select max(query) as query, tbl from stl_load_errors group by tbl) mx
						where sl.tbl = sp.id and mx.tbl = sl.tbl and mx.query = sl.query
						)
					where table_name = '${stage}_${sfdcobject}'