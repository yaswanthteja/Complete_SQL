# Basic SQL Questions

## 1 What is SQL?

 Structured Query Language SQL is a database tool used to create and access the database to support software applications.
 
MySQL is a multithreaded, multi-user SQL database management system that has more than 11 million installations. It is the world's second most popular and widely-used open source database. It is interesting how MySQL name was given to this query language. The term I is coined by the name of the daughter of co-founder Michael Widenius's daughter, and SQL is the short form of Structured Query Language. Using MySQL is free of cost for the developer, but enterprises have to pay a license fee to Oracle.

Formerly MySQL was initially owned by a for-profit firm MySQL AB, then Sun Microsystems bought it, and then Oracle bought Sun Microsystems, so Oracle currently owns MySQL.

MySQL is an Oracle-supported Relational Database Management System (RDBMS) based on structured query language. MySQL supports a wide range of operating systems, most famous of those include Windows, Linux & UNIX. Although it is possible to develop a wide range of applications with MySQL, it is only used for web applications & online publishing. It is a fundamental part of an open-source enterprise known as Lamp.



## 2) What are tables in SQL?

The table is a collection of records and information in a single view.


## 3. What does a MySQL database contain?
A MySQL database contains one or more tables, each of which contains records or rows. Within these rows are various columns or fields that contain the data itself.

## 4. How can you interact with MySQL?
There are three main ways you can interact with MySQL: 

using a command line
via a web interface
through a programming language
#3 5. What are MySQL Database Queries?
A query is a specific request or a question. One can query a database for specific information and have a record returned.

## 5.What are MySQL “Views”?
In MySQL, a view consists of a set of rows that is returned if a particular query is executed. This is also known as a ‘virtual table’. Views make it easy to retrieve the way of making the query available via an alias. 
The advantages of views are:

- Simplicity
- Security
- Maintainability

## 6.What are MySQL Triggers?
A trigger is a task that executes in response to some predefined database event, such as after a new row is added to a particular table. Specifically, this event involves inserting, modifying, or deleting table data, and the task can occur either prior to or immediately following any such event. 
Triggers have many purposes, including:

- Audit Trails
- Validation
- Referential integrity enforcement
 ## 7. How many Triggers are possible in MySQL?
 There are six Triggers allowed to use in the MySQL database:

- Before Insert
- After Insert
- Before Update
- After Update
- Before Delete
- After Delete

## 8.What is DBMS?
DBMS stands for Database Management System. DBMS is a system software responsible for the creation, retrieval, updation, and management of the database. It ensures that our data is consistent, organized, and is easily accessible by serving as an interface between the database and its end-users or application software

## 9. What is RDBMS? How is it different from DBMS?
RDBMS stands for Relational Database Management System. The key difference here, compared to DBMS, is that RDBMS stores data in the form of a collection of tables, and relations can be defined between the common fields of these tables. Most modern database management systems like MySQL, Microsoft SQL Server, Oracle, IBM DB2, and Amazon Redshift are based on RDBMS.

## 10.What are Constraints in SQL?
Constraints are used to specify the rules concerning data in the table. It can be applied for single or multiple fields in an SQL table during the creation of the table or after creating using the ALTER TABLE command. The constraints are:

- NOT NULL - Restricts NULL value from being inserted into a column.
- CHECK - Verifies that all values in a field satisfy a condition.
- DEFAULT - Automatically assigns a default value if no value has been specified for the field.
- UNIQUE - Ensures unique values to be inserted into the field.
- INDEX - Indexes a field providing faster retrieval of records.
- PRIMARY KEY - Uniquely identifies each record in a table.
- FOREIGN KEY - Ensures referential integrity for a record in another table.

## 8. What is a Primary Key?

The PRIMARY KEY constraint uniquely identifies each row in a table. It must contain UNIQUE values and has an implicit NOT NULL constraint.
A table in SQL is strictly restricted to have one and only one primary key, which is comprised of single or multiple fields (columns).
```

CREATE TABLE Students (   /* Create table with a single field as primary key */
   ID INT NOT NULL
   Name VARCHAR(255)
   PRIMARY KEY (ID)
);

CREATE TABLE Students (   /* Create table with multiple fields as primary key */
   ID INT NOT NULL
   LastName VARCHAR(255)
   FirstName VARCHAR(255) NOT NULL,
   CONSTRAINT PK_Student
   PRIMARY KEY (ID, FirstName)
);

ALTER TABLE Students   /* Set a column as primary key */
ADD PRIMARY KEY (ID);
ALTER TABLE Students   /* Set multiple columns as primary key */
ADD CONSTRAINT PK_Student   /*Naming a Primary Key*/
PRIMARY KEY (ID, FirstName);

```

- write a sql statement to add primary key 't_id' to the table 'teachers'.
- Write a SQL statement to add primary key constraint 'pk_a' for table 'table_a' and fields 'col_b, col_c'.

## 9. What is a UNIQUE constraint?

A UNIQUE constraint ensures that all values in a column are different. This provides uniqueness for the column(s) and helps identify each row uniquely. Unlike primary key, there can be multiple unique constraints defined per table. The code syntax for UNIQUE is quite similar to that of PRIMARY KEY and can be used interchangeably.

```
CREATE TABLE Students (   /* Create table with a single field as unique */
   ID INT NOT NULL UNIQUE
   Name VARCHAR(255)
);

CREATE TABLE Students (   /* Create table with multiple fields as unique */
   ID INT NOT NULL
   LastName VARCHAR(255)
   FirstName VARCHAR(255) NOT NULL
   CONSTRAINT PK_Student
   UNIQUE (ID, FirstName)
);

ALTER TABLE Students   /* Set a column as unique */
ADD UNIQUE (ID);
ALTER TABLE Students   /* Set multiple columns as unique */
ADD CONSTRAINT PK_Student   /* Naming a unique constraint */
UNIQUE (ID, FirstName);

```
## 10. What is a Foreign Key?

A FOREIGN KEY comprises of single or collection of fields in a table that essentially refers to the PRIMARY KEY in another table. Foreign key constraint ensures referential integrity in the relation between two tables.It prevents invalid data entries.

The table with the foreign key constraint is labeled as the child table, and the table containing the candidate key is labeled as the referenced or parent table.

```
CREATE TABLE Students (   /* Create table with foreign key - Way 1 */
   ID INT NOT NULL
   Name VARCHAR(255)
   LibraryID INT
   PRIMARY KEY (ID)
   FOREIGN KEY (Library_ID) REFERENCES Library(LibraryID)
);

CREATE TABLE Students (   /* Create table with foreign key - Way 2 */
   ID INT NOT NULL PRIMARY KEY
   Name VARCHAR(255)
   LibraryID INT FOREIGN KEY (Library_ID) REFERENCES Library(LibraryID)
);

ALTER TABLE Students   /* Add a new foreign key */
ADD FOREIGN KEY (LibraryID)
REFERENCES Library (LibraryID);
```


## 11. What is a Candidate key?
 A candidate key is an attribute that can uniquely identify records. A table can have multiple candidate keys. One of them is chosen as the primary key. Others are called alternative keys.


## 12. What is a Composite Key?

A composite key consists of two or more attributes. Together, they uniquely identify a record it is used when a single attribute is not enough. Common in junction tables.


## 13. What is the super key?

A super key is a set of attributes that uniquely identifies  records . It may contain extra attributes. All candidate keys are superkeys. Super keys ensure uniqueness.




## 14. what are the advantages of DBMS?
DBMS reduces data redundancy and inconsistency. It provides data Security and integrity. It supports concurrent access and backup recovery. DBMS improves data sharing and reliability.


## 15.  What is Data Redundancy?

Data redundancy means duplication of data in multiple places. It increases storage cost and inconsistency. DBMS minimizes redundancy using normalization. Less redundancy improves data accuracy.


## 16. What is Data Integrity?
Data integrity ensures accuracy and consistency of data. It is maintained using constraints like primary key and foreign key. Integrity prevents invalid data entry. It is essential for reliable databases.

## 17. What is Data Independence?
Data Independence means changes in data structure do not affect application programs. it allows modifying the schema without rewriting code. These are logical and physical data independence. It improves system flexibility.


## 18. What is Schema?

A schema defines the structure of a database. It includes tables, fields, and relationships. A schema is defined during database design. It acts as a blueprint of the database

## 19. What is an instance?

An instance is the actual data stored in the database at a particular time. It changes frequently with operations. An instance reflects the current state of the database. The schema remains constant compared to the instance.

## 20. What is a Table?

A table  is a collection of related data organized in rows and columns. Each row represents a record. Each column represents an attribute. Tables are basic storage units in DBMS.


## 21.  What is Normalization?

Normalization is the process of organizing data to reduce redundancy. It divides tables into smaller related tables. It improves data consistency. Normal forms define normalization rules


## 22. What is Denormalization?
Denormalization is the opposite of normalization. It combines tables to improve performance, and it increases redundancy internationally. Used in read-heavy systems.

## 23. What is 1NF?

First Normal form ensures atomic values in columns. Each column contains single values only. It removes repeating groups. It is the basic level of normalization.

## 24.  What is 2NF?
Second Normal form removes partial dependency. it requires 1NF compliance. Non-key attributes depend on the full primary key. used mainly with composite keys.

## 25. What is 3NF?

Third Noaml Form removes transitive dependency. It requires 2NF compliance.Non-key attributes depend only on the primary key. It improves data integrity.

## 26. what is BCNF?

BCNF is a stronger form of 3NF. Every  determinant must be a candidate key. It removes anomalies not handled by 3NF. used in advanced normalization.



