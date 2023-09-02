-- Question 5: Count total number of IPs for the following organization name "bell dsl internet ontario"

-- CTE that separates the subnet mask from the root IP address for the organization 'bell dsl internet ontario'
WITH BellOntSubnet AS(
	SELECT
		LEFT(cidr,CHARINDEX('/',cidr)-1) IPAddress
		,CAST(RIGHT(cidr,LEN(cidr)-CHARINDEX('/',cidr)) AS INT) subnetmask
	FROM stage_arin_net san
	JOIN stage_arin_org sao
		ON san.org_cust_id = sao.org_id
	WHERE sao.org_name = 'bell dsl internet ontario'
)
-- Simple aggregation on the number of IPs per CIDR from the previous CTE. Equation to calculate IP is: 2^(32-x) where x is the subnet mask
SELECT
	SUM(POWER(2,32-subnetmask))
FROM BellOntSubnet
