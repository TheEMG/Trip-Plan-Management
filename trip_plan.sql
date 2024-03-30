/* Test DB*/
DROP SCHEMA IF EXISTS Tester;
CREATE SCHEMA Tester;
USE Tester;

CREATE TABLE Member(
    Member_ID VARCHAR(30);

    PRIMARY KEY Member_ID;
)

ALTER TABLE Member
    ADD CONSTRAINT ID_Format
        CHECK (Member_ID RLIKE "[:alpha:]{0,15}[0-9]{0,15}");

DROP TABLE Member;
