delete from eg_userrole where userid = (select id from eg_user where username='egovernments');
insert into eg_userrole(userid,roleid) values ((select id from eg_user where username='egovernments'),(select id from eg_role where name='SYSTEM'));
