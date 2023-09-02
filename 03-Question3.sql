--Question 3: Number of CIDRs where the following value is in the asn field: "as852"
SELECT
	COUNT(*)
FROM stage_arin_net 
WHERE asn = 'as852'