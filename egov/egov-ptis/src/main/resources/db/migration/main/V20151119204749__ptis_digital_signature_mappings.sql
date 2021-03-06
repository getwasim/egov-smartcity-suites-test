update eg_action SET parentmodule = (select id from eg_module where name = 'Existing property') where name  = 'Search Pending Digital Signature';

Insert into EG_ACTION (ID,NAME,URL,QUERYPARAMS,PARENTMODULE,ORDERNUMBER,DISPLAYNAME,ENABLED,CONTEXTROOT,VERSION,CREATEDBY,CREATEDDATE,LASTMODIFIEDBY,LASTMODIFIEDDATE,APPLICATION) values 
(NEXTVAL('SEQ_EG_ACTION'),'digitalSignature-PropertyTaxTransitionWorkflow','/digitalSignature/propertyTax/transitionWorkflow', null,(select id from EG_MODULE where name = 'Existing property'),1,
null,'f','ptis',0,1,now(),1,now(),(select id from eg_module  where name = 'Property Tax'));

insert into eg_roleaction (actionid, roleid) select (select id from eg_action where name = 'digitalSignature-PropertyTaxTransitionWorkflow'), id from eg_role where name in ('Property Administrator','Property Approver');
