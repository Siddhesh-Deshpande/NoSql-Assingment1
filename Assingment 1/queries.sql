-- Queries
-- Problem 1
select r.uri 
from revisionuri as r
inner join keywords as k on k.id = r.id
group by r.id 
having 
(
    exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'infantri%') and
    exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'reinforc%') and
    exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'brigad%') and
    exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'fire%')
);

-- Problem 2
select r.uri 
from revisionuri as r
inner join keywords as k on k.id = r.id
group by r.id 
having 
(
    (exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'infantri%') and
    not exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'reinforc%') and
    not exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'brigad%') and
    not exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'fire%'))
    or 
    (not exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'infantri%') and
    exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'reinforc%') and
    not exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'brigad%') and
    not exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'fire%'))
    or 
    (not exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'infantri%') and
    not exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'reinforc%') and
    exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'brigad%') and
    not exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'fire%'))
    or 
    (not exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'infantri%') and
    not exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'reinforc%') and
    not exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'brigad%') and
    exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'fire%'))
);
-- problem 3
select r.uri 
from revisionuri as r
inner join keywords as k on k.id = r.id
group by r.id 
having 
(
    not exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'infantri%') and
    exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'reinforc%') and
    not exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'brigad%') and
    not exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'fire%')
);


-- problem 4
select r.uri
from revisionuri as r
inner join keywords as k on k.id = r.id
group by r.id 
having 
(
    exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'infantri%') and
    exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'reinforc%') and
    exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'brigad%') and
    exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'fire%')
)
ORDER BY 
(
    SELECT SUM(CASE 
                WHEN k.term LIKE 'infantri%' THEN k.score 
                WHEN k.term LIKE 'reinforc%' THEN k.score
                WHEN k.term LIKE 'brigad%' THEN k.score
                WHEN k.term LIKE 'fire%' THEN k.score
                ELSE 0
            END)
    FROM keywords k WHERE k.id = r.id
) desc;

-- problem 5
select r.uri
from revisionuri as r
inner join keywords as k on k.id = r.id
group by r.id 
having 
(
    exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'infantri%') or
    exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'reinforc%') or
    exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'brigad%') or
    exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'fire%')
)
ORDER BY 
(
    SELECT SUM(CASE 
                WHEN k.term LIKE 'infantri%' THEN k.score 
                WHEN k.term LIKE 'reinforc%' THEN k.score
                WHEN k.term LIKE 'brigad%' THEN k.score
                WHEN k.term LIKE 'fire%' THEN k.score
                ELSE 0
            END)
    FROM keywords k WHERE k.id = r.id
) desc ;

-- problem 6
select r.uri
from revisionuri as r
inner join keywords as k on k.id = r.id
group by r.id
having
(
    (
        not exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'infantri%') and
        exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'reinforc%') and
        not exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'brigad%') and
        not exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'fire%')
    ) or
    (
        exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'infantri%') and
        exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'reinforc%') and
        not exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'brigad%') and
        not exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'fire%')
    ) or
    (
        exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'infantri%') and
        exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'reinforc%') and
        exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'brigad%') and
        not exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'fire%')
    ) or
    (
        not exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'infantri%') and
        exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'reinforc%') and
        not exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'brigad%') and
        exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'fire%')
    ) or
    (
        not exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'infantri%') and
        exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'reinforc%') and
        exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'brigad%') and
        not exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'fire%')
    ) or
    (
        not exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'infantri%') and
        exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'reinforc%') and
        exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'brigad%') and
        exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'fire%')
    ) or
    (
        exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'infantri%') and
        exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'reinforc%') and
        not exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'brigad%') and
        exists(select keywords.id from keywords where keywords.id=r.id and keywords.term like 'fire%')
    )
)
ORDER BY
(
    SELECT SUM(CASE
                WHEN k.term LIKE 'reinforc%' THEN k.score
                ELSE 0
            END)
          - SUM(CASE
                WHEN k.term LIKE 'infantri%' THEN k.score
                WHEN k.term LIKE 'brigad%' THEN k.score
                WHEN k.term LIKE 'fire%' THEN k.score
                ELSE 0
            END)
    FROM keywords k WHERE k.id = r.id
) DESC;