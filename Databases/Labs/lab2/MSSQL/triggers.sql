alter trigger costForTour on ORDERS
after insert, update 
as
update ORDERS 
set cost=(select costForOnePerson from TOURS where TOURS.tourId=ORDERS.tourId)*(adultsCount+0.5*childrenCount)
where orderId=(select orderId from inserted);

drop trigger avgMark;

alter trigger avgMark on FEEDBACKS
after insert, update, delete
as
UPDATE TOURS
set average_mark=(select SUM(mark) from FEEDBACKS where FEEDBACKS.tourId=TOURS.tourId)/(select COUNT(*) from FEEDBACKS where FEEDBACKS.tourId=TOURS.tourId)
where tourId=(select tourId from inserted);

drop trigger setDiscount;

create trigger setDiscount on DISCOUNTS
after insert, update
as
UPDATE TOURS
set costForOnePerson=costForOnePerson-costForOnePerson*(select discountValue from DISCOUNTS where DISCOUNTS.tourId=TOURS.tourId)
where tourId=(select tourId from inserted);

create trigger unsetDiscount on DISCOUNTS
after delete
as
UPDATE TOURS set costForOnePerson=costForOnePerson/1-(select discountValue from DISCOUNTS where DISCOUNTS.tourId=TOURS.tourId)
where tourId=(select tourId from deleted);