-- *********************************************************************************  
-- *************************  tcc_fp_usr_df_delete_rule  ***************************  
-- *********************************************************************************
  
-- Function: tcc_fp_usr_df_delete_rule(integer, integer)

-- DROP FUNCTION tcc_fp_usr_df_delete_rule(integer, integer);

CREATE OR REPLACE FUNCTION tcc_fp_usr_df_delete_rule(i_appli_id integer, i_custom_trace integer)
  RETURNS integer AS
$BODY$
DECLARE  
  v_cal_flags integer;
  v_cal_mergeroot_id integer;
 L_ERRORCODE          INTEGER DEFAULT 0;
Begin 
-- Version 8.2.x - 1.9.0
  if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_DF_DELETE_RULE for appli_id ' || to_char(I_Appli_ID) || 'ENTRANCE ');   end if;
      -- Data entities are push to DELETED (8).
 UPDATE dss_datafunction df
     set cal_flags = cal_flags + 136     --> Set the bit for ignored by external script (128)+ Deleted (8)
from cdt_objects cob 
   WHERE  df.maintable_id =  cob.object_id
  and ( df.cal_flags & 8 ) = 0           --> ...except for data functions which are std and deleted (8)
   and ( df.cal_flags & 136 ) = 0           --> ...except for data functions which are external script and deleted (136)
   and ( df.cal_flags & 10 ) = 0           --> ...except for data functions which are root and deleted (10)
   and ( df.cal_flags & 140 ) = 0           --> ...except for data functions which are root and deleted and external script (140)
   and ( df.cal_flags & 256 ) = 0           --> ...except for data functions which are ignored (256)
   and ( df.cal_flags & 258 ) = 0           --> ...except for data functions which are root and ignored (258)
   and ( df.cal_flags & 260 ) = 0           --> ...except for data functions which are child and ignored (260)
   and df.cal_flags < 260           
 --  and user_fp_value is null
 --  and user_isinternal is null
     and df.cal_mergeroot_id = 0            --> ...except for child merged objects
     and (cob.object_type_str = 'Cobol File Link'
	 or cob.object_type_str = 'CICS DataSet'
         or cob.object_type_str = 'SQL Table'
         or cob.object_type_str = 'Oracle table'
         or cob.object_type_str = 'SAP Table'
         or cob.object_type_str = 'Sybase table'
         or cob.object_type_str = 'Microsoft table'
         or cob.object_type_str = 'SQL Server UDT TABLE'
         or cob.object_type_str = 'Siebel Table Data (Intersection)'
         or cob.object_type_str = 'Siebel Table Data (Private)'
         or cob.object_type_str = 'Siebel Table Data (Public)'
         or cob.object_type_str = 'Siebel Table Dictionary'
         or cob.object_type_str = 'Siebel Table Extension'
         or cob.object_type_str = 'Siebel Table Extension (Siebel)'
         or cob.object_type_str = 'Siebel Table External'
         or cob.object_type_str = 'Siebel Table External View'
         or cob.object_type_str = 'Siebel Table Interface'
         or cob.object_type_str = 'Siebel Table Log'
         or cob.object_type_str = 'Siebel Table Repository'
         or cob.object_type_str = 'Siebel Table Virtual Table'
         or cob.object_type_str = 'Siebel Table Warehouse'
		 or cob.object_type_str = 'DB400Table'
		 or cob.object_type_str = 'DDL Database Table'
		 )
     and (
         upper(cob.object_name) like '%_DUAL%'
		 or upper(cob.object_name) like 'TEST'
		 or upper(cob.object_name) like 'TEST?'
		 or upper(cob.object_name) like 'ERROR'
         or upper(cob.object_name) like '%\_DUMMY%'
         or upper(cob.object_name) like '%\_ERR%'
         or upper(cob.object_name) like '%-ERR%'
         or upper(cob.object_name) like '%\_ERROR%'
         or upper(cob.object_name) like '%-ERROR%'
         or upper(cob.object_name) like '%\_LOG%'
         or upper(cob.object_name) like '%\_OLD%'
         or upper(cob.object_name) like '%\_BAD%'
         or upper(cob.object_name) like '%\_BAK%'
         or upper(cob.object_name) like '%\_BKUP%'
         or upper(cob.object_name) like '%\_BK%'
         or upper(cob.object_name) like '%\_BACKUP%'
         or upper(cob.object_name) like '%\_LOG'             
         or upper(cob.object_name) like '%\_HST'
         or upper(cob.object_name) like '%\_HISTORY%'
	     or upper(cob.object_name) like '%\_HIST'
	     or upper(cob.object_name) like '%-DUAL%'
         or upper(cob.object_name) like '%\-DUMMY%'
         or upper(cob.object_name) like '%\-LOG%'
         or upper(cob.object_name) like '%\-OLD%'
         or upper(cob.object_name) like '%\-BAD%'
         or upper(cob.object_name) like '%\-BAK%'
         or upper(cob.object_name) like '%\-BKUP%'		 
         or upper(cob.object_name) like '%\-BACKUP%'
         or upper(cob.object_name) like '%\-BK%'
         or upper(cob.object_name) like '%\-LOG'             
         or upper(cob.object_name) like '%\-HST'
         or upper(cob.object_name) like '%\-HISTORY%'
	     or upper(cob.object_name) like '%\-HIST'
         or upper(cob.object_name) like '%\-H'
	     or upper(cob.object_name) like '%\_H'		 
         or upper(cob.object_name) like 'LOG\-%'
	     or upper(cob.object_name) like 'LOG\_%'
	     or upper(cob.object_name) like '%LOG'
         or upper(cob.object_name) like 'ERR\-%'
		 or upper(cob.object_name) like 'ERR\_%'		 
         or upper(cob.object_name) like '%TEST%'
         or upper(cob.object_name) like '%ERROR%'
         or upper(cob.object_name) like '%ERLOG%'
         or upper(cob.object_name) like '%ERRLOG%'
         or upper(cob.object_name) like '%ERR0%'
		 or upper(cob.object_name) like '%HISTORY%'
         -- or upper(cob.object_name) SIMILAR TO '%FILE[0-9]+'
         --<Application>Specific
         or upper(cob.object_name) SIMILAR TO '\?'
         or upper(cob.object_fullname) like '%.SYSIBM.%' -- System tables for DB2
         or upper(cob.object_fullname) like '%.SYS.%' -- System tables for Oracle
         or upper(cob.object_fullname) like '%.SYSTEM.%' -- System Tables for Oracle
         )
		   and df.appli_id = i_appli_id
         ;

/* SIEBEL DELETION OF INTERNAL TABLES */

update dss_datafunction df
     set cal_flags = cal_flags + 136     --> Set the bit for ignored by external script (128)+ Deleted (8)
from cdt_objects cob 
   WHERE  df.maintable_id =  cob.object_id
   and ( df.cal_flags & 8 ) = 0           --> ...except for data functions which are std and deleted (8)
   and ( df.cal_flags & 136 ) = 0           --> ...except for data functions which are external script and deleted (136)
   and ( df.cal_flags & 10 ) = 0           --> ...except for data functions which are root and deleted (10)
   and ( df.cal_flags & 140 ) = 0           --> ...except for data functions which are root and deleted and external script (140)
   and ( df.cal_flags & 256 ) = 0           --> ...except for data functions which are ignored (256)
   and ( df.cal_flags & 258 ) = 0           --> ...except for data functions which are root and ignored (258)
   and ( df.cal_flags & 260 ) = 0           --> ...except for data functions which are child and ignored (260)
      and df.cal_flags < 260   
     and df.cal_mergeroot_id = 0            --> ...except for child merged objects
     and (cob.object_type_str = 'Siebel Table Warehouse'
         or cob.object_type_str = 'Siebel Table Log'
         or cob.object_type_str = 'Siebel Table Repository'
         or cob.object_type_str = 'Siebel Table Virtual Table')
     and appli_id = i_appli_id; 

  if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_DF_DELETE_RULE for appli_id ' || to_char(I_Appli_ID) || 'EXIT ');   end if;	

  if ( I_CUSTOM_TRACE >  0 ) then  perform custom_tcc_fp_usr_df_delete_rule(i_appli_id, i_custom_trace);   end if;		
  
  
  Return L_ERRORCODE;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
/
ALTER FUNCTION tcc_fp_usr_df_delete_rule(integer, integer)
  OWNER TO operator
/


  
-- *********************************************************************************  
-- ************************  tcc_fp_usr_df_adj_detret_rule  ************************  
-- *********************************************************************************

-- Function: tcc_fp_usr_df_adj_detret_rule(integer, integer)

-- DROP FUNCTION tcc_fp_usr_df_adj_detret_rule(integer, integer);

CREATE OR REPLACE FUNCTION tcc_fp_usr_df_adj_detret_rule(i_appli_id integer, i_custom_trace integer)
  RETURNS integer AS
$BODY$
DECLARE  
 L_ERRORCODE          INTEGER DEFAULT 0;
Begin 
-- Version 8.2.x - 1.9.0
	if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_DF_ADJ_DETRET_RULE for appli_id ' || to_char(I_Appli_ID) || ' ENTRANCE'); end if;
	if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_DF_ADJ_DETRET_RULE for appli_id ' || to_char(I_Appli_ID) || ' EXIT'); end if;
    if ( I_CUSTOM_TRACE >  0 ) then  perform custom_tcc_fp_usr_df_adj_detret_rule(i_appli_id, i_custom_trace);   end if;
  Return L_ERRORCODE;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
/
ALTER FUNCTION tcc_fp_usr_df_adj_detret_rule(integer, integer)
  OWNER TO operator
/


-- *********************************************************************************  
-- *************************  tcc_fp_usr_df_ignore_rule  ***************************  
-- ********************************************************************************* 
-- Function: tcc_fp_usr_df_ignore_rule(integer, integer)

-- DROP FUNCTION tcc_fp_usr_df_ignore_rule(integer, integer);

CREATE OR REPLACE FUNCTION tcc_fp_usr_df_ignore_rule(i_appli_id integer, i_custom_trace integer)
  RETURNS integer AS
$BODY$
DECLARE  
L_ERRORCODE          INTEGER DEFAULT 0;
Begin 
-- Version 8.2.x - 1.9.0
     if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_DF_IGNORE_RULE for appli_id ' || to_char(I_Appli_ID)|| ' ENTRANCE'); end if; 
--- Ignore Unknown data entities
perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_DF_IGNORE_RULE for appli_id ' || to_char(I_Appli_ID) || ' Ignore Unknown data entities'); 
update dss_datafunction df
     set cal_flags = cal_flags + 256     --> Set the bit for ignored by external script (128)+ Deleted (8)
from cdt_objects cob 
   WHERE  df.maintable_id =  cob.object_id
   and ( df.cal_flags & 8 ) = 0           --> ...except for data functions which are std and deleted (8)
   and ( df.cal_flags & 136 ) = 0           --> ...except for data functions which are external script and deleted (136)
   and ( df.cal_flags & 10 ) = 0           --> ...except for data functions which are root and deleted (10)
   and ( df.cal_flags & 140 ) = 0           --> ...except for data functions which are root and deleted and external script (140)
   and ( df.cal_flags & 256 ) = 0           --> ...except for data functions which are ignored (256)
   and ( df.cal_flags & 258 ) = 0           --> ...except for data functions which are root and ignored (258)
   and ( df.cal_flags & 260 ) = 0           --> ...except for data functions which are child and ignored (260)
      and df.cal_flags < 260   
     and df.cal_mergeroot_id = 0            --> ...except for child merged objects
     and (cob.object_fullname like '%Unknown%')
     and appli_id = i_appli_id; 
		 
 --Ignore tables with det <3
update dss_datafunction df
     set cal_flags = cal_flags + 256     --> Set the bit for ignored by external script (128)+ Deleted (8)
from cdt_objects cob 
   WHERE  df.maintable_id =  cob.object_id
   and ( df.cal_flags & 8 ) = 0           --> ...except for data functions which are std and deleted (8)
   and ( df.cal_flags & 136 ) = 0           --> ...except for data functions which are external script and deleted (136)
   and ( df.cal_flags & 10 ) = 0           --> ...except for data functions which are root and deleted (10)
   and ( df.cal_flags & 140 ) = 0           --> ...except for data functions which are root and deleted and external script (140)
   and ( df.cal_flags & 256 ) = 0           --> ...except for data functions which are ignored (256)
   and ( df.cal_flags & 258 ) = 0           --> ...except for data functions which are root and ignored (258)
   and ( df.cal_flags & 260 ) = 0           --> ...except for data functions which are child and ignored (260)
      and df.cal_flags < 260   
     and df.cal_mergeroot_id = 0            --> ...except for child merged objects
     and df.det < 3
     and df.ret = 1
     and (cob.object_type_str = 'SQL Table'
         or cob.object_type_str = 'Oracle table'
         or cob.object_type_str = 'SAP Table'
         or cob.object_type_str = 'Sybase table'
         or cob.object_type_str = 'Microsoft table'
         or cob.object_type_str = 'SQL Server UDT TABLE'
		 or cob.object_type_str = 'Siebel Table Data (Intersection)'
         or cob.object_type_str = 'Siebel Table Data (Private)'
         or cob.object_type_str = 'Siebel Table Data (Public)'
         or cob.object_type_str = 'Siebel Table Dictionary'
         or cob.object_type_str = 'Siebel Table Extension'
         or cob.object_type_str = 'Siebel Table Extension (Siebel)'
         or cob.object_type_str = 'Siebel Table External'
         or cob.object_type_str = 'Siebel Table External View'
         or cob.object_type_str = 'Siebel Table Interface'
         or cob.object_type_str = 'Siebel Table Log'
         or cob.object_type_str = 'Siebel Table Repository'
         or cob.object_type_str = 'Siebel Table Virtual Table'
         or cob.object_type_str = 'Siebel Table Warehouse'
		 or cob.object_type_str = 'DB400Table'
		 or cob.object_type_str = 'DDL Database Table')
     and appli_id = i_appli_id; 
       
  -- regular filter - on DB2 table, cobol file links
  -- Tables are push to ignored (256) in order to limit the impact on the transaction definition.
update dss_datafunction df
     set cal_flags = cal_flags + 256     --> Set the bit for ignored by external script (128)+ Deleted (8)
from cdt_objects cob 
   WHERE  df.maintable_id =  cob.object_id
   and ( df.cal_flags & 8 ) = 0           --> ...except for data functions which are std and deleted (8)
   and ( df.cal_flags & 136 ) = 0           --> ...except for data functions which are external script and deleted (136)
   and ( df.cal_flags & 10 ) = 0           --> ...except for data functions which are root and deleted (10)
   and ( df.cal_flags & 140 ) = 0           --> ...except for data functions which are root and deleted and external script (140)
   and ( df.cal_flags & 256 ) = 0           --> ...except for data functions which are ignored (256)
   and ( df.cal_flags & 258 ) = 0           --> ...except for data functions which are root and ignored (258)
   and ( df.cal_flags & 260 ) = 0           --> ...except for data functions which are child and ignored (260)
      and df.cal_flags < 260   
     and df.cal_mergeroot_id = 0            --> ...except for child merged objects
     and (cob.object_type_str = 'Cobol File Link'
             or cob.object_type_str = 'SQL Table'
         or cob.object_type_str = 'Oracle table'
         or cob.object_type_str = 'SAP Table'
         or cob.object_type_str = 'Sybase table'
         or cob.object_type_str = 'Microsoft table'
         or cob.object_type_str = 'SQL Server UDT TABLE'
		 or cob.object_type_str = 'DB400Table'
		 or cob.object_type_str = 'DDL Database Table')
            and (
                upper(cob.object_name) like '%ADMIN%'
             or upper(cob.object_name) like '%ALERT%'
             or upper(cob.object_name) like '%ARCHIVE%'
	     or upper(cob.object_name) like '%COPY%'
	     or upper(cob.object_name) like '%TEMP\-%'
             or upper(cob.object_name) like '%EXTRACT%'
             or upper(cob.object_name) like '%CONFIG%'
             or upper(cob.object_name) like '%DEFAULT%'
             or upper(cob.object_name) like '%HIST%'
             or upper(cob.object_name) like '%INFO%'
             or upper(cob.object_name) like '%MESSAGE%'
             or upper(cob.object_name) like '%MSG%'
             or upper(cob.object_name) like '%PARAM%'
             or upper(cob.object_name) like '%PLAN\_%'
             or upper(cob.object_name) like '%PURGE%'
             or upper(cob.object_name) like '%SCHEDULE%'
             or upper(cob.object_name) like '%\_TEMP%'
             or upper(cob.object_name) like '%TEMPLATES%'
             or upper(cob.object_name) like '%TOAD\_%'
             or upper(cob.object_name) like '%TMP%'
             or upper(cob.object_name) like '%WRK%'
             or upper(cob.object_name) like '%DUMP%'
             or upper(cob.object_name) like '%CODE%'
             or upper(cob.object_name) like '%\_REF'
             or upper(cob.object_name) like '%\_CODE%'
             or upper(cob.object_name) like '%\_DUMP%'
             or upper(cob.object_name) like '%\_IMPL%'
             or upper(cob.object_name) like '%\_JOB%'
             or upper(cob.object_name) like '%\_LIST%'
             or upper(cob.object_name) like '%\_MAP%'
             or upper(cob.object_name) like '%\_STG%'
             or upper(cob.object_name) like '%\_TECH_%'
             or upper(cob.object_name) like '%\_TYPE%'
             or upper(cob.object_name) like '%\-CODE%'
             or upper(cob.object_name) like '%\-DUMP%'
             or upper(cob.object_name) like '%\-IMPL%'
             or upper(cob.object_name) like '%\-JOB%'
             or upper(cob.object_name) like '%\-LIST%'
             or upper(cob.object_name) like '%\-MAP%'
             or upper(cob.object_name) like '%\-STG%'
             or upper(cob.object_name) like '%\-TECH_%'
             or upper(cob.object_name) like '%\-TYPE%'
            -- or upper(cob.object_name) SIMILAR TO '%[0-9]+'
             -- or upper(cob.object_name) like '%FILE%'
             --<Application>Specific
            or upper(cob.object_name) SIMILAR TO '\?'
            or upper(cob.object_name) SIMILAR TO '\?\?'
            or length(cob.object_name) < 4
           )
     and appli_id = i_appli_id;         
	 
/* SIEBEL IGNORE OF INTERNAL TABLES */
update dss_datafunction df
     set cal_flags = cal_flags + 256     --> Set the bit for ignored by external script (128)+ Deleted (8)
from cdt_objects cob 
   WHERE  df.maintable_id =  cob.object_id
   and ( df.cal_flags & 8 ) = 0           --> ...except for data functions which are std and deleted (8)
   and ( df.cal_flags & 136 ) = 0           --> ...except for data functions which are external script and deleted (136)
   and ( df.cal_flags & 10 ) = 0           --> ...except for data functions which are root and deleted (10)
   and ( df.cal_flags & 140 ) = 0           --> ...except for data functions which are root and deleted and external script (140)
   and ( df.cal_flags & 256 ) = 0           --> ...except for data functions which are ignored (256)
   and ( df.cal_flags & 258 ) = 0           --> ...except for data functions which are root and ignored (258)
   and ( df.cal_flags & 260 ) = 0           --> ...except for data functions which are child and ignored (260)
      and df.cal_flags < 260   
     and df.cal_mergeroot_id = 0            --> ...except for child merged objects
     and (cob.object_type_str = 'Siebel Table Unknown Type')
     and appli_id = i_appli_id;         
      
  --Ignore Cobol File Link which are in a transaction which reach a DB exept if the table contain ERR
  UPDATE dss_datafunction SET cal_flags = 256 WHERE maintable_id IN (select distinct cfl.child_id
		from (select dtd.object_id, dtd.child_id from dss_transactionDetails dtd, cdt_objects cob
		where cob.object_id = child_id
		and cob.object_type_str = 'Cobol File Link') cfl,
		(select dtd.object_id, dtd.child_id from dss_transactionDetails dtd, cdt_objects cob
		where cob.object_id = child_id
		and cob.object_type_str in ('SQL Table','SQL View')
		and cob.object_name not like '%ERR%') tabl,
		cdt_objects cob
		where
		tabl.object_id = cfl.object_id
		and cob.object_id = cfl.child_id)  and appli_id = i_appli_id;

--Ignore Cobol File Link which Refere a JCL Data Set
-- **********  BUG ON FREE DEFINITION CODE READY AS SOON WE CAN SELECT JCL DATASET
--  UPDATE dss_datafunction SET cal_flags = 256 WHERE maintable_id IN (		
--		select cli.caller_id from ctv_links cli, cdt_objects caller, cdt_objects called
--		where called.object_id = called_id
--		and caller.object_id = caller_id
--		and caller.object_type_str = 'Cobol File Link'
--		and called.object_type_str = 'JCL Data Set') and appli_id = i_appli_id;
  
--Ignore JCL Data Set not refered by a Cobol File Link
  UPDATE dss_datafunction SET cal_flags = 256 WHERE maintable_id IN (select object_id from cdt_objects called
		where called.object_type_str = 'JCL Data Set' and object_id not in (
		select cli.called_id from ctv_links cli, cdt_objects caller, cdt_objects called
		where called.object_id = called_id
		and caller.object_id = caller_id
		and caller.object_type_str = 'Cobol File Link'
		and called.object_type_str = 'JCL Data Set')) and appli_id = i_appli_id; 
 
  --Ignore CICS Data Set which are in a transaction which reach a DB exept if the table contain ERR
  UPDATE dss_datafunction SET cal_flags = 256 WHERE maintable_id IN (select distinct cfl.child_id
		from (select dtd.object_id, dtd.child_id from dss_transactionDetails dtd, cdt_objects cob
		where cob.object_id = child_id
		and cob.object_type_str = 'CICS Data Set') cfl,
		(select dtd.object_id, dtd.child_id from dss_transactionDetails dtd, cdt_objects cob
		where cob.object_id = child_id
		and cob.object_type_str in ('SQL Table','SQL View')
		and cob.object_name not like '%ERR%') tabl,
		cdt_objects cob
		where
		tabl.object_id = cfl.object_id
		and cob.object_id = cfl.child_id)  and appli_id = i_appli_id;
		
  --Ignore Cobol File Link and JCL DataSet and CICS Dataset if DB2 or IMS DB in the boundary
    if ( Exists(SELECT DISTINCT 1 FROM cdt_objects WHERE object_type_str = 'SQL Table' OR object_type_str = 'Oracle table' OR object_type_str = 'SAP Table' OR object_type_str = 'Sybase table' OR object_type_str = 'Microsoft table' OR object_type_str = 'SQL Server UDT TABLE' OR object_type_str = 'IMS Segment' or object_type_str = 'DB400Table' or object_type_str = 'DDL Database Table')) then
       -- UPDATE dss_datafunction SET cal_flags = 256 WHERE maintable_id IN (SELECT o.object_id FROM cdt_objects o WHERE o.object_type_str = 'Cobol File Link') and appli_id = i_appli_id;
       -- UPDATE dss_datafunction SET cal_flags = 256 WHERE maintable_id IN (SELECT o.object_id FROM cdt_objects o WHERE o.object_type_str = 'JCL Data Set') and appli_id = i_appli_id;
       -- UPDATE dss_datafunction SET cal_flags = 256 WHERE maintable_id IN (SELECT o.object_id FROM cdt_objects o WHERE o.object_type_str = 'CICS Data Set') and appli_id = i_appli_id;
    end if;
	
     if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_DF_IGNORE_RULE for appli_id ' || to_char(I_Appli_ID)|| ' EXIT'); end if; 
	 if ( I_CUSTOM_TRACE >  0 ) then  perform custom_tcc_fp_usr_df_ignore_rule(i_appli_id, i_custom_trace);   end if;
  Return L_ERRORCODE;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
/
ALTER FUNCTION tcc_fp_usr_df_ignore_rule(integer, integer)
  OWNER TO operator
/
 
-- *********************************************************************************  
-- *************************  tcc_fp_usr_df_group_rule  ***************************  
-- *********************************************************************************  
-- Function: tcc_fp_usr_df_group_rule(integer, integer)

-- DROP FUNCTION tcc_fp_usr_df_group_rule(integer, integer);

CREATE OR REPLACE FUNCTION tcc_fp_usr_df_group_rule(i_appli_id integer, i_custom_trace integer)
  RETURNS integer AS
$BODY$
DECLARE 
 v_object_name text;
  v_fp_id integer;
  v_cal_flags integer;
  v_cal_mergeroot_id integer;
  v_object_id integer;
L_ERRORCODE          INTEGER DEFAULT 0;
-- Cursor for Exact matching grouping (Drop duplicates)
  crs cursor for
    select o.object_name, d.object_id fp_id
      from cdt_objects o, dss_datafunction d
     where o.object_id = d.maintable_id
       and d.cal_flags in (0, 2)
       and o.object_name in (
         select o.object_name
           from cdt_objects o, dss_datafunction d
          where o.object_id = d.maintable_id
            and d.cal_flags in (0, 2)
          group by o.object_name, o.object_type_str
         having count(1) > 1)
     order by d.appli_id, o.object_type_str, o.object_name, d.cal_flags desc, o.object_fullname, d.object_id ;
-- Cursor for Similar matching grouping with a number at the end
  crs2 cursor for
      select substring(o.object_name from '([a-zA-Z0-9\-\_]+)[0-9]+$') prefix_name, d.object_id fp_id, d.appli_id
      from cdt_objects o, dss_datafunction d
     where o.object_id = d.maintable_id
       and d.cal_flags in (0, 2)
       and length(substring(o.object_name from '([a-zA-Z0-9\-\_]+)[0-9]+$')) > 2 -- Minimum prefix size
       and d.appli_id = i_appli_id
	   order by prefix_name asc ;
-- Cursor for Similar matching grouping with second section of part similar.
  crs3 cursor for
      select substring(o.object_name from '([a-zA-Z0-9\-\_]+)(\_|\-)[\-\_a-zA-Z0-9]+$') prefix_name, d.object_id fp_id, d.appli_id
      from cdt_objects o, dss_datafunction d	
     where o.object_id = d.maintable_id
       and d.cal_flags in (0, 2)
       and length(substring(o.object_name from '([a-zA-Z0-9\-\_]+)(\_|\-)[a-zA-Z0-9]+$')) > 2 -- Minimum prefix size
       and d.appli_id = i_appli_id
	   order by prefix_name asc ;
      
Begin 
-- Version 8.2.x - 1.9.0
     if ( I_CUSTOM_TRACE >  0 )
       then  perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_DF_GROUP_RULE for appli_id ' || to_char(I_Appli_ID));
       --- Group
    perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_DF_GROUP_RULE for appli_id ' || to_char(I_Appli_ID) || 'Group data entities with Same Name');
     --Merge duplicates - Action is to group element with the same name under a unique group. This is apply on both valid and ignored transaction since this will have an impact on the FTR.
  v_object_name := '';
  v_fp_id := -1;
   for r in crs loop
    if (v_object_name = r.object_name) then
      update dss_datafunction
         set cal_flags = 2                 --put parent(v_fp_id) cal_flags to 2
       where object_id = v_fp_id
	   and appli_id = i_appli_id;
          
      update dss_datafunction
         set cal_flags = 4,                --put child (r.fp_id) cal_flags to 4
             cal_mergeroot_id = v_fp_id    --put cal_mergeroot_id to parent(v_fp_id)
       where object_id = r.fp_id
	   and appli_id = i_appli_id;
    else
      v_fp_id := r.fp_id;                  --If not the same we change the root_id to the current one in the loop. fp_id contains the root_id, it changes when the object_name changes
    end if;
    v_object_name := r.object_name;        --Next object.
  end loop;   
 --- Group
    perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_DF_GROUP_RULE for appli_id ' || to_char(I_Appli_ID) || 'Group data entities with the same name ending by a number under a unique group');
-- Action is to group element with the same name ending by a number under a unique group
  v_object_name := '';
  v_fp_id := -1;
  for r2 in crs2 loop
    if (Exists(Select 1 from dss_datafunction df, cdt_objects o where df.maintable_id = o.object_id and o.object_name = r2.prefix_name and df.appli_id = r2.appli_id)) then
        --
        Select df.cal_flags, df.cal_mergeroot_id, df.object_id
          into v_cal_flags, v_cal_mergeroot_id, v_object_id
          from dss_datafunction df, cdt_objects o
         where df.maintable_id = o.object_id
           and o.object_name = r2.prefix_name
           and df.appli_id = r2.appli_id;
               
        if(v_cal_flags = 0) then
            -- parent not grouped
            --put parent(v_object_id) cal_flags to 2
            update dss_datafunction set cal_flags = 2 where object_id = v_object_id and appli_id = i_appli_id;
            --put child (r2.fp_id) cal_flags to 4
            --put child (r2.fp_id) cal_mergeroot_id to v_object_id
            update dss_datafunction set cal_flags = 4,cal_mergeroot_id = v_object_id where object_id = r2.fp_id and appli_id = i_appli_id;
        else 
		if(v_cal_flags = 2) then
            -- parent is root of existing group
            --put child (r2.fp_id) cal_flags to 4
            --put child (r2.fp_id) cal_mergeroot_id to v_object_id
            update dss_datafunction set cal_flags = 4,cal_mergeroot_id = v_object_id where object_id = r2.fp_id and appli_id = i_appli_id;
        else
        if(v_cal_flags = 4) then
            -- parent is a child in a existing group
            --put child (r2.fp_id) cal_flags to 4
            --put child (r2.fp_id) cal_mergeroot_id to v_cal_mergeroot_id
			-- adding constraint  and object_id != v_cal_mergeroot_id in order to fix the SCRAIP-22868
            update dss_datafunction set cal_flags = 4,cal_mergeroot_id = v_cal_mergeroot_id where object_id = r2.fp_id and appli_id = i_appli_id and object_id != v_cal_mergeroot_id;
        else
        if(v_cal_flags = 256) then
            -- parent is ignored
            --put parent(v_object_id) cal_flags to 258
            update dss_datafunction set cal_flags = 258 where object_id = v_object_id and appli_id = i_appli_id;
            --put child (r2.fp_id) cal_flags to 260
            --put child (r2.fp_id) cal_mergeroot_id to v_object_id
            update dss_datafunction set cal_flags = 260,cal_mergeroot_id = v_object_id where object_id = r2.fp_id and appli_id = i_appli_id;
        else
        if(v_cal_flags = 258) then
            -- parent is ignored and root
            --put child (r2.fp_id) cal_flags to 260
            --put child (r2.fp_id) cal_mergeroot_id to v_object_id
            update dss_datafunction set cal_flags = 260,cal_mergeroot_id = v_object_id where object_id = r2.fp_id and appli_id = i_appli_id;
        else
        if(v_cal_flags = 260) then
            -- parent is ignored and child
            --put child (r2.fp_id) cal_flags to 260
            --put child (r2.fp_id) cal_mergeroot_id to v_cal_mergeroot_id
            -- adding constraint  and object_id != v_cal_mergeroot_id in order to fix the SCRAIP-22868 (ticket 7458)
			update dss_datafunction set cal_flags = 260,cal_mergeroot_id = v_cal_mergeroot_id where object_id = r2.fp_id and appli_id = i_appli_id and object_id != v_cal_mergeroot_id;
        end if; end if;end if;end if;end if;end if;
    end if;
  end loop;
--- Group
    perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_DF_GROUP_RULE for appli_id ' || to_char(I_Appli_ID) || 'Group data entities with the same name under a unique group');
  v_object_name := '';
  v_fp_id := -1;
  for r2 in crs3 loop
    if (Exists(Select 1 from dss_datafunction df, cdt_objects o where df.maintable_id = o.object_id and o.object_name = r2.prefix_name and df.appli_id = r2.appli_id)) then
        --
        Select df.cal_flags, df.cal_mergeroot_id, df.object_id
          into v_cal_flags, v_cal_mergeroot_id, v_object_id
          from dss_datafunction df, cdt_objects o
         where df.maintable_id = o.object_id
           and o.object_name = r2.prefix_name
           and df.appli_id = r2.appli_id;
               
        if(v_cal_flags = 0) then
            -- parent not grouped
            --put parent(v_object_id) cal_flags to 2
            update dss_datafunction set cal_flags = 2 where object_id = v_object_id and appli_id = i_appli_id;
            --put child (r2.fp_id) cal_flags to 4
            --put child (r2.fp_id) cal_mergeroot_id to v_object_id
            update dss_datafunction set cal_flags = 4,cal_mergeroot_id = v_object_id where object_id = r2.fp_id and appli_id = i_appli_id;
        else
        if(v_cal_flags = 2) then
            -- parent is root of existing group
            --put child (r2.fp_id) cal_flags to 4
            --put child (r2.fp_id) cal_mergeroot_id to v_object_id
            update dss_datafunction set cal_flags = 4,cal_mergeroot_id = v_object_id where object_id = r2.fp_id and appli_id = i_appli_id;
        else 
        if(v_cal_flags = 4) then
            -- parent is a child in a existing group
            --put child (r2.fp_id) cal_flags to 4
            --put child (r2.fp_id) cal_mergeroot_id to v_cal_mergeroot_id
			-- adding constraint  and object_id != v_cal_mergeroot_id in order to fix the SCRAIP-22868 (ticket 7458)
            update dss_datafunction set cal_flags = 4,cal_mergeroot_id = v_cal_mergeroot_id where object_id = r2.fp_id and appli_id = i_appli_id and object_id != v_cal_mergeroot_id;
        else 
        if(v_cal_flags = 256) then
            -- parent is ignored
            --put parent(v_object_id) cal_flags to 258
            update dss_datafunction set cal_flags = 258 where object_id = v_object_id and appli_id = i_appli_id;
            --put child (r2.fp_id) cal_flags to 260
            --put child (r2.fp_id) cal_mergeroot_id to v_object_id
            update dss_datafunction set cal_flags = 260,cal_mergeroot_id = v_object_id where object_id = r2.fp_id and appli_id = i_appli_id;
        else 
        if(v_cal_flags = 258) then
            -- parent is ignored and root
            --put child (r2.fp_id) cal_flags to 260
            --put child (r2.fp_id) cal_mergeroot_id to v_object_id
            update dss_datafunction set cal_flags = 260,cal_mergeroot_id = v_object_id where object_id = r2.fp_id and appli_id = i_appli_id;
        else 
        if(v_cal_flags = 260) then
            -- parent is ignored and child
            --put child (r2.fp_id) cal_flags to 260
            --put child (r2.fp_id) cal_mergeroot_id to v_cal_mergeroot_id
			-- adding constraint  and object_id != v_cal_mergeroot_id in order to fix the SCRAIP-22868 (ticket 7458)
            update dss_datafunction set cal_flags = 260,cal_mergeroot_id = v_cal_mergeroot_id where object_id = r2.fp_id and appli_id = i_appli_id and object_id != v_cal_mergeroot_id;
        end if; end if;end if;end if;end if;end if;
    end if;
  end loop;
   
    -- Remove invalid self-merge of a Data Function to itself (SCRAIP-22730)
    Update DSS_DataFunction
       Set Cal_MergeRoot_ID = 0          -- The affected DF stops having itself as merge root
         , Cal_Flags = ( Cal_Flags - 4 ) -- The affected DF stops being a merged item of itself
     Where Object_ID = Cal_MergeRoot_ID
       And Appli_ID = I_Appli_ID;
 
   
     end if;
	 if ( I_CUSTOM_TRACE >  0 ) then  perform custom_tcc_fp_usr_df_group_rule(i_appli_id, i_custom_trace);   end if;
  Return L_ERRORCODE;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
/
ALTER FUNCTION tcc_fp_usr_df_group_rule(integer, integer)
  OWNER TO operator
/


  
-- *********************************************************************************  
-- *************************  tcc_fp_usr_df_adj_type_rule  *************************  
-- *********************************************************************************
-- Function: tcc_fp_usr_df_adj_type_rule(integer, integer)

-- DROP FUNCTION tcc_fp_usr_df_adj_type_rule(integer, integer);

CREATE OR REPLACE FUNCTION tcc_fp_usr_df_adj_type_rule(i_appli_id integer, i_custom_trace integer)
  RETURNS integer AS
$BODY$
DECLARE  
 L_ERRORCODE          INTEGER DEFAULT 0;
Begin 
-- Version 8.2.x - 1.9.0
	if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_DF_ADJ_TYPE_RULE for appli_id ' || to_char(I_Appli_ID) || ' ENTRANCE '); 	end if;

 UPDATE dss_datafunction df 
        SET user_isinternal = 1
 from cdt_objects cob 
 WHERE  df.maintable_id =  cob.object_id
          and (upper(cob.object_name) like '%\-OUT' 
		  or upper(cob.object_name) like '%OUTPUT%' 
		  or upper(cob.object_name) like 'OUT%' 
		  or upper(cob.object_name) like '%\-O\-%' 
		  or upper(cob.object_name) like '%OUT' 
		  or upper(cob.object_name) like '%OUT\-%'
		  or upper(cob.object_name) like '%OUT\_%'
		  or upper(cob.object_name) like '%REPORT%'
		  or upper(cob.object_name) like '%RPT%'
		  or upper(cob.object_name) like '%INSERT%'
		  or upper(cob.object_name) like '%UPDATE%'
		  or upper(cob.object_name) like '%UPDT%'
		  or upper(cob.object_name) like '%DELETE%'
		)
          and cob.object_type_str = 'Cobol File Link'
          and df.user_isinternal is null
	  and df.appli_id = i_appli_id;
          
   -- FORCE EXTERNAL FLAG on 'cobol file links' if name contains INPUT or end with -IN
 UPDATE dss_datafunction df 
        SET user_isinternal = 0
 from cdt_objects cob 
 WHERE  df.maintable_id =  cob.object_id
          and (   cob.object_name like '%\-IN' 
		  or upper(cob.object_name) like '%INPUT%'
		  or upper(cob.object_name) like '%\-I\-%'
		  or upper(cob.object_name) like '%IN\-%'
		  or upper(cob.object_name) like '%IN\_%'
		  or upper(cob.object_name) like '%READ%'
		  or upper(cob.object_name) like '%LOAD%'
		)
          and cob.object_type_str = 'Cobol File Link'
          and df.user_isinternal is null
	  and df.appli_id = i_appli_id;
	  
 -- FORCE INTERNAL FLAG on SIEBEL TABLES
 UPDATE dss_datafunction df 
        SET user_isinternal = 1
 from cdt_objects cob 
 WHERE  df.maintable_id =  cob.object_id
          and (cob.object_type_str = 'Siebel Table Data (Intersection)' 
          or cob.object_type_str = 'Siebel Table Extension' 
          or cob.object_type_str = 'Siebel Table Data Extension (Siebel)')
          and user_isinternal is null
	  and df.appli_id = i_appli_id;
         
   -- FORCE EXTERNAL FLAG on SIEBEL TABLES
 UPDATE dss_datafunction df 
        SET user_isinternal = 0
 from cdt_objects cob 
 WHERE  df.maintable_id =  cob.object_id
          and (cob.object_type_str = 'Siebel Table Data (Private)' 
		or cob.object_type_str = 'Siebel Table Data (Public)' 
		or cob.object_type_str = 'Siebel Table Data Extension (Siebel)'
		or cob.object_type_str = 'Siebel Table External'
		or cob.object_type_str = 'Siebel Table External View'
		or cob.object_type_str = 'Siebel Table Interface'
		or cob.object_type_str = 'Siebel Table Dictionary'	
          )
          and user_isinternal is null
	  and df.appli_id = i_appli_id;
          
	if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_DF_ADJ_TYPE_RULE for appli_id ' || to_char(I_Appli_ID) || ' EXIT '); 	end if;
	if ( I_CUSTOM_TRACE >  0 ) then  perform custom_tcc_fp_usr_df_adj_type_rule(i_appli_id, i_custom_trace);   end if;
  Return L_ERRORCODE;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
/
ALTER FUNCTION tcc_fp_usr_df_adj_type_rule(integer, integer)
  OWNER TO operator
/

 
  
  
-- *********************************************************************************  
-- *************************  tcc_fp_usr_tf_delete_rule  ***************************  
-- *********************************************************************************   
-- Function: tcc_fp_usr_tf_delete_rule(integer, integer)

-- DROP FUNCTION tcc_fp_usr_tf_delete_rule(integer, integer);

CREATE OR REPLACE FUNCTION tcc_fp_usr_tf_delete_rule(i_appli_id integer, i_custom_trace integer)
  RETURNS integer AS
$BODY$
DECLARE 
  v_fp_id integer;
 L_ERRORCODE          INTEGER DEFAULT 0;
Begin 
-- Version 8.2.x - 1.9.0
    if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_TF_DELETE_RULE for appli_id ' || to_char(I_Appli_ID)|| 'ENTRANCE '); end if;
	
   -- DELETE
  -- regular filter - on DB2 table, cobol file links
  -- Data entities are push to DELETED (8).
  v_fp_id := -1;
 UPDATE dss_transaction tra
     set cal_flags = cal_flags + 136     --> Set the bit for ignored by external script (128)+ Deleted (8)
from cdt_objects cob 
   WHERE  tra.form_id =  cob.object_id
  and ( tra.cal_flags & 8 ) = 0           --> ...except for data functions which are std and deleted (8)
   and ( tra.cal_flags & 136 ) = 0           --> ...except for data functions which are external script and deleted (136)
   and ( tra.cal_flags & 10 ) = 0           --> ...except for data functions which are root and deleted (10)
   and ( tra.cal_flags & 140 ) = 0           --> ...except for data functions which are root and deleted and external script (140)
   and ( tra.cal_flags & 256 ) = 0           --> ...except for data functions which are ignored (256)
   and ( tra.cal_flags & 258 ) = 0           --> ...except for data functions which are root and ignored (258)
   and ( tra.cal_flags & 260 ) = 0           --> ...except for data functions which are child and ignored (260)
      and tra.cal_flags < 260   
 --  and user_fp_value is null
 --  and user_isinternal is null
     and tra.cal_mergeroot_id = 0            --> ...except for child merged objects
     and (upper(cob.object_name) like '%.JS'
            or upper(cob.object_name) like '%.INC'
            or upper(cob.object_name) like '%ERROR%' 
			or upper(cob.object_name) like '%.CSS' 
		    or (cob.object_name = '1000' and cob.object_type_str = 'ABAP Selection Screen')
          ) 
	and appli_id = i_appli_id;


 
	
    if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_TF_DELETE_RULE for appli_id ' || to_char(I_Appli_ID)|| 'EXIT '); end if;       
    if ( I_CUSTOM_TRACE >  0 ) then  perform custom_tcc_fp_usr_tf_delete_rule(i_appli_id, i_custom_trace);   end if;
  Return L_ERRORCODE;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
/
ALTER FUNCTION tcc_fp_usr_tf_delete_rule(integer, integer)
  OWNER TO operator
/


  
-- *********************************************************************************  
-- *************************  tcc_fp_usr_tf_ignore_rule  ***************************  
-- *********************************************************************************   
-- Function: tcc_fp_usr_tf_ignore_rule(integer, integer)

-- DROP FUNCTION tcc_fp_usr_tf_ignore_rule(integer, integer);

CREATE OR REPLACE FUNCTION tcc_fp_usr_tf_ignore_rule(i_appli_id integer, i_custom_trace integer)
  RETURNS integer AS
$BODY$
DECLARE 
 L_ERRORCODE          INTEGER DEFAULT 0;
Begin 
-- Version 8.2.x - 1.9.0
    if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_TF_IGNORE_RULE for appli_id ' || to_char(I_Appli_ID) || ' ENTRANCE'); end if;
	
UPDATE dss_transaction tra
     set cal_flags = cal_flags + 256     --> Set the bit for ignored by external script (128)+ Deleted (8)
from cdt_objects cob 
   WHERE  tra.form_id =  cob.object_id
  and ( tra.cal_flags & 8 ) = 0           --> ...except for data functions which are std and deleted (8)
   and ( tra.cal_flags & 136 ) = 0           --> ...except for data functions which are external script and deleted (136)
   and ( tra.cal_flags & 10 ) = 0           --> ...except for data functions which are root and deleted (10)
   and ( tra.cal_flags & 140 ) = 0           --> ...except for data functions which are root and deleted and external script (140)
   and ( tra.cal_flags & 256 ) = 0           --> ...except for data functions which are ignored (256)
   and ( tra.cal_flags & 258 ) = 0           --> ...except for data functions which are root and ignored (258)
   and ( tra.cal_flags & 260 ) = 0           --> ...except for data functions which are child and ignored (260)
      and tra.cal_flags < 260   
 --  and user_fp_value is null
 --  and user_isinternal is null
     and tra.cal_mergeroot_id = 0            --> ...except for child merged objects
     and (
	 (cob.object_name like 'footer%' or cob.object_name like 'index\d'	or cob.object_name like 'sitepage%' or cob.object_name like 'navigation%' or cob.object_name like 'error%' or cob.object_name like 'Display%' or cob.object_name like 'Header%' or cob.object_name like 'test%' or cob.object_name like 'about%' or cob.object_name like 'Layout%' or cob.object_name like 'contactus%') 
	 and cob.object_type_str in ('Ascx Source File', 'Asmx Source File', 'Aspx Source File', 'ASP Source File', 'C# Form', 'ColdFusion Form', 'VB Form', 'VB MDI Form', '.NET Inherited Form', 'VB Designer Files', '.NET Custom Control', 'C# Custom Control', 'VB Property Page', 'VB User Control', '.NET User Control', 'C# User Control', '.NET Web Service Proxy', 'C# Web Service', 'C# Web Service Proxy', '.NET Web Custom Control', 'eFile', 'WSDL Operation', 'WSDL Port Operation') 
          ) 
	and appli_id = i_appli_id;
	
    if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_TF_IGNORE_RULE for appli_id ' || to_char(I_Appli_ID) || ' EXIT'); end if;
	if ( I_CUSTOM_TRACE >  0 ) then  perform custom_tcc_fp_usr_tf_ignore_rule(i_appli_id, i_custom_trace);   end if;
  Return L_ERRORCODE;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
/
ALTER FUNCTION tcc_fp_usr_tf_ignore_rule(integer, integer)
  OWNER TO operator
/

  
    
-- *********************************************************************************  
-- *************************  tcc_fp_usr_tf_group_rule  ***************************  
-- *********************************************************************************   
-- Function: tcc_fp_usr_tf_group_rule(integer, integer)

-- DROP FUNCTION tcc_fp_usr_tf_group_rule(integer, integer);

CREATE OR REPLACE FUNCTION tcc_fp_usr_tf_group_rule(i_appli_id integer, i_custom_trace integer)
  RETURNS integer AS
$BODY$
DECLARE 
 L_ERRORCODE          INTEGER DEFAULT 0;
  v_object_name text;
  v_fp_id integer;
  v_cal_flags integer;
  v_cal_mergeroot_id integer;
  v_object_id integer;
  v_object_type_str text;
     
    crs cursor for
      select o.object_name, d.object_id fp_id
        from cdt_objects o, dss_transaction d
       where o.object_id = d.form_id
         and d.cal_flags in (0, 2)
         and o.object_name in (
           select o.object_name
             from cdt_objects o, dss_transaction d
            where o.object_id = d.form_id
              and d.cal_flags in (0, 2)
              and o.object_name <> 'main' --Java/C Method main
			  and o.object_type_str not in ('Java Method','.NET Method','C# Method','C++ Method')
          and o.object_name <> 'run' --Java/C Method main
		  and d.appli_id = i_appli_id
            group by o.object_name, o.object_type_str
           having count(1) > 1) 
     order by d.appli_id, o.object_type_str, o.object_name, d.cal_flags desc, o.object_fullname, d.object_id;
-- Cursor for Similar matching grouping
  crs2 cursor for
    select  substring(o.object_name from '([a-zA-Z0-9\-\_]+)\_[a-zA-Z0-9]+$') prefix_name, d.object_id fp_id, d.appli_id
          from cdt_objects o, dss_transaction d
        where o.object_id = d.form_id
          and d.cal_flags in (0, 2)
          and length(substring(o.object_name from '([a-zA-Z0-9\-\_]+)\_[a-zA-Z0-9]+$')) > 4 -- Minimum prefix size
		  and d.appli_id = i_appli_id
          order by prefix_name asc ;
Begin 
-- Version 8.2.x - 1.9.0
    if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_TF_GROUP_RULE for appli_id ' || to_char(I_Appli_ID) || 'ENTRANCE'); end if;
	
--Merge duplicates - Action is to group element with the same name under a unique group. This is apply on both valid and ignored transaction since this will have an impact on the FTR.
  v_object_name := '';
  v_fp_id := -1;
   for r in crs loop
    if (v_object_name = r.object_name) then
      update dss_transaction
         set cal_flags = 2                 --put parent(v_fp_id) cal_flags to 2
       where object_id = v_fp_id
	   and appli_id = i_appli_id;
          
      update dss_transaction
         set cal_flags = 4,                --put child (r.fp_id) cal_flags to 4
             cal_mergeroot_id = v_fp_id    --put cal_mergeroot_id to parent(v_fp_id)
       where object_id = r.fp_id
	   and appli_id = i_appli_id;
    else
      v_fp_id := r.fp_id;                  --If not the same we change the root_id to the current one in the loop. fp_id contains the root_id, it changes when the object_name changes
    end if;
    v_object_name := r.object_name;        --Next object.
  end loop;
  
      if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_TF_GROUP_RULE for appli_id ' || to_char(I_Appli_ID) || 'END of LOOP 1'); end if;
	  
  -- Action is to group element with the same name under a unique group
  v_object_name := '';
  v_fp_id := -1;
  for r2 in crs2 loop
    if (Exists(Select 1 from dss_transaction df, cdt_objects o where df.form_id = o.object_id and o.object_name = r2.prefix_name and df.appli_id = r2.appli_id)) then
        --
        Select df.cal_flags, df.cal_mergeroot_id, df.object_id
          into v_cal_flags, v_cal_mergeroot_id, v_object_id
          from dss_transaction df, cdt_objects o
         where df.form_id = o.object_id
           and o.object_name = r2.prefix_name
           and df.appli_id = r2.appli_id;
               
        if(v_cal_flags = 0) then
            -- parent not grouped
            --put parent(v_object_id) cal_flags to 2
            update dss_transaction set cal_flags = 2 where object_id = v_object_id and appli_id = i_appli_id;
            --put child (r2.fp_id) cal_flags to 4
            --put child (r2.fp_id) cal_mergeroot_id to v_object_id
            update dss_transaction set cal_flags = 4,cal_mergeroot_id = v_object_id where object_id = r2.fp_id and appli_id = i_appli_id;
        else 
        if(v_cal_flags = 2) then
            -- parent is root of existing group
            --put child (r2.fp_id) cal_flags to 4
            --put child (r2.fp_id) cal_mergeroot_id to v_object_id
            update dss_transaction set cal_flags = 4,cal_mergeroot_id = v_object_id where object_id = r2.fp_id and appli_id = i_appli_id;
        else 
        if(v_cal_flags = 4) then
            -- parent is a child in a existing group
            --put child (r2.fp_id) cal_flags to 4
            --put child (r2.fp_id) cal_mergeroot_id to v_cal_mergeroot_id
            update dss_transaction set cal_flags = 4,cal_mergeroot_id = v_cal_mergeroot_id where object_id = r2.fp_id and appli_id = i_appli_id and object_id != v_cal_mergeroot_id;
        else 
        if(v_cal_flags = 256) then
            -- parent is ignored
            --put parent(v_object_id) cal_flags to 258
            update dss_transaction set cal_flags = 258 where object_id = v_object_id;
            --put child (r2.fp_id) cal_flags to 260
            --put child (r2.fp_id) cal_mergeroot_id to v_object_id
            update dss_transaction set cal_flags = 260,cal_mergeroot_id = v_object_id where object_id = r2.fp_id and appli_id = i_appli_id;
        else 
        if(v_cal_flags = 258) then
            -- parent is ignored and root
            --put child (r2.fp_id) cal_flags to 260
            --put child (r2.fp_id) cal_mergeroot_id to v_object_id
            update dss_transaction set cal_flags = 260,cal_mergeroot_id = v_object_id where object_id = r2.fp_id and appli_id = i_appli_id;
        else 
        if(v_cal_flags = 260) then
            -- parent is ignored and child
            --put child (r2.fp_id) cal_flags to 260
            --put child (r2.fp_id) cal_mergeroot_id to v_cal_mergeroot_id
            update dss_transaction set cal_flags = 260,cal_mergeroot_id = v_cal_mergeroot_id where object_id = r2.fp_id and appli_id = i_appli_id and object_id != v_cal_mergeroot_id;
        end if; end if;end if;end if;end if;end if;
    end if;
  end loop;
  
  
      if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_TF_GROUP_RULE for appli_id ' || to_char(I_Appli_ID) || 'END OF LOOP 2 '); end if;
      if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_TF_GROUP_RULE for appli_id ' || to_char(I_Appli_ID) || 'EXIT '); end if;	  
	  if ( I_CUSTOM_TRACE >  0 ) then  perform custom_tcc_fp_usr_tf_group_rule(i_appli_id, i_custom_trace);   end if;
  Return L_ERRORCODE;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
/
ALTER FUNCTION tcc_fp_usr_tf_group_rule(integer, integer)
  OWNER TO operator
/


  
-- *********************************************************************************  
-- *************************  tcc_fp_usr_tf_adj_det_rule  ***************************  
-- *********************************************************************************   
-- Function: tcc_fp_usr_tf_adj_det_rule(integer)

-- DROP FUNCTION tcc_fp_usr_tf_adj_det_rule(integer);

CREATE OR REPLACE FUNCTION tcc_fp_usr_tf_adj_det_rule(i_custom_trace integer)
  RETURNS integer AS
$BODY$
DECLARE 
 L_ERRORCODE          INTEGER DEFAULT 0;
Begin 
-- Version 8.2.x - 1.9.0
    if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_TF_ADJ_DET_RULE ENTRANCE'); end if;
	if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_TF_ADJ_DET_RULE EXIT'); end if;
	if ( I_CUSTOM_TRACE >  0 ) then  perform custom_tcc_fp_usr_tf_adj_det_rule(i_custom_trace);   end if;
  Return L_ERRORCODE;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
/
ALTER FUNCTION tcc_fp_usr_tf_adj_det_rule(integer)
  OWNER TO operator
/

-- *********************************************************************************  
-- *************************  tcc_fp_usr_tf_adj_type_rule  ***************************  
-- *********************************************************************************  
-- Function: tcc_fp_usr_tf_adj_type_rule(integer)

-- DROP FUNCTION tcc_fp_usr_tf_adj_type_rule(integer);

CREATE OR REPLACE FUNCTION tcc_fp_usr_tf_adj_type_rule(i_custom_trace integer)
  RETURNS integer AS
$BODY$
DECLARE  
 L_ERRORCODE          INTEGER DEFAULT 0;
Begin 
-- Version 8.2.x - 1.9.0
	if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_TF_ADJ_TYPE_RULE ENTRANCE');  end if;
	  UPDATE dss_transaction tra
     set user_isinput = 0
from cdt_objects cob 
   WHERE  tra.form_id =  cob.object_id
   and user_isinput is null
   and tra.cal_mergeroot_id = 0            --> ...except for child merged objects
   and (upper(cob.object_name) like '%\-OUT'
          or upper(cob.object_name) like '%OUTPUT%'
          or upper(cob.object_name) like '%SEARCH%'
          or upper(cob.object_name) like '%DISPLAY%'
          or upper(cob.object_name) like '%DETAIL%'
          or upper(cob.object_name) like '%DOWNLOAD%'
          or upper(cob.object_name) like '%LIST%');

		  
UPDATE dss_transaction tra
     set user_isinput = 1
from cdt_objects cob 
   WHERE  tra.form_id =  cob.object_id
   and user_isinput is null
   and tra.cal_mergeroot_id = 0            --> ...except for child merged objects
   and (upper(cob.object_name) like '%\-IN'
          or upper(cob.object_name) like '%INPUT%'
          or upper(cob.object_name) like '%EDIT%'
          or upper(cob.object_name) like '%UPDATE%'
          or upper(cob.object_name) like '%CONFIRM%');
	 if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_TF_ADJ_TYPE_RULE EXIT');  end if;
	 if ( I_CUSTOM_TRACE >  0 ) then  perform custom_tcc_fp_usr_tf_adj_type_rule(i_custom_trace);   end if;
  Return L_ERRORCODE;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION tcc_fp_usr_tf_adj_type_rule(integer)
  OWNER TO operator
/
  
  
-- *********************************************************************************  
-- *************************  tcc_fp_usr_tf_adj_ftr_rule  ***************************  
-- *********************************************************************************   
-- Function: tcc_fp_usr_tf_adj_ftr_rule(integer)

-- DROP FUNCTION tcc_fp_usr_tf_adj_ftr_rule(integer);

CREATE OR REPLACE FUNCTION tcc_fp_usr_tf_adj_ftr_rule(i_custom_trace integer)
  RETURNS integer AS
$BODY$
DECLARE 
 L_ERRORCODE          INTEGER DEFAULT 0;
Begin 
-- Version 8.2.x - 1.9.0
    if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_TF_ADJ_FTR_RULE ENTRANCE'); end if;
	

		  
    if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_TF_ADJ_FTR_RULE EXIT'); end if;
  	if ( I_CUSTOM_TRACE >  0 ) then  perform custom_tcc_fp_usr_tf_adj_ftr_rule(i_custom_trace);   end if;
  Return L_ERRORCODE;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
/
ALTER FUNCTION tcc_fp_usr_tf_adj_ftr_rule(integer)
  OWNER TO operator
/


-- *********************************************************************************  
-- *************************  tcc_fp_usr_final_rule  ***************************  
-- *********************************************************************************   
  
-- Function: tcc_fp_usr_final_rule(integer)

-- DROP FUNCTION tcc_fp_usr_final_rule(integer);

CREATE OR REPLACE FUNCTION tcc_fp_usr_final_rule(i_custom_trace integer)
  RETURNS integer AS
$BODY$
DECLARE 
 L_ERRORCODE          INTEGER DEFAULT 0;
Begin 
-- Version 8.2.x - 1.9.0
    if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_FINAL_RULE ENTRANCE'); end if;
UPDATE dss_transaction tra
    set user_fp_value = 4
from cdt_objects cob 
   WHERE  tra.form_id =  cob.object_id
   and ( tra.cal_flags & 8 ) = 0          -- ...except for data functions which are deleted (8)
   and ( tra.cal_flags & 128 ) = 0           --> ...except for data functions which are external script and deleted (128)
   and ( tra.cal_flags & 256 ) = 0           --> ...except for data functions which are external script and deleted (256)
   and ( tra.cal_flags & 136 ) = 0           --> ...except for data functions which are external script and deleted (136)
   and ( tra.cal_flags & 10 ) = 0           --> ...except for data functions which are root and deleted (10)
   and ( tra.cal_flags & 140 ) = 0           --> ...except for data functions which are root and deleted and external script (140)
   and ( tra.cal_flags & 256 ) = 0           --> ...except for data functions which are ignored (256)
   and ( tra.cal_flags & 258 ) = 0           --> ...except for data functions which are root and ignored (258)
   and ( tra.cal_flags & 260 ) = 0           --> ...except for data functions which are child and ignored (260)
      and tra.cal_flags < 260   
   and tra.cal_mergeroot_id = 0           --> ...except for child merged objects
                and tra.tf_ex = 0
                and tra.tf = 0
                and tra.ftr = 0
                and tra.det = 0 
				and cob.object_type_str in ('SAP Transaction','R3 WebDynpro Window');
				
/* 1.7.4 modification - comment out this for now since the dss_transactiondetails doesn t contain all info we are looking for at the moment of the execution
-- Clean up all the JCL Jobs or JCL Procedure which are not interacting with Cobol.
update dss_transaction
 set cal_flags = cal_flags + 256 -- Set the bit for "deleted" in TCC...
 where cal_flags not in (  8, 10, 126, 128,136, 138, 256, 258 ) -- transaction standalone or Root
 and cal_mergeroot_id = 0 -- ...except for child merged objects
 and form_id in (
 select distinct o.object_id
 from cdt_objects o, dss_transaction d
 where (o.object_id = d.form_id)
 and ( o.object_id in (select objt.object_id
 from dss_transaction dt, CDT_OBJECTS objt
 where form_id not in(
 select distinct dt.form_id
 from dss_transaction dt, CDT_OBJECTS objt, dss_transactiondetails dtd, cdt_objects objc
 where dt.form_id = objt.object_id
 and dtd.object_id = dt.object_id
 and dtd.child_id = objc.object_id
 and objc.object_language_name != objt.object_language_name -- THE TRANSACTION IS NOT MONO TECHNOLOGY JCL IN THIS CASE
 order by form_id)
 and dt.form_id = objt.object_id
 and object_type_str in ('JCL Job','JCL Procedure')
 )
 )
 )
 ;
*/				
    if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- TCC_FP_USR_FINAL_RULE EXIT'); end if;
	if ( I_CUSTOM_TRACE >  0 ) then  perform custom_tcc_fp_usr_final_rule(i_custom_trace);   end if;
  Return L_ERRORCODE;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
/
ALTER FUNCTION tcc_fp_usr_final_rule(integer)
  OWNER TO operator
/

  