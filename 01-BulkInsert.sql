/*
- Purpose of this script is to BULK INSERT all required files into SQL Server (2022) for the purpose of analysis
- Files for this project have been stored on a local share folder with the following path:
    \\winservfiles\usershares$\Projects\InterviewAssessment\CXThink
- All files have headers - FIRSTROW =2
- Datatype lengths estimated based off a preview in VSCode
*/


CREATE DATABASE JobAssessment;
GO
USE JobAssessment;
GO


/*
Network Data Table - stage_arin_net
• net_id: Network identifier, unique (text)
• net_name: Network Name, not unique (text)
• cidr: CIDR of network. IE IP range of given network, unique (text)
• net_range: First and last IP of network separated by “–“, (text)
• net_type: Type of network. Reassigned is customer and direct allocation is organization, (text)
• asn: Autonomous system number(s) for the network. Can be multiple per network (text)
• org_cust_id: Identifier for Organization or customer that owns the network. Not unique (text)
*/

--DROP TABLE stage_arin_net
--GO
CREATE TABLE stage_arin_net(
	net_id VARCHAR(50)
	,net_name VARCHAR(50)
	,cidr VARCHAR(50)
	,net_range VARCHAR(50)
	,net_type VARCHAR(50)
	,asn VARCHAR(100)
	,org_cust_id VARCHAR(50)
);
GO
BULK INSERT stage_arin_net
	FROM '\\winservfiles\usershares$\Projects\InterviewAssessment\CXThink\arin_net.tsv'
	WITH 	
    (
    FIRSTROW = 2,
    FIELDTERMINATOR = '\t',  --TSV field delimiter
    ROWTERMINATOR = '0x0a',   --Use to shift the control to next row
    --ERRORFILE = '\\winservfiles\usershares$\Projects\InterviewAssessment\CXThink\err_log_arin_net.tsv',
    TABLOCK
);
GO

/*
Organization Data - stage_arin_org
• org_id: Organization identifier, unique (text)
• org_name: Organization Name, not unique (text)
*/

--DROP TABLE stage_arin_org
--GO
CREATE TABLE stage_arin_org(
	org_id VARCHAR(25)
	,org_name VARCHAR(100)
);
GO
BULK INSERT stage_arin_org
	FROM '\\winservfiles\usershares$\Projects\InterviewAssessment\CXThink\arin_org.tsv'
	WITH 	
    (
    FIRSTROW = 2,
    FIELDTERMINATOR = '\t',  --TSV field delimiter
    ROWTERMINATOR = '0x0a',   --Use to shift the control to next row
    --ERRORFILE = '\\winservfiles\usershares$\Projects\InterviewAssessment\CXThink\err_log_arin_org.tsv',
    TABLOCK
);
GO

/*
Customer Data - stage_arin_cust
• cust_id: Customer identifier, unique (text)
• cust_name: Customer Name, not unique (text)
*/

--DROP TABLE stage_arin_cust;
--GO
CREATE TABLE stage_arin_cust(
	cust_id VARCHAR(10)
	,cust_name VARCHAR(100)
);
GO
BULK INSERT stage_arin_cust
	FROM '\\winservfiles\usershares$\Projects\InterviewAssessment\CXThink\arin_cust.tsv'
	WITH 	
    (
    FIRSTROW = 2,
    FIELDTERMINATOR = '\t',  --TSV field delimiter
    ROWTERMINATOR = '0x0a',   --Use to shift the control to next row
    --ERRORFILE = '\\winservfiles\usershares$\Projects\InterviewAssessment\CXThink\err_log_arin_cust.tsv',
    TABLOCK
);