-- Part 1)
-- a) Create Customer Table
CREATE TABLE Customer (
    custid VARCHAR(5),
    firstname VARCHAR(10),
    lastname VARCHAR(15),
    city VARCHAR(10),
    PRIMARY KEY(custid)
);

-- b) Create DeliveryService Table
CREATE TABLE DeliveryService (
    serviceid VARCHAR(10),
    item CHAR(15),
    location VARCHAR(15),
    servicefee NUMBER(5, 2),
    PRIMARY KEY(serviceid)
);

-- c) Create Schedule Table
CREATE TABLE Schedule (
    serviceid VARCHAR(10),
    custid VARCHAR(5),
    day VARCHAR(2) NOT NULL CHECK(day='m' OR day='t' OR day='w' OR day='r' OR day='f'),
    FOREIGN KEY(serviceid) REFERENCES DeliveryService(serviceid),
    FOREIGN KEY(custid) REFERENCES Customer(custid)
);

-- Insert Tuples into Customer Table
INSERT INTO Customer VALUES (
    'c1', 'John', 'Smith', 'SJ'
);

INSERT INTO Customer VALUES (
    'c2', 'Mary', 'Jones', 'SFO'
);

INSERT INTO Customer VALUES (
    'a1', 'Vincent', 'Chen', 'SJ'
);

INSERT INTO Customer VALUES (
    'a12', 'Greg', 'King', 'SJ'
);

INSERT INTO Customer VALUES (
    'c7', 'James', 'Bond', 'LA'
);

INSERT INTO Customer VALUES (
    'x10', 'Susan', 'Blogg', 'SFO'
);

INSERT INTO Customer VALUES (
    'y10', 'Sam', 'Weick', 'SD'
);

INSERT INTO Customer VALUES (
    'z10', 'Rob', 'Cady', 'SJ'
);

INSERT INTO Customer VALUES (
    'k1', 'Kyle', 'Lam', 'SJ'
);

-- Insert Tuples into DeliveryService Table
INSERT INTO DeliveryService VALUES (
    'dsg1','grocery','SJ',25.0
);

INSERT INTO DeliveryService VALUES (
    'dsb1','books','SJ',10.0
);

INSERT INTO DeliveryService VALUES (
    'dsm2','movies','LA',10.0
);

INSERT INTO DeliveryService VALUES (
    'dby3','babygoods','SFO',15.0
);

INSERT INTO DeliveryService VALUES (
    'dsg2','grocery','SFO',20.0
);

INSERT INTO DeliveryService VALUES (
    'dg5','greengoods','SFO',30.0
);

INSERT INTO DeliveryService VALUES (
    'dg6','greengoods','SJ',20.0
);

INSERT INTO DeliveryService VALUES (
    'dsg3','grocery','SFO',20.0
);

-- Insert Tuples into Schedule Table
INSERT INTO Schedule VALUES (
    'dsg1','c1','m'
);

INSERT INTO Schedule VALUES (
    'dsg1','a12','w'
);

INSERT INTO Schedule VALUES (
    'dby3','x10','f'
);

INSERT INTO Schedule VALUES (
    'dg5','c1','r'
);

INSERT INTO Schedule VALUES (
    'dg5','c1','t'
);

INSERT INTO Schedule VALUES (
    'dg5','c32','t'
);

INSERT INTO Schedule VALUES (
    'dsg2','c1','s'
);

INSERT INTO Schedule VALUES (
    'dg0','c1','m'
);
