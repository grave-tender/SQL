--=======================DOODLE=========
CREATE TABLE A(
    a_id number(4) primary key,
    data VARCHAR2(20)
)
;

CREATE TABLE B(
    b_id number(4) primary key,
    data VARCHAR2(20)
)
;

CREATE TABLE C(
    c_id number(4),
    data VARCHAR2(20),
    a_id number(4),
    b_id number(4),
    constraint c_a_id_fk foreign key (a_id) references A (a_id),
    constraint c_b_id_fk foreign key (b_id) references B (b_id)
)
;

DROP TABLE A;
DROP TABLE B;
DROP TABLE C;