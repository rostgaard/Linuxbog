create table Links (
ID		int auto_increment,
Bruger		varchar(50) not null,
Link		blob not null,
Beskrivelse	blob not null,
Kategori	varchar(50) not null,
primary key (ID)
);

