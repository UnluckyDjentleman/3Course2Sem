alter table roles add node hierarchyid, level as node.GetLevel() PERSISTED

select roleId, node, node.ToString() as NodeAsString, roleName from roles;

update roles set node=NULL where roleName='Tour Operator 2';

delete from roles where node is NULL and roleName!='User';

insert into roles(roleId, roleName) values (NEWID(),'Tour Manager 1');
insert into roles(roleId, roleName) values (NEWID(),'Tour Manager 2');
insert into roles(roleId, roleName) values (NEWID(),'Tour Manager 3');

--select by Node
create or alter procedure SelectByNode
@nodenode hierarchyid
as
begin
select * from roles where node=@nodenode
end;

declare @nodenode hierarchyid;
select @nodenode=node from roles where roleName='Tour Operator'
exec SelectByNode @nodenode

--add new level
create or alter procedure AddChild 
@parent hierarchyid
as
declare @main hierarchyid
begin
select @main=node from roles where roleName='%Manager%'
insert into roles(roleId,roleName, node) values (NEWID(),'xd man', @main.GetDescendant(@parent, null))
end;

declare @parent hierarchyid;
select @parent=node from roles where roleName='Tour Operator 1'
exec AddChild @parent

update roles set node=hierarchyid::Parse('/2/') where roleName='Tour Manager 2'

--select into
create or alter procedure IntoTheOther
@old_node hierarchyid,
@new_node hierarchyid
as
begin
update roles set node=hierarchyid::Parse(
	replace(node.ToString(), @old_node.ToString(), @new_node.ToString())
) where node.IsDescendantOf(@old_node)=1 and node<>@old_node;
end;

exec IntoTheOther @old_node='/', @new_node='/3/'


exec IntoTheOther

select * from roles;