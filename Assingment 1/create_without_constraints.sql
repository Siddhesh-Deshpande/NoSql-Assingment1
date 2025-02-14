create database Assingment1_withoutfk;
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