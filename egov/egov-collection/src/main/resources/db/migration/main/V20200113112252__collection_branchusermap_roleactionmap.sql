DELETE from eg_roleaction where actionid in (select id from eg_action where name in ('BeforeSearchBankCollOpMap','SearchBankCollOpMap','SearchModifyBankCollOpMap','BeforeModifyBankCollOpMap','ModifyBankCollOpMap'));
DELETE from eg_action where name in('BeforeSearchBankCollOpMap','SearchBankCollOpMap','SearchModifyBankCollOpMap','BeforeModifyBankCollOpMap','ModifyBankCollOpMap');

INSERT into EG_ACTION (id,name,url,queryparams,parentmodule,ordernumber,displayname,enabled,contextroot,version,createdby,createddate,lastmodifiedby,lastmodifieddate,application) values (nextval('SEQ_EG_ACTION'),'BeforeSearchBankCollOpMap','/service/branchUserMap-beforeSearch.action',null,(select id from eg_module where name='Bank Branch User Mapping'),3,'View Bank Branch To User Map',true,'collection',0,(SELECT id FROM eg_user WHERE lower(username)='system'),now(),(SELECT id FROM eg_user WHERE lower(username)='system'),now(),(select id from eg_module where name='Collection'));
INSERT into EG_ACTION (id,name,url,queryparams,parentmodule,ordernumber,displayname,enabled,contextroot,version,createdby,createddate,lastmodifiedby,lastmodifieddate,application) values (nextval('SEQ_EG_ACTION'),'SearchBankCollOpMap','/service/branchUserMap-search.action',null,(select id from eg_module where name='Bank Branch User Mapping'),3,'SearchBankCollOpMap',false,'collection',0,(SELECT id FROM eg_user WHERE lower(username)='system'),now(),(SELECT id FROM eg_user WHERE lower(username)='system'),now(),(select id from eg_module where name='Collection'));

INSERT into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='SYSTEM'),(select id from eg_action where name='BeforeSearchBankCollOpMap'));
INSERT into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='SYSTEM'),(select id from eg_action where name='SearchBankCollOpMap'));

INSERT into EG_ACTION (id,name,url,queryparams,parentmodule,ordernumber,displayname,enabled,contextroot,version,createdby,createddate,lastmodifiedby,lastmodifieddate,application) values (nextval('SEQ_EG_ACTION'),'SearchModifyBankCollOpMap','/service/branchUserMap-searchModify.action',null,(select id from eg_module where name='Bank Branch User Mapping'),2,'Modify Bank Branch To User Map',true,'collection',0,(SELECT id FROM eg_user WHERE lower(username)='system'),now(),(SELECT id FROM eg_user WHERE lower(username)='system'),now(),(select id from eg_module where name='Collection'));
INSERT into EG_ACTION (id,name,url,queryparams,parentmodule,ordernumber,displayname,enabled,contextroot,version,createdby,createddate,lastmodifiedby,lastmodifieddate,application) values (nextval('SEQ_EG_ACTION'),'BeforeModifyBankCollOpMap','/service/branchUserMap-beforeModify.action',null,(select id from eg_module where name='Bank Branch User Mapping'),2,'BeforeModifyBankCollOpMap',false,'collection',0,(SELECT id FROM eg_user WHERE lower(username)='system'),now(),(SELECT id FROM eg_user WHERE lower(username)='system'),now(),(select id from eg_module where name='Collection'));
INSERT into EG_ACTION (id,name,url,queryparams,parentmodule,ordernumber,displayname,enabled,contextroot,version,createdby,createddate,lastmodifiedby,lastmodifieddate,application) values (nextval('SEQ_EG_ACTION'),'ModifyBankCollOpMap','/service/branchUserMap-modify.action',null,(select id from eg_module where name='Bank Branch User Mapping'),2,'ModifyBankCollOpMap',false,'collection',0,(SELECT id FROM eg_user WHERE lower(username)='system'),now(),(SELECT id FROM eg_user WHERE lower(username)='system'),now(),(select id from eg_module where name='Collection'));

INSERT into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='SYSTEM'),(select id from eg_action where name='SearchModifyBankCollOpMap'));
INSERT into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='SYSTEM'),(select id from eg_action where name='BeforeModifyBankCollOpMap'));
INSERT into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='SYSTEM'),(select id from eg_action where name='ModifyBankCollOpMap'));