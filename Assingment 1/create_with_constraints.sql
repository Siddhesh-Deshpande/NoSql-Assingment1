create database Assingment1_fk;
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