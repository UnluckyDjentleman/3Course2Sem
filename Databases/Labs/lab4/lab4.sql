select * from BLR_adm2;
---7. Get SRID
select distinct geom.STSrid from BLR_adm2 where qgs_fid=1;

---8. Get unit of measure
SELECT [unit_of_measure]
FROM sys.spatial_reference_systems
WHERE [spatial_reference_id] = 4326;

---9. WKT
---This example is also for 11
declare @point geometry;
set @point=geometry::STGeomFromText('POINT(26 54)',4326);
select @point.STAsText();

---10
----10.1
SELECT m.[id_2] AS map_object_id
FROM [dbo].[BLR_adm2] m
WHERE EXISTS (
    SELECT 1
    FROM [dbo].[BLR_adm2] o
    WHERE m.[geom].STIntersects(o.[geom]) = 1
    AND o.[id_2] = 1
);
----10.2
declare @id int=86
declare @i int=(select geom.STNumPoints() from BLR_adm2 where id_2=@id)
;with sequence(NUMBER) as(
select 1 as NUMBER
union all
select NUMBER+1
from sequence
where number<@i
)
select geom.STPointN(nums.number).STX as X, geom.STPointN(nums.number).STY as Y from BLR_adm2,sequence nums where id_2=@id option(maxrecursion 0);

-----10.3
select id_2, name_2, geom.STArea() as Area from BLR_adm2 order by Area desc;
---11
declare @p geometry;
set @p=geometry::STGeomFromText('POINT(26 54)',4326);

declare @line geometry;
set @line=geometry::STGeomFromText('LINESTRING(23 54, 33 54)',4326);

declare @pol geometry;
set @pol=geometry::STGeomFromText('POLYGON((23 54, 25 54.5, 27 54, 23 54), (30 54, 32 54.5, 34 54, 30 54))',4326).MakeValid();

--12

select id_2, geom.ToString() from BLR_adm2 where @line.STIntersects(geom)=1;

--13

create spatial index SPIX_Geom on BLR_adm2(geom) with (bounding_box=(xmin=22, ymin=51, xmax=33, ymax=57));

--14

create or alter procedure GetSpatialObjectForPoint
@x int,
@y int 
as
begin
declare @point geometry;
set @point=geometry::Point(@x, @y, 4326)
select geom.ToString() AS PolygonInside FROM BLR_adm2 WHERE @point.STIntersects(geom)=1;
end;

begin
declare @xP int=27
declare @yP int=55
exec GetSpatialObjectForPoint @xP, @yP
end;