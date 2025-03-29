SELECT 
    YEARWEEK(l.created_at) AS week_number,
    c.type AS course_type,
    COUNT(l.id) AS leads_count
FROM leads l
JOIN courses c ON l.course_id = c.id
GROUP BY week_number, course_type
ORDER BY week_number, course_type;


SELECT d.country_name, COUNT(l.id) AS won_flex_leads
FROM leads l
JOIN users u ON l.user_id = u.id
JOIN domains d ON u.domain_id = d.id
JOIN courses c ON l.course_id = c.id
WHERE l.status = 'WON'
AND c.type = 'FLEX'
AND l.created_at >= '2024-01-01'
GROUP BY d.country_name
ORDER BY won_flex_leads DESC;


SELECT u.email, l.id, l.lost_reason
FROM leads l
JOIN users u ON l.user_id = u.id
JOIN courses c ON l.course_id = c.id
WHERE l.status = 'LOST'
AND c.type = 'FLEX'
AND l.created_at >= '2024-01-07'
ORDER BY l.id;
