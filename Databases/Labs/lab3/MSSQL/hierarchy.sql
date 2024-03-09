alter table roles add node hierarchyid, level as node.GetLevel() PERSISTED

select roleId, node, node.ToString() as NodeAsString, roleName from roles where node.IsDescendantOf(hierarchyid::Parse('/1/'))=1;

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
select * from roles where node.IsDescendantOf(@nodenode)=1
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
select @main=max(node) from roles where node.GetAncestor(1)=@parent
insert into roles(roleId,roleName, node) values (NEWID(),'Hotel Agent'+cast(1 as nvarchar), @parent.GetDescendant(@main, null))
end;

declare @parent hierarchyid;
select @parent=node from roles where roleName='Tour Operator 1'
exec AddChild @parent

update roles set node=hierarchyid::Parse('/1/1/') where roleName like 'Tour Manager 1'
update roles set node=hierarchyid::Parse('/1/2/') where roleName like 'Tour Manager 2'
update roles set node=hierarchyid::Parse('/1/3/') where roleName like 'Tour Manager 3'

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

exec IntoTheOther @old_node='/1/', @new_node='/3/'

exec IntoTheOther

select * from roles;