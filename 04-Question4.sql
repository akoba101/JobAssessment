-- Question 4: Provide list of top 10 organization names ranked in descending order of number of CIDRs

-- CTE to calculate the COUNT of cidr GROUP BY the organization name. Results are ordered by the COUNT descending and then alphabetically by organization name. Only outputs the top 10 results
WITH Top10CIDRCount AS(
	SELECT TOP 10
		sao.org_name
		,COUNT(cidr) countcidr
	FROM stage_arin_net san
	JOIN stage_arin_org sao
		ON san.org_cust_id = sao.org_id
	GROUP BY sao.org_name
	ORDER BY countcidr DESC, org_name ASC
)
--Presentation layer to show the data in the requested format: ('name 1','name 2','name 3','name 4','name 5','name 6','name 7','name 8','name 9','name 10')
SELECT CONCAT('(',STRING_AGG(CONCAT('''',org_name,''''),','),')') Top10ByCIDR
FROM Top10CIDRCount