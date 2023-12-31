create database lab5E
use lab5E

go
create table hotel(
hotelno varchar(10) primary key,
hotelname varchar(20),
city varchar(20),
)

insert into hotel values('fb01', 'Grosvenor', 'London');
insert into hotel values('fb02', 'Watergate', 'Paris');
insert into hotel values('ch01', 'Omni Shoreham', 'London');
insert into hotel values('ch02', 'Phoenix Park', 'London');
insert into hotel values('dc01', 'Latham', 'Berlin');

 -- create a table named hotel

 create table room(

roomno numeric(5),
hotelno varchar(10),
type varchar(10),
price decimal(5,2),
primary key (roomno, hotelno),
foreign key (hotelno) REFERENCES hotel(hotelno)
)

insert into room values(501, 'fb01', 'single', 19);
insert into room values(601, 'fb01', 'double', 29);
insert into room values(701, 'fb01', 'family', 39);
insert into room values(1001, 'fb02', 'single', 58);
insert into room values(1101, 'fb02', 'double', 86);
insert into room values(1001, 'ch01', 'single', 29.99);
insert into room values(1101, 'ch01', 'family', 59.99);
insert into room values(701, 'ch02', 'single', 10);
insert into room values(801, 'ch02', 'double', 15);
insert into room values(901, 'dc01', 'single', 18);
insert into room values(1001, 'dc01', 'double', 30);
insert into room values(1101, 'dc01', 'family', 35);

create table guest(
guestno numeric(5),
guestname varchar(20),
guestaddress varchar(50),
primary key (guestno)
)

insert into guest values(10001, 'John Kay', '56 High St, London');
insert into guest values(10002, 'Mike Ritchie', '18 Tain St, London');
insert into guest values(10003, 'Mary Tregear', '5 Tarbot Rd, Aberdeen');
insert into guest values(10004, 'Joe Keogh', '2 Fergus Dr, Aberdeen');
insert into guest values(10005, 'Carol Farrel', '6 Achray St, Glasgow');
insert into guest values(10006, 'Tina Murphy', '63 Well St, Glasgow');
insert into guest values(10007, 'Tony Shaw', '12 Park Pl, Glasgow');


create table booking(
hotelno varchar(10),
guestno numeric(5),
datefrom datetime,
dateto datetime,
roomno numeric(5),
primary key (hotelno, guestno, datefrom),
foreign key (roomno, hotelno) REFERENCES room(roomno, hotelno),
foreign key (guestno) REFERENCES guest(guestno)
)

 

insert into booking values('fb01', 10001, '04-04-01', '04-04-08', 501);
insert into booking values('fb01', 10004, '04-04-15', '04-05-15', 601);
insert into booking values('fb01', 10005, '04-05-02', '04-05-07', 501);
insert into booking values('fb01', 10001, '04-05-01', null, 701);
insert into booking values('fb02', 10003, '04-04-05', '10-04-04', 1001);
insert into booking values('ch01', 10006, '04-04-21', null, 1101);
insert into booking values('ch02', 10002, '04-04-25', '04-05-06', 801);
insert into booking values('dc01', 10007, '04-05-13', '04-05-15', 1001);
insert into booking values('dc01', 10003, '04-05-20', null, 1001);



select * from booking
select * from guest
select * from hotel
select * from room

/*Question 1*/
select guestname,guestaddress
from guest where guestaddress like '%London' order by guestname

/*Question 2*/
select A.hotelname,count(B.roomno) as total_rooms 
from hotel A inner join room B  on A.hotelno=B.hotelno group by hotelname

/*Question 3*/
select hotelname,AVG(price)as Average_Price from hotel A inner join room B 
on A.hotelno=B.hotelno  where A.city='London'group by hotelname 

/*Question 4*/
select H.hotelname,max(price) as price,type from hotel H inner join room R on 
H.hotelno=R.hotelno group by hotelname ,type

/*Question 5*/
select hotelname,city,count(Distinct type)
from hotel H 
inner join room R on H.hotelno=R.hotelno
group by hotelname,city

/*Question 6*/
 SELECT DISTINCT hotel.hotelname, hotel.city
FROM booking
JOIN hotel ON booking.hotelno = hotel.hotelno
JOIN guest ON booking.guestno = guest.guestno
WHERE guest.guestaddress LIKE '%London%';

/*Q7*/
SELECT hotelname, city, COUNT(*) AS num_reservations
FROM booking
JOIN hotel ON booking.hotelno = hotel.hotelno
GROUP BY hotelname, city
ORDER BY num_reservations DESC;

/*Q8*/
SELECT guestname
FROM booking
JOIN guest ON booking.guestno = guest.guestno
WHERE dateto IS NULL;


/*Q9*/
SELECT h.hotelname, b.roomno, b.guestno, YEAR(b.datefrom) AS year_reserved
FROM booking b
JOIN hotel h ON h.hotelno = b.hotelno
WHERE YEAR(b.datefrom) IN (2001, 2002)
ORDER BY year_reserved;

/*Q10*/
SELECT h.hotelname, h.city
from hotel h inner join booking b on b.hotelno=h.hotelno
where h.hotelno not in(select hotelno from booking) 

/*Q11*/
SELECT h.hotelname, h.hotelno, r.roomno, r.price
FROM hotel h
LEFT JOIN room r ON r.hotelno = h.hotelno AND r.type = 'family';

/*Q12*/
SELECT COUNT(DISTINCT guestno) AS num_guests
FROM booking where dateto<=('2015/5/30')

