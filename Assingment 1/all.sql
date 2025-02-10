create table keywords(
    id int not null,
    term text not null,
    score real not null,
    primary key(id,term)
);
create table revisionuri(
    id int not null,
    uri text not null,
    primary key(id)
);
-- The above schema is without fk constraints.
-- The following is used to view the executino time for each query
\timing
\copy keywords from '/home/siddhesh/Documents/Nosql Assingment 1/Wikipedia-EN-20120601_KEYWORDS.TSV' DELIMITER E'\t' CSV ENCODING 'UTF8';
\copy revisionuri from '/home/siddhesh/Documents/Nosql Assingment 1/Wikipedia-EN-20120601_REVISION_URIS.TSV' DELIMITER E'\t' CSV ENCODING 'UTF8';

-- now we introduce fk constraints in a new database
create table revisionuri(
    id int not null,
    uri text not null,
    primary key(id)
);
create table keywords(
    id int not null,
    term text not null,
    score real not null,
    primary key(id,term),
    constraint id_constraint foreign key (id)
    references revisionuri(id)
);
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
order by 
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





