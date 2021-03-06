ALTER TABLE doc_receive ADD COLUMN REC_DOC_ID VARCHAR(200) AFTER SEND_RUN_ID,
ADD COLUMN REC_DOC_NAME VARCHAR(1000) AFTER REC_DOC_ID;
ALTER TABLE flow_run_data MODIFY COLUMN ITEM_DATA MEDIUMTEXT CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL;
ALTER TABLE doc_flow_process ADD COLUMN DOC_SEND_FLAG VARCHAR(10) AFTER DOC_SMS_STYLE;
ALTER TABLE doc_flow_run ADD COLUMN SEND_FLAG VARCHAR(45) AFTER DOC_TYPE;
ALTER TABLE vote_title ADD COLUMN SUBJECT_MAIN TEXT;

update SYS_FUNCTION set FUNC_CODE = '/core/funcs/doc/docword/index.jsp' where MENU_ID = '221747';
ALTER TABLE flow_form_item ADD COLUMN LV_ALIGN TEXT ;

ALTER TABLE flow_form_item ADD COLUMN SIGN_COLOR VARCHAR(45) ,
 ADD COLUMN SIGN_TYPE VARCHAR(45) ;

 ALTER TABLE vehicle 
 ADD COLUMN insurance_date DATETIME, 
 ADD COLUMN before_day INT(11), 
 ADD COLUMN last_insurance_date DATETIME, 
 ADD COLUMN insurance_flag INT(2);
 
 delete from sys_function where func_name = '机要文件夹 '