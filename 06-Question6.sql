--Question 6: Provide list of organization names with greater than 100 registered CIDRs. The list should be ranked in descending order of average IP count per CIDR.

-- This CTE calculates the number of IP addresses per CIDR (along with the organization name) using the formula from the previous question (#5)
WITH IPCountPerCIDR AS (
	SELECT
		sao.org_name
		,CAST(POWER(2,32-CAST(RIGHT(cidr,LEN(cidr)-CHARINDEX('/',cidr)) AS INT)) AS DECIMAL) IPCount
	FROM stage_arin_net san
	JOIN stage_arin_org sao
		ON san.org_cust_id = sao.org_id
)
-- This CTE aggregates the COUNT of CIDR and the AVG of the IP Count from the previous CTE based off the organizations name
, CountAvgCIDR AS(
	SELECT 
		org_name
		,COUNT(*) CIDRCount
		,AVG(IPCount) AvgIPPerCIDR
	FROM IPCountPerCIDR
	GROUP BY org_name
	HAVING COUNT(*) > 100
)
-- Presentation layer that shows the results ordered by the average IP count per CIDR (DESC) and the following format: ('name 1','name 2','name 3', ...)
SELECT CONCAT('(',OrgList,')')
FROM (
	SELECT STRING_AGG(CONCAT('''',org_name,''''),',')
	WITHIN GROUP(ORDER BY AvgIPPerCIDR DESC) AS OrgList
	FROM CountAvgCIDR 
) OrgAggregation