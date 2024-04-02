/* Test DB*/
DROP SCHEMA IF EXISTS Tester;
CREATE SCHEMA Tester;
USE Tester;

CREATE TABLE Member(
    Member_ID VARCHAR(30),

    PRIMARY KEY (Member_ID)
);

ALTER TABLE Member
    ADD CONSTRAINT ID_Format
        CHECK (Member_ID RLIKE "[:alpha:]{0,15}[0-9]{0,15}");

INSERT INTO Member (Member_ID)
	VALUES 
		("ABDCE00000"),
        ("FFFFFFFFFFFFFF111111111111111"),
        ("CACTUS0000");

SELECT * FROM Member;
--test
