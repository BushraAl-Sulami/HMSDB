
CREATE  DATABASE Hotel; 
USE Hotel;

CREATE TABLE Employee (
    EmployeeID INT(20) NOT NULL,
    Position VARCHAR(25),
    Salary DECIMAL(10, 2),
    Email VARCHAR(25) unique,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Super_ID INT(20),
	CONSTRAINT Employee_PK PRIMARY KEY (EmployeeID),
    CONSTRAINT Employee_FK1  FOREIGN KEY (Super_ID) REFERENCES Employee(EmployeeID) ON DELETE CASCADE
);

CREATE TABLE Guest (
    GuestID INT(20) NOT NULL,
    Email VARCHAR(25) unique,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    CONSTRAINT Guest_PK PRIMARY KEY (GuestID)
);

CREATE TABLE Reservation (
    ReservationID INT(20) NOT NULL,
    BookingSource VARCHAR(30),
    CheckInDate DATE,
    CheckOutDate DATE,
    GuestID INT(20),
    EmployeeID INT(20),
    CONSTRAINT Reservation_PK PRIMARY KEY (ReservationID),
    CONSTRAINT Reservation_FK1  FOREIGN KEY (GuestID) REFERENCES Guest(GuestID) ON DELETE SET NULL ,
    CONSTRAINT Reservation_FK2  FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID) ON DELETE CASCADE
);

CREATE TABLE Service (
    ServiceName VARCHAR(25) NOT NULL,
    ServicePrice DECIMAL(10, 2),
     ReservationID INT(20) NOT NULL,
     CONSTRAINT Service_PK PRIMARY KEY (ServiceName, ReservationID),
     CONSTRAINT Service_FK1  FOREIGN KEY (ReservationID) REFERENCES Reservation(ReservationID) ON DELETE CASCADE
);

CREATE TABLE Billing(
    InvoiceNumber INT(20) NOT NULL,
    Amount DECIMAL(10, 2),
	CONSTRAINT Billing_PK PRIMARY KEY (InvoiceNumber)
);

CREATE TABLE Room (
    RoomNo INT(20) NOT NULL,
    RoomType VARCHAR(25),
    RoomStatus VARCHAR(50),
	ReservationID INT(20) ,
    CONSTRAINT Room_PK PRIMARY KEY (RoomNo),
    CONSTRAINT Reservation_Fk  FOREIGN KEY (ReservationID) REFERENCES Reservation(ReservationID) ON DELETE CASCADE ,
    CONSTRAINT Room_info_FK2  FOREIGN KEY (RoomType) REFERENCES Room_info(RoomType) ON DELETE CASCADE
);

CREATE TABLE Employee_phone (
   EphonenNo INT(20) NOT NULL,
   EmployeeID INT(20)NOT NULL,
   CONSTRAINT Employee_phone_PK PRIMARY KEY (EphonenNo,EmployeeID),
   CONSTRAINT Employee_phone_FK1  FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID) ON DELETE CASCADE
);

CREATE TABLE Guest_phone (
   GphonenNo INT(20) NOT NULL,
   GuestID INT(20)NOT NULL,
   CONSTRAINT Guest_phone_PK PRIMARY KEY (GphonenNo,GuestID),
   CONSTRAINT Guest_phone_FK1  FOREIGN KEY (GuestID) REFERENCES Guest(GuestID) ON DELETE CASCADE
);

CREATE TABLE Serves (
   EmployeeID INT(20)NOT NULL,
   GuestID INT(20)NOT NULL,
   CONSTRAINT Serves_PK PRIMARY KEY (GuestID,EmployeeID),
   CONSTRAINT Serves_FK1  FOREIGN KEY (GuestID) REFERENCES Guest(GuestID) ON DELETE CASCADE,
   CONSTRAINT Serves_FK2  FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID) ON DELETE CASCADE
);

CREATE TABLE TideTo (
  InvoiceNumber INT(20) NOT NULL,
  ReservationID INT(20) NOT NULL,
   CONSTRAINT TideTo_PK PRIMARY KEY (InvoiceNumber,ReservationID),
   CONSTRAINT TideTo_FK1  FOREIGN KEY (InvoiceNumber) REFERENCES Billing(InvoiceNumber) ON DELETE CASCADE,
   CONSTRAINT TideTo_FK2  FOREIGN KEY (ReservationID) REFERENCES Reservation(ReservationID) ON DELETE CASCADE
);

CREATE TABLE Room_info(
 RoomPrice DECIMAL(10, 2),
 RoomType VARCHAR(25) NOT NULL,
 CONSTRAINT Room_info_PK PRIMARY KEY (RoomType)
);

INSERT INTO Employee (EmployeeID, Position, Salary, FirstName, LastName,  Super_ID)
VALUES
  (11, 'Hotel Manager', 80000.00, 'Ahmed', 'Alghamdi',NULL),
  (67, 'Receptionist', 30000.00, 'Noura', 'Alotaibi',11),
  (78, 'Receptionist', 30000.00, 'Faisal', 'Algarni',11),
  (13, 'Receptionist', 30000.00, 'Saad', 'Alhudhali',11),
  (89, 'Housekeeper', 35000.00, 'Huda', 'Alshahrani',11),
  (40, 'Sales Manager', 45000.00, 'Shady', 'Radwan',11),
  (90, 'Chef', 50000.00, 'Amjad', 'Alharbi',11),
  (12, 'Marketing Manager', 60000.00, 'cyrine','nour',11);

INSERT INTO Guest (GuestID, Email, FirstName, LastName)
VALUES
  (1115600983,'FawzyahAllhaibi@gmail.com', 'Fawzyah', 'Allhaibi'),
  (1097885674,'SalwaAlhudhali@gmail.com', 'Salwa', 'Alhudhali'),
  (1445690141,'BayanAlabdali@gmail.com', 'Bayan', 'Algarni'),
  (1102894566,'NedaaAlabdali@gmail.com', 'Nedaa', 'Alabdali '),
  (1023455198,'MurojIbrahim@gmail.com', 'Muroj', 'Ibrahim'),
  (1072945188,'MarwahAlqurashi@gmail.com', 'Marwah', 'Alqurashi');

INSERT INTO Reservation (ReservationID, BookingSource, CheckInDate, CheckOutDate, GuestID, EmployeeID)
VALUES
  (2, 'Online Booking', '2024-02-5', '2024-02-20', 1097885674, 13),
  (3, 'Phone Reservation', '2024-02-4', '2024-02-15', 1115600983, 67),
  (4, 'Walk-In', '2024-02-01', '2024-02-09', 1445690141, 78),
  (5, 'Online Booking', '2024-02-10', '2024-02-18', 1072945188, 67),
  (6, 'Phone Reservation', '2024-02-10', '2024-03-25', 1102894566, 13),
  (7, 'Phone Reservation', '2024-04-20', '2024-04-22', 1102894566, 13);

INSERT INTO Employee_phone ( EmployeeID ,  EphonenNo )
  VALUES
  (11,0535676650) ,
  (67,0557611209),
  (78,0502613510),
  (13,0530868547),
  (89,0597610087),
  (40,0501388705),
  (90,0531205590), 
  (12,0539086701) ;
  
INSERT INTO Guest_phone ( GuestID , GphonenNo ) 
  VALUES 
  (1115600983,0554511241),
  (1097885674,0548116076),
  (1445690141,0530878610),
  (1102894566,0544533440),
  (1023455198,0532929765),
  (1072945188,0535461328);


INSERT INTO Service (ServiceName, ServicePrice, ReservationID)
VALUES 
("Breakfast", 80.00, 4 ) ,
("Hairdresser", 40.00, 7 ),
("Laundry" , 10.00, 3 ), 
("Guided tour service" , 100.00, 2 ),
("Airport Shuttle" , 50.00 , 5) , 
("Room Cleaning", 0.00, 4 );

INSERT INTO Serves (EmployeeID, GuestID)
VALUES 
(13, 1097885674),
(67, 1115600983),
(78, 1445690141),
(67, 1072945188),
(13, 1102894566);

# There is a 15% increase in prices due to tax
 INSERT INTO Billing ( InvoiceNumber,  Amount)
 VALUES 
 (1001,5750),
 (2002,3450),
 (3456,2300),
 (8888,4600),
 (5003,5175);

INSERT INTO TideTo (InvoiceNumber ,ReservationID)
VALUES 
   (1001,2),
   (2002,3),
   (3456,4),
   (8888,5),
   (5003,6);

INSERT INTO Room_info( RoomType, RoomPrice)
   VALUES 
   ('Suite',5000),
   ('Junior suite',4500),
   ('Twin',4000),
   ('Double',3000),
   ('Single',2000);

INSERT INTO Room (RoomNo, RoomType, RoomStatus, ReservationID) 
VALUES 
(101 , "Suite", "Occupied" , 2) ,
(102 , "Double", "Occupied" , 3) ,
(103 , "Single", "Occupied" , 4) ,
(104 , "Suite", "Out Of Service" , NULL) ,
(105 , "Twin", "Dirty and Occupied" , 5) ,
(106 , "Junior Suite", "Occupied" , 6) ;


 ##  update data in a table Employee ##
  UPDATE Employee
  SET Position = 'Executive Chef'
  WHERE EmployeeID = 90;
  
##  update data in a table Guest ##
  UPDATE Guest
  SET Email = 'SalwaAL24@gmail.com'
  WHERE GuestID = 1097885674;
  
  ##  update data in a table Reservation ##
  UPDATE Reservation
  SET CheckOutDate = '2024-03-5'
  WHERE ReservationID = 6;
  
  ##  delete data in a table Guest ##
  DELETE FROM Guest
  WHERE GuestID = 1023455198;
  
  ## delete data in a table Employee ##
  DELETE FROM Employee
  WHERE EmployeeID = 12;
  
  ## delete data in a table Reservation ##
  DELETE FROM Reservation
  WHERE ReservationID = 7;


USE Hotel;  
# list the room type, reservation ID, and amount for reservations that an invoice greater than 2500.
SELECT r.RoomType, tt.ReservationID, b.Amount
FROM Room r
JOIN TideTo tt ON r.ReservationID = tt.ReservationID
JOIN Billing b ON tt.InvoiceNumber = b.InvoiceNumber
WHERE tt.ReservationID IN (
    SELECT tt.ReservationID
    FROM TideTo tt
    JOIN Billing b ON tt.InvoiceNumber = b.InvoiceNumber
    WHERE b.Amount > 2500
);

# List the room details, reservation ID, and billing amount for each room,
SELECT r.RoomNo, r.RoomType, r.ReservationID, b.Amount
FROM Room r
LEFT JOIN TideTo tt ON r.ReservationID = tt.ReservationID
LEFT JOIN Billing b ON tt.InvoiceNumber = b.InvoiceNumber;

# list the average salary of employees in each position 
SELECT position, AVG(salary) AS AverageSalary
FROM Employee
GROUP BY position 
ORDER BY AverageSalary DESC;


# List  guests who made reservations through"Online Booking" .
SELECT g.FirstName, g.LastName
FROM Guest g
JOIN Reservation r ON g.GuestID = r.GuestID
WHERE r.BookingSource = 'Online Booking';


# lists the number of reservations made by each employee.
SELECT e.FirstName, e.LastName, COUNT(r.ReservationID) AS ReservationCount
FROM Employee e
LEFT JOIN Reservation r ON e.EmployeeID = r.EmployeeID
GROUP BY e.EmployeeID;


# lists gusest in desc by the amount spent on services 
SELECT g.FirstName, g.LastName, SUM(s.ServicePrice) AS TotalSpending
FROM Guest g
JOIN Reservation r ON g.GuestID = r.GuestID
JOIN Service s ON r.ReservationID = s.ReservationID
WHERE g.GuestID IN (
    SELECT Reservation.GuestID
    FROM Reservation
    JOIN Service ON Reservation.ReservationID = Service.ReservationID
    GROUP BY Reservation.GuestID
    ORDER BY SUM(ServicePrice) DESC
)
GROUP BY g.GuestID, g.FirstName, g.LastName
ORDER BY TotalSpending DESC;


# lists gusest in desc by the amount spent on services 
SELECT g.FirstName, g.LastName, SUM(s.ServicePrice) AS TotalSpending
FROM Guest g
JOIN Reservation r ON g.GuestID = r.GuestID
JOIN Service s ON r.ReservationID = s.ReservationID
WHERE g.GuestID IN (
    SELECT Reservation.GuestID
    FROM Reservation
    JOIN Service ON Reservation.ReservationID = Service.ReservationID
    GROUP BY Reservation.GuestID
    ORDER BY SUM(ServicePrice) DESC
)
GROUP BY g.GuestID, g.FirstName, g.LastName
ORDER BY TotalSpending DESC;





# listing firstname,last name and guestid order by first name asc
SELECT FirstName,LastName,GuestID
FROM guest 
ORDER BY FirstName ASC;

# list the employeeid,lastname and the monthly salaries for each of themو descending
 select EmployeeID,LastName,salary/12 As monthlySalary
  from employee
  order by monthlySalary desc;

# list all billing COLUMNS only the an amount hight than 5000
  select * 
  from billing
  where amount > 5000;

# listing the roomNo, roomType and RoomStatus only for the rooms with occupied room status
  select roomNo,RoomType,RoomStatus
  from room
  where RoomStatus in ('Occupied');
  
  
# lists guests who have made more than one reservation:
SELECT FirstName, LastName
FROM Guest
WHERE GuestID IN (
    SELECT GuestID
    FROM Reservation
    GROUP BY GuestID
    HAVING COUNT(*) > 1
);