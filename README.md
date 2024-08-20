# MySQL Examples
3 Basic Scripts demonstrating my ability to set up databases, tables, populating, and queries.

## Library Management System
Rather basic relational database, containing 3 tables for the books the library has, borrowers contacts, and a record of every time a book is borrowed.

This example has a couple of interesting, being the use of default values, and the procedure `ReturnBook()`. It will delete any and all borrowers from the tbl_borrowers who have returned all books checked out in the tbl_borrowed table. Making sure not to delete any users who still have books to return.

It's an 'interesting' way to maintain a database, which I wouldn't recommend, but it was the feature request, and what I delivered.

## eCommerce System
Another relational database, we have a few procedures this time. These allow you to either automatically update the stock level when a customer places an order, display how much revenue has been earned so far, or show you who is a repeat customer.

What's important in this example is the use of `ON DELETE CASCADE` and `ON UPDATE CASCADE`. Used here to maintain data integrity when a product is removed from `tbl_products`. So an item no longer offered can't be ordered or shipped.

## School Course Enrollment System
lorum ipsum

## Authors
- James Bullen

## Acknowledgement
- Abdul Jalloh for the database requirements and restraints
