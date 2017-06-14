-- *********************************************************************************  
-- *************************  custom_tcc_fp_usr_df_delete_rule  ***************************  
-- *********************************************************************************
  
-- Function: custom_tcc_fp_usr_df_delete_rule(integer, integer)

-- DROP FUNCTION custom_tcc_fp_usr_df_delete_rule(integer, integer);

BEGIN
IF (SELECT count(1) FROM information_schema.routines JOIN information_schema.parameters ON routines.specific_name=parameters.specific_name WHERE routines.specific_schema=current_schema()
 and routine_name = 'custom_tcc_fp_usr_df_delete_rule')  > 0 THEN

 -- CUSTOM ALREADY THERE

ELSE 
CREATE OR REPLACE FUNCTION custom_tcc_fp_usr_df_delete_rule(i_appli_id integer, i_custom_trace integer)
  RETURNS integer AS
$BODY$
DECLARE  
 L_ERRORCODE          INTEGER DEFAULT 0;
Begin 
-- Version 8.2.x - 1.9.0
  if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- Custom_TCC_FP_USR_DF_DELETE_RULE for appli_id ' || to_char(I_Appli_ID) || 'ENTRANCE ');   end if;

  if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- Custom_TCC_FP_USR_DF_DELETE_RULE for appli_id ' || to_char(I_Appli_ID) || 'EXIT ');   end if;	
  Return L_ERRORCODE;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
/
ALTER FUNCTION custom_tcc_fp_usr_df_delete_rule(integer, integer)
  OWNER TO operator
/





  
-- *********************************************************************************  
-- ************************  custom_tcc_fp_usr_df_adj_detret_rule  ************************  
-- *********************************************************************************

-- Function: custom_tcc_fp_usr_df_adj_detret_rule(integer, integer)

-- DROP FUNCTION custom_tcc_fp_usr_df_adj_detret_rule(integer, integer);

CREATE OR REPLACE FUNCTION custom_tcc_fp_usr_df_adj_detret_rule(i_appli_id integer, i_custom_trace integer)
  RETURNS integer AS
$BODY$
DECLARE  
 L_ERRORCODE          INTEGER DEFAULT 0;
Begin 
-- Version 8.2.x - 1.9.0
	if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- Custom_TCC_FP_USR_DF_ADJ_DETRET_RULE for appli_id ' || to_char(I_Appli_ID) || ' ENTRANCE'); end if;

	if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- Custom_TCC_FP_USR_DF_ADJ_DETRET_RULE for appli_id ' || to_char(I_Appli_ID) || ' EXIT'); end if;
  Return L_ERRORCODE;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
/
ALTER FUNCTION custom_tcc_fp_usr_df_adj_detret_rule(integer, integer)
  OWNER TO operator
/


-- *********************************************************************************  
-- *************************  Custom_tcc_fp_usr_df_ignore_rule  ***************************  
-- ********************************************************************************* 
-- Function: Custom_tcc_fp_usr_df_ignore_rule(integer, integer)

-- DROP FUNCTION Custom_tcc_fp_usr_df_ignore_rule(integer, integer);

CREATE OR REPLACE FUNCTION custom_tcc_fp_usr_df_ignore_rule(i_appli_id integer, i_custom_trace integer)
  RETURNS integer AS
$BODY$
DECLARE  
L_ERRORCODE          INTEGER DEFAULT 0;
Begin 
-- Version 8.2.x - 1.9.0
     if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- Custom_TCC_FP_USR_DF_IGNORE_RULE for appli_id ' || to_char(I_Appli_ID)|| ' ENTRANCE'); end if; 

     if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- Custom_TCC_FP_USR_DF_IGNORE_RULE for appli_id ' || to_char(I_Appli_ID)|| ' EXIT'); end if; 
  Return L_ERRORCODE;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
/
ALTER FUNCTION custom_tcc_fp_usr_df_ignore_rule(integer, integer)
  OWNER TO operator
/
 
-- *********************************************************************************  
-- *************************  custom_tcc_fp_usr_df_group_rule  ***************************  
-- *********************************************************************************  
-- Function: Custom_tcc_fp_usr_df_group_rule(integer, integer)

-- DROP FUNCTION Custom_tcc_fp_usr_df_group_rule(integer, integer);

CREATE OR REPLACE FUNCTION custom_tcc_fp_usr_df_group_rule(i_appli_id integer, i_custom_trace integer)
  RETURNS integer AS
$BODY$
DECLARE 
L_ERRORCODE          INTEGER DEFAULT 0;
Begin 
-- Version 8.2.x - 1.9.0
     if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- custom_TCC_FP_USR_DF_GROUP_RULE for appli_id ' || to_char(I_Appli_ID)|| ' EXIT'); end if;
 
     if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- custom_TCC_FP_USR_DF_GROUP_RULE for appli_id ' || to_char(I_Appli_ID)|| ' EXIT'); end if; 
  Return L_ERRORCODE; 
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
/
ALTER FUNCTION custom_tcc_fp_usr_df_group_rule(integer, integer)
  OWNER TO operator
/


  
-- *********************************************************************************  
-- *************************  custom_tcc_fp_usr_df_adj_type_rule  *************************  
-- *********************************************************************************
-- Function: custom_tcc_fp_usr_df_adj_type_rule(integer, integer)

-- DROP FUNCTION custom_tcc_fp_usr_df_adj_type_rule(integer, integer);

CREATE OR REPLACE FUNCTION custom_tcc_fp_usr_df_adj_type_rule(i_appli_id integer, i_custom_trace integer)
  RETURNS integer AS
$BODY$
DECLARE  
 L_ERRORCODE          INTEGER DEFAULT 0;
Begin 
-- Version 8.2.x - 1.9.0
	if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- custom_TCC_FP_USR_DF_ADJ_TYPE_RULE for appli_id ' || to_char(I_Appli_ID) || ' ENTRANCE '); 	end if;
          
	if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- custom_TCC_FP_USR_DF_ADJ_TYPE_RULE for appli_id ' || to_char(I_Appli_ID) || ' EXIT '); 	end if;
  Return L_ERRORCODE;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
/
ALTER FUNCTION custom_tcc_fp_usr_df_adj_type_rule(integer, integer)
  OWNER TO operator
/

 
  
  
-- *********************************************************************************  
-- *************************  custom_tcc_fp_usr_tf_delete_rule  ***************************  
-- *********************************************************************************   
-- Function: custom_tcc_fp_usr_tf_delete_rule(integer, integer)

-- DROP FUNCTION custom_tcc_fp_usr_tf_delete_rule(integer, integer);

CREATE OR REPLACE FUNCTION custom_tcc_fp_usr_tf_delete_rule(i_appli_id integer, i_custom_trace integer)
  RETURNS integer AS
$BODY$
DECLARE 
 L_ERRORCODE          INTEGER DEFAULT 0;
Begin 
-- Version 8.2.x - 1.9.0
    if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- custom_TCC_FP_USR_TF_DELETE_RULE for appli_id ' || to_char(I_Appli_ID)|| 'ENTRANCE '); end if;
	
    if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- custom_TCC_FP_USR_TF_DELETE_RULE for appli_id ' || to_char(I_Appli_ID)|| 'EXIT '); end if;       

  Return L_ERRORCODE;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
/
ALTER FUNCTION custom_tcc_fp_usr_tf_delete_rule(integer, integer)
  OWNER TO operator
/


  
-- *********************************************************************************  
-- *************************  custom_tcc_fp_usr_tf_ignore_rule  ***************************  
-- *********************************************************************************   
-- Function: custom_tcc_fp_usr_tf_ignore_rule(integer, integer)

-- DROP FUNCTION custom_tcc_fp_usr_tf_ignore_rule(integer, integer);

CREATE OR REPLACE FUNCTION custom_tcc_fp_usr_tf_ignore_rule(i_appli_id integer, i_custom_trace integer)
  RETURNS integer AS
$BODY$
DECLARE 
 L_ERRORCODE          INTEGER DEFAULT 0;
Begin 
-- Version 8.2.x - 1.9.0
    if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- custom_TCC_FP_USR_TF_IGNORE_RULE for appli_id ' || to_char(I_Appli_ID) || ' ENTRANCE'); end if;

    if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- custom_TCC_FP_USR_TF_IGNORE_RULE for appli_id ' || to_char(I_Appli_ID) || ' EXIT'); end if;
  Return L_ERRORCODE;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
/
ALTER FUNCTION custom_tcc_fp_usr_tf_ignore_rule(integer, integer)
  OWNER TO operator
/

  
    
-- *********************************************************************************  
-- *************************  custom_tcc_fp_usr_tf_group_rule  ***************************  
-- *********************************************************************************   
-- Function: custom_tcc_fp_usr_tf_group_rule(integer, integer)

-- DROP FUNCTION custom_tcc_fp_usr_tf_group_rule(integer, integer);

CREATE OR REPLACE FUNCTION custom_tcc_fp_usr_tf_group_rule(i_appli_id integer, i_custom_trace integer)
  RETURNS integer AS
$BODY$
DECLARE 
 L_ERRORCODE          INTEGER DEFAULT 0;
Begin 
-- Version 8.2.x - 1.9.0
    if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- custom_TCC_FP_USR_TF_GROUP_RULE for appli_id ' || to_char(I_Appli_ID) || 'ENTRANCE'); end if;

	if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- custom_TCC_FP_USR_TF_GROUP_RULE for appli_id ' || to_char(I_Appli_ID) || 'EXIT '); end if;	  
  Return L_ERRORCODE;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
/
ALTER FUNCTION custom_tcc_fp_usr_tf_group_rule(integer, integer)
  OWNER TO operator
/


  
-- *********************************************************************************  
-- *************************  custom_tcc_fp_usr_tf_adj_det_rule  ***************************  
-- *********************************************************************************   
-- Function: custom_tcc_fp_usr_tf_adj_det_rule(integer)

-- DROP FUNCTION custom_tcc_fp_usr_tf_adj_det_rule(integer);

CREATE OR REPLACE FUNCTION custom_tcc_fp_usr_tf_adj_det_rule(i_custom_trace integer)
  RETURNS integer AS
$BODY$
DECLARE 
 L_ERRORCODE          INTEGER DEFAULT 0;
Begin 
-- Version 8.2.x - 1.9.0
    if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- custom_TCC_FP_USR_TF_ADJ_DET_RULE ENTRANCE'); end if;
	
	if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- custom_TCC_FP_USR_TF_ADJ_DET_RULE EXIT'); end if;
  Return L_ERRORCODE;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
/
ALTER FUNCTION tcc_fp_usr_tf_adj_det_rule(integer)
  OWNER TO operator
/

-- Function: custom_tcc_fp_usr_tf_adj_type_rule(integer)

-- DROP FUNCTION custom_tcc_fp_usr_tf_adj_type_rule(integer);

CREATE OR REPLACE FUNCTION custom_tcc_fp_usr_tf_adj_type_rule(i_custom_trace integer)
  RETURNS integer AS
$BODY$
DECLARE  
 L_ERRORCODE          INTEGER DEFAULT 0;
Begin 
-- Version 8.2.x - 1.9.0
	if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- custom_TCC_FP_USR_TF_ADJ_TYPE_RULE ENTRANCE');  end if;

	if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- custom_TCC_FP_USR_TF_ADJ_TYPE_RULE EXIT');  end if;
  Return L_ERRORCODE;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION tcc_fp_usr_tf_adj_type_rule(integer)
  OWNER TO operator
/
  
  
-- *********************************************************************************  
-- *************************  custom_tcc_fp_usr_tf_adj_ftr_rule  ***************************  
-- *********************************************************************************   
-- Function: custom_tcc_fp_usr_tf_adj_ftr_rule(integer)

-- DROP FUNCTION custom_tcc_fp_usr_tf_adj_ftr_rule(integer);

CREATE OR REPLACE FUNCTION custom_tcc_fp_usr_tf_adj_ftr_rule(i_custom_trace integer)
  RETURNS integer AS
$BODY$
DECLARE 
 L_ERRORCODE          INTEGER DEFAULT 0;
Begin 
-- Version 8.2.x - 1.9.0
    if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- custom_TCC_FP_USR_TF_ADJ_FTR_RULE ENTRANCE'); end if;
		  
    if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- custom_TCC_FP_USR_TF_ADJ_FTR_RULE EXIT'); end if;
  
  Return L_ERRORCODE;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
/
ALTER FUNCTION custom_tcc_fp_usr_tf_adj_ftr_rule(integer)
  OWNER TO operator
/


-- *********************************************************************************  
-- *************************  custom_tcc_fp_usr_final_rule  ***************************  
-- *********************************************************************************   
  
-- Function: custom_tcc_fp_usr_final_rule(integer)

-- DROP FUNCTION custom_tcc_fp_usr_final_rule(integer);

CREATE OR REPLACE FUNCTION custom_tcc_fp_usr_final_rule(i_custom_trace integer)
  RETURNS integer AS
$BODY$
DECLARE 
 L_ERRORCODE          INTEGER DEFAULT 0;
Begin 
-- Version 8.2.x - 1.9.0
    if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- custom_TCC_FP_USR_FINAL_RULE ENTRANCE'); end if;
			
    if ( I_CUSTOM_TRACE >  0 ) then  perform cast_log('TCC-FP-CUSTOM- custom_TCC_FP_USR_FINAL_RULE EXIT'); end if;
  Return L_ERRORCODE;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
/
ALTER FUNCTION custom_tcc_fp_usr_final_rule(integer)
  OWNER TO operator
/


END IF
/
END
/