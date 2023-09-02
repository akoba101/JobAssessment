--Question 2: Number of CIDRs for the following org_cust_id: "bdio"
SELECT
	COUNT(*)
FROM stage_arin_net
WHERE org_cust_id = 'bdio'