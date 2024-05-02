# Project Database Setup Instructions

A quick note to the user: to simplify the implementation and review process, we divided the
database into four primary files:

1. `trip_plan.sql` - Use this file to create the database and tables.
2. `insertion_data.sql` - This file is used to insert data into the database.
3. `views.sql` - This file creates a set of views.
4. `queries.sql` - Contains queries to interact with the data.

To assemble our database, please run the files in the following order:
- First, run `trip_plan.sql`
- Next, run `insertion_data.sql`
- Then, run `views.sql`
- Finally, run `queries.sql`
