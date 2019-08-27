I have written a script using python boto library which scans all the security groups of running / stopped instances and sends an email to all stakeholders on daily/weekly basis if port 22 is open for all.
This script uses SNS API calls to send an email if defined rule matches. 

This script has few prerequisites

1) Create an SNS topic and configure subscription.

Once you create SNS topic, you get an end point that you need to configure in scripts.

2) Configure IAM User / Role with required policy.
