CREATE SCHEMA Tourism;

SET SEARCH_PATH TO Tourism;

CREATE TABLE Customer(
  	Customer_ID varchar,
  	CustomerName varchar NOT NULL,
  	ContactNumber bigint NOT NULL,
  	Email varchar,
  	Gender char NOT NULL,
  	City varchar NOT NULL,
  	DOB date NOT NULL,
	PRIMARY KEY(Customer_ID)
);


CREATE TABLE Destination(
	Destination_Name varchar,
	Type_of_Place varchar NOT NULL,
	City varchar NOT NULL,
	Nearby_Landmark varchar NOT NULL,
	Area varchar NOT NULL,
	Pincode int NOT NULL,
	Bus_Stat_Dist float NOT NULL,
	Railway_Stat_Dist float NOT NULL,
	PRIMARY KEY(Destination_Name)
);


CREATE TABLE Sightseeing_Places(
	Dest_Name varchar,
	Sight_Name varchar,
	Timing varchar,
	TicketPrice float,
	Dist_from_Dest float NOT NULL,
	FOREIGN KEY(Dest_Name) REFERENCES Destination(Destination_Name) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY(Dest_Name,Sight_Name)
);


CREATE TABLE Visited(
	Dest_Name varchar,
	Cust_ID varchar,
	No_of_Days integer NOT NULL,
	Start_Date date NOT NULL,
	FOREIGN KEY(Dest_Name) REFERENCES Destination(Destination_Name) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(Cust_ID) REFERENCES Customer(Customer_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY(Dest_Name,Cust_ID)
);


CREATE TABLE Tours_and_Travels(
	Tour_ID varchar,
	Company_Name varchar NOT NULL,
	Website varchar,
	Email_ID varchar,
	Rating float NOT NULL,
	PRIMARY KEY(Tour_ID)
);


CREATE TABLE Tour_Contact_Details(
	Tour_ID varchar,
	Contact_number bigint NOT NULL,
	FOREIGN KEY (Tour_ID) REFERENCES Tours_and_Travels(Tour_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY(Tour_ID,Contact_number)
);


CREATE TABLE Tourist(
	Dest_Name varchar,
	Tour_ID varchar,
	Cust_ID varchar,
	Start_Date date NOT NULL,
	End_Date date NOT NULL,
	Budget_Constraint float,
	Children integer,
	Adults integer NOT NULL,
	FOREIGN KEY (Cust_ID) REFERENCES Customer(Customer_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (Tour_ID) REFERENCES Tours_and_travels(Tour_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (Dest_Name) REFERENCES Destination(Destination_Name) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY(Dest_Name,Tour_ID,Cust_ID)
);


CREATE TABLE Pricing_conditions(
	Dest_Name varchar,
	Tour_ID varchar,
	Cosultant_Fee float NOT NULL,
	Refund_Percent float NOT NULL,
	FOREIGN KEY (Dest_Name) REFERENCES Destination(Destination_Name) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (Tour_ID) REFERENCES Tours_and_Travels(Tour_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY(Dest_Name,Tour_ID)
);


CREATE TABLE Packages(
	Dest_name varchar,
	Tour_ID varchar,
	Days integer,
	Amount float NOT NULL,
	FOREIGN KEY (Dest_Name) REFERENCES Destination(Destination_Name) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (Tour_ID) REFERENCES Tours_and_travels(Tour_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY(Dest_Name,Tour_ID,Days)
);


CREATE TABLE Hotels(
  	Hotel_ID varchar,
  	Hotel_Name varchar,
  	Type_of_Hotel varchar NOT NULL,
  	Dist_from_Dest float NOT NULL,
  	Rating float NOT NULL,
  	Website varchar,
	PRIMARY KEY(Hotel_ID)
);


CREATE TABLE Hotel_Contact_Detail(
	Hotel_ID varchar,
	Contact_Num bigint,
	FOREIGN KEY (Hotel_ID) REFERENCES Hotels(Hotel_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY(Hotel_ID,Contact_Num)
);


CREATE TABLE Available_Hotels(
	Dest_Name varchar,
	Hotel_ID varchar,
	FOREIGN KEY(Dest_Name) REFERENCES Destination(Destination_Name) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(Hotel_ID) REFERENCES Hotels(Hotel_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY(Dest_Name,Hotel_ID)
);


CREATE TABLE Room_Type(
	Hotel_ID varchar,
	Room_Type varchar,
	Total_Rooms integer NOT NULL, 
	Price float NOT NULL,
	FOREIGN KEY (Hotel_ID) REFERENCES Hotels(Hotel_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY(Hotel_ID, Room_Type)
);


CREATE TABLE Refund_Policy(
	Hotel_ID varchar,
	Room_Type varchar,
	Days integer NOT NULL,
	Amnt_Per float NOT NULL,
	FOREIGN KEY (Hotel_ID,Room_Type) REFERENCES Room_Type(Hotel_ID,Room_Type) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY(Hotel_ID,Room_Type,Days)
);


CREATE TABLE Room_Number(
	Hotel_ID varchar,
	Room_Type varchar,
	Room_No varchar,
	FOREIGN KEY (Hotel_ID,Room_Type) REFERENCES Room_Type(Hotel_ID,Room_Type) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY(Hotel_ID, Room_Type, Room_No)
);


CREATE TABLE Bookings(
	Tour_ID varchar,
	Cust_ID varchar NOT NULL,
	StartDate date,
	EndDate date NOT NULL,
	Children integer,
	Adults integer NOT NULL,
	Hotel_ID varchar,
	Room_Type varchar,
	Room_No varchar,
	PRIMARY KEY(StartDate,Hotel_ID,Room_Type,Room_no),
	FOREIGN KEY (Tour_ID) REFERENCES Tours_and_Travels(Tour_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (Cust_ID) REFERENCES Customer(Customer_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (Hotel_ID,Room_Type,Room_No) REFERENCES Room_Number(Hotel_ID,Room_Type,Room_no) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Cancellations(
	Tour_ID varchar,
	Cust_ID varchar,
	StartDate date,
	CancellationDate date NOT NULL,
	EndDate date NOT NULL,
	Hotel_ID varchar,
	Room_Type varchar,
	PRIMARY KEY(StartDate,Hotel_ID,Room_Type,Cust_ID),
	FOREIGN KEY (Tour_ID) REFERENCES Tours_and_Travels(Tour_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (Cust_ID) REFERENCES Customer(Customer_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (Hotel_ID,Room_Type) REFERENCES Room_Type(Hotel_ID,Room_Type) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE Rating_Hotel(
	Cust_ID varchar,
	Hotel_ID varchar,
	Stars integer,
	FOREIGN KEY(Cust_ID) REFERENCES Customer(Customer_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(Hotel_ID) REFERENCES Hotels(Hotel_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY(Cust_ID,Hotel_ID)
);


CREATE TABLE Rating_TandT(
	Cust_ID varchar,
	Tour_ID varchar,
	Stars integer,
	FOREIGN KEY(Cust_ID) REFERENCES Customer(Customer_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(Tour_ID) REFERENCES Tours_and_Travels(Tour_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY(Cust_ID,Tour_ID)
);


CREATE TABLE Rating_Dest(
	Cust_ID varchar,
	Dest_Name varchar,
	Stars integer,
	FOREIGN KEY(Cust_ID) REFERENCES Customer(Customer_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(Dest_Name) REFERENCES Destination(Destination_Name) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY(Cust_ID,Dest_Name)
);
