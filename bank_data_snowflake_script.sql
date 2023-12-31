---------------------------------storage integration-----------
CREATE OR REPLACE STORAGE integration s3_int
TYPE = EXTERNAL_STAGE
STORAGE_PROVIDER = S3
ENABLED = TRUE
STORAGE_AWS_ROLE_ARN ='arn:aws:iam::254936746818:role/snowpipe_new'
STORAGE_ALLOWED_LOCATIONS =('s3://taranabucket/');

DESC integration s3_int;

---------------------------------FILE FORMAT
create or replace file format csv_bank
  type = CSV
  field_delimiter = ','
  skip_header = 1
  compression = none;

  desc file format csv_bank

--------------------------------creating stageing area----------------

CREATE OR REPLACE STAGE BANK
URL ='s3://taranabucket'
file_format = csv_bank
storage_integration = s3_int;


LIST @BANK;
SHOW STAGES;

----------------------------------creating pipe--------------------
CREATE OR REPLACE PIPE BANK_SNOWPIPE_DISTRICT 
AUTO_INGEST = TRUE
AS COPY INTO TARANA.PUBLIC.DISTRICT       --  (table name that you created in snowflake)
FROM @BANK/District   -- (name of the stage)
FILE_FORMAT = ( FORMAT_NAME = 'csv_bank');    

CREATE OR REPLACE PIPE BANK_SNOWPIPE_ACCOUNT  
AUTO_INGEST = TRUE
AS COPY INTO TARANA.PUBLIC.ACCOUNT       --  (table name that you created in snowflake)
FROM @BANK/Account   -- (name of the stage)
FILE_FORMAT = ( FORMAT_NAME = 'csv_bank'); 

CREATE OR REPLACE PIPE BANK_SNOWPIPE_DISP AUTO_INGEST = TRUE AS
COPY INTO TARANA.PUBLIC.DISPOSITION
FROM '@BANK/disp/'
FILE_FORMAT = ( FORMAT_NAME = 'csv_bank'); 

CREATE OR REPLACE PIPE BANK_SNOWPIPE_CARD AUTO_INGEST = TRUE AS
COPY INTO TARANA.PUBLIC.CARD
FROM '@BANK/Card/'
FILE_FORMAT = ( FORMAT_NAME = 'csv_bank');

CREATE OR REPLACE PIPE BANK_SNOWPIPE_ORDER AUTO_INGEST = TRUE AS
COPY INTO TARANA.PUBLIC."`ORDER`"
FROM '@BANK/Orders/'
FILE_FORMAT = ( FORMAT_NAME = 'csv_bank');

CREATE OR REPLACE PIPE BANK_SNOWPIPE_LOAN AUTO_INGEST = TRUE AS
COPY INTO TARANA.PUBLIC.LOAN
FROM '@BANK/Loan/'
FILE_FORMAT = ( FORMAT_NAME = 'csv_bank');

CREATE OR REPLACE PIPE BANK_SNOWPIPE_CLIENT AUTO_INGEST = TRUE AS
COPY INTO TARANA.PUBLIC.CLIENT
FROM '@BANK/Client/'
FILE_FORMAT = ( FORMAT_NAME = 'csv_bank');

CREATE OR REPLACE PIPE BANK_SNOWPIPE_TXNS AUTO_INGEST = TRUE AS
COPY INTO TARANA.PUBLIC.TRANSACTIONS
FROM '@BANK/Trnx/'
FILE_FORMAT = ( FORMAT_NAME = 'csv_bank');

SHOW PIPES;

ALTER PIPE BANK_SNOWPIPE_TXNS refresh;

ALTER PIPE BANK_SNOWPIPE_DISTRICT refresh;

ALTER PIPE BANK_SNOWPIPE_ACCOUNT refresh;

ALTER PIPE BANK_SNOWPIPE_DISP refresh;

ALTER PIPE BANK_SNOWPIPE_CARD refresh;

ALTER PIPE BANK_SNOWPIPE_ORDER refresh;

ALTER PIPE BANK_SNOWPIPE_LOAN refresh;

ALTER PIPE BANK_SNOWPIPE_CLIENT refresh;

select count(*) from TRANSACTIONS;
select count(*) from `ORDER`;
select count(*) from LOAN;
select count(*) from ACCOUNT;
select count(*) from DISTRICT;
select count(*) from DISP;
select count(*) from CARD;
select count(*) from CLIENT;
