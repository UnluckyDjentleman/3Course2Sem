select * from roles;

alter table roles add status number;
alter table roles add previous number;

update roles set status=2 where roleName like '%Operator%';

update roles set status=0 where roleName like '%Manager%';

insert into roles(roleName) values('Manager');
insert into roles(roleName) values('Operator 1');
insert into roles(roleName) values('Operator 2');
insert into roles(roleName) values('Visa Agent');

create or replace type ROLE_AS_Type3 as OBJECT(
roleId number,
roleName varchar2(20),
status number,
previous_stage number,
node_level number
);

create type role_as_type_table3 as table of ROLE_AS_Type3;

create or replace procedure SelectByNode (node number) is
cur sys_refcursor;
v_c_roleName roles.roleName%type;
v_c_status roles.status%type;
v_c_node_level number;
begin
open cur for select LPAD(' ',3*LEVEL)||roleName, status, LEVEL as node_level  from ROLES start with status=node connect by nocycle prior status=previous;
LOOP
FETCH cur
INTO  v_c_roleName, v_c_status, v_c_node_level;
EXIT WHEN cur%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(v_c_node_level||'. '||v_c_roleName || ' - ' || v_c_status);
END LOOP;
CLOSE cur;
end;

begin
SelectByNode(2);
end;

create or replace procedure AddToNode (noden number) is
begin
insert into roles(roleName,status) values ('Hotel Agent'||noden, noden);
end;

begin
AddToNode(3);
end;

create or replace procedure ReplaceNode (nodeNew number, nodeOld number) is
begin
update roles set status=nodeNew where status=nodeOld;
end;

begin
ReplaceNode(2,3);
end;
