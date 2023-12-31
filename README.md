Ad-hoc Data Analysis:
The Czechoslovakia Bank has provided a dataset containing information about its 
financial activities for the past 5 years. The dataset consists of 8 tables: account, card, client, district, loan, transaction,Disposition, orders.
The Czechoslovakia Bank wants to analyse its financial data to gain insights and make informed 
decisions. The bank needs to identify trends, patterns, and potential risks in its financial operations.

It is an automated project where I did continuous data Integration to snowflake with the help of aws. After loading the data multiple queries have been performed 
using advanced sql and created master tables. Futher, I have connected snowflake to POWER BI for Data visualization.  

The analysis involves : demographic profile of the bank's clients ,types of accounts and cards used by the clients,top customers,loan trends.

Tools Used: Excel, AWS, Snowflake , Power BI.

1. Data Cleaning using Excel:
Cleaned all 8 files, created custom columns.

2. Table Creation using snowflake:
Created Tables.

3. S3 bucket in AWS:
S3 bucket and policy created and then attached to role.

4.Storage Intergration:
Created Cloud Storage Integration in Snowflake and mapped S3 user/role with it.
Modified Trust Relationships by using STORAGE_AWS_IAM_USER_ARN and STORAGE_AWS_EXTERNAL_ID

5. File Format and Staging in Snowflake:
Created Snowflake file format. This file format used at the time of Stage creation.Created stage in snowflake pointing to S3 bucket.

6. SnowPipe:
Snowpipe is created which will get SQS event notification once data is being uploaded in S3 bucket by updating ‘Notification Channel’ value to SQS Queue ARN.






