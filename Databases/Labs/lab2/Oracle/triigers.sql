grant create any trigger to gvscore;

drop trigger setDiscount;

create or replace trigger setDiscount 
after insert or update on DISCOUNTS
for each row
begin
UPDATE TOURS
set costForOnePerson=costForOnePerson-costForOnePerson*:new.discountValue
where tourId=:new.tourId;
end;

create or replace trigger unsetDiscount
before delete on DISCOUNTS
for each row
begin
UPDATE TOURS set costForOnePerson=costForOnePerson/1-:new.discountValue
where tourId=:old.tourId;
end;

create or replace procedure SetTheFeedBack(
user_id number,
tour_id number,
set_mark number)
is
begin
    insert into FEEDBACKS(userId,tourId,mark) values(user_id, tour_id, set_mark);
    update tours t set t.average_mark=cast((select avg(mark) from FEEDBACKS f where f.tourId=tour_id) as number) where t.tourId=tour_id;
end;

begin
    SetTheFeedback(2,3,3);
end;

create or replace procedure SetTheOrder(
tour_id number,
user_id number,
adults_Count number,
children_Count number)
is
c number;
begin
    select costForOnePerson into c from TOURS t where t.tourId=tour_id;
    insert into ORDERS(tourId, userId, adultsCount, childrenCount, DateStart, cost) values(tour_id, user_id, adults_Count, children_Count, SYSDATE, (cast(c as number))*(adults_Count+0.5*children_Count));
end;

begin
    SetTheOrder(1,2,3,1);
end;