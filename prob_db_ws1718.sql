-- Probeklausur Datenbanken - WS 2017/2018
drop sequence sq_Artikelnr;

drop sequence sq_Bearbeitungsnr;

alter table Reklamation
drop constraint fk_Reklamation_Kunde;

alter table ReklamationPosition
drop constraint fk_ReklamPos_Reklamation;

alter table ReklamationPosition
drop constraint fk_ReklamPos_Artikel;

alter table ReklamationPosition
drop constraint fk_ReklamPos_ReklamBearbeitung;

alter table ReklamationBearbeitung
drop constraint fk_ReklamBearb_Mitarbeiter;

alter table Mitarbeiter
drop primary key cascade;
 
alter table Kunde
drop primary key cascade;
 
alter table Artikel
drop primary key cascade;
 
alter table Reklamation
drop primary key cascade;
 
alter table ReklamationPosition
drop primary key cascade;

alter table ReklamationBearbeitung
drop primary key cascade;

drop table Mitarbeiter;
drop table Kunde;
drop table Artikel;
drop table Reklamation;
drop table ReklamationPosition;
drop table ReklamationBearbeitung;

create table Mitarbeiter (
	Mitarbeiternr int not null,
	Nachname varchar2(50) not null,
	Vorname varchar2(50) not null,
	Gehalt number not null,
	Geburtstag date not null,	
	constraint pk_Mitarbeiter primary key (MitarbeiterNr)
);

create table Kunde (
	Kundennr int not null,
	Nachname varchar2(50) not null,
	Vorname varchar2(50) not null,
	KundeSeit date not null,	
	constraint pk_Kunde primary key (Kundennr)
);

create table Artikel (
	Artikelnr int not null,
	Bezeichnung varchar2(30) not null,
	Preis number not null,	
	constraint pk_Artikel primary key (Artikelnr)
);

create table Reklamation (
	Reklamationnr int not null,
	Kundennr int not null,
	Datum date not null,	
	constraint pk_Reklamation primary key (Reklamationnr),
	constraint fk_Reklamation_Kunde foreign key (Kundennr) references Kunde (Kundennr)
);

create table ReklamationBearbeitung (
	Bearbeitungsnr int not null,
	Mitarbeiternr int not null,
	Diagnose varchar2(2000),
	Datum date not null,	
	constraint pk_ReklamationBearbeitung primary key (Bearbeitungsnr),
	constraint fk_ReklamBearb_Mitarbeiter foreign key (Mitarbeiternr) references Mitarbeiter (Mitarbeiternr)
);


REM INSERTING into mitarbeiter
insert into mitarbeiter (Mitarbeiternr, Nachname, Vorname, Gehalt, Geburtstag) values (11,'Dallmann','Peter',1500,to_date('11.03.1978','DD.MM.YYYY'));
insert into mitarbeiter (Mitarbeiternr, Nachname, Vorname, Gehalt, Geburtstag) values (12,'Hahn','Luise',1850,to_date('22.07.1965','DD.MM.YYYY'));
insert into mitarbeiter (Mitarbeiternr, Nachname, Vorname, Gehalt, Geburtstag) values (13,'Dallmeyer','Claudia',1800,to_date('27.02.1980','DD.MM.YYYY'));
insert into mitarbeiter (Mitarbeiternr, Nachname, Vorname, Gehalt, Geburtstag) values (14,'Martin','Frank',1400,to_date('14.04.1995','DD.MM.YYYY'));
insert into mitarbeiter (Mitarbeiternr, Nachname, Vorname, Gehalt, Geburtstag) values (15,'Maschmeyer','Karsten',1980,to_date('01.12.1960','DD.MM.YYYY'));
insert into mitarbeiter (Mitarbeiternr, Nachname, Vorname, Gehalt, Geburtstag) values (16,'Huhn','Elvira',2200,to_date('26.08.1955','DD.MM.YYYY'));

REM INSERTING into kunde
insert into kunde (Kundennr, Nachname, Vorname, KundeSeit) values (1,'Ober','Helge',to_date('01.01.2010','DD.MM.YYYY'));
insert into kunde (Kundennr, Nachname, Vorname, KundeSeit) values (2,'Reller','Julia',to_date('30.01.2014','DD.MM.YYYY'));
insert into kunde (Kundennr, Nachname, Vorname, KundeSeit) values (3,'Ringhoff','Hilde',to_date('28.04.2009','DD.MM.YYYY'));
insert into kunde (Kundennr, Nachname, Vorname, KundeSeit) values (4,'Otto','Stefan',to_date('15.09.2010','DD.MM.YYYY'));
insert into kunde (Kundennr, Nachname, Vorname, KundeSeit) values (5,'Kapp','Albert',to_date('19.11.2008','DD.MM.YYYY'));
insert into kunde (Kundennr, Nachname, Vorname, KundeSeit) values (6,'Fischer','Franz',to_date('10.08.2010','DD.MM.YYYY'));
insert into kunde (Kundennr, Nachname, Vorname, KundeSeit) values (7,'Weber','Heidi',to_date('19.11.2010','DD.MM.YYYY'));
insert into kunde (Kundennr, Nachname, Vorname, KundeSeit) values (8,'Bauer','Anne',to_date('13.12.2010','DD.MM.YYYY'));

REM INSERTING into ARTIKEL
insert into Artikel (Artikelnr, Bezeichnung, Preis) values (4700,'Motor Spinmaxx 500',99.9);
insert into Artikel (Artikelnr, Bezeichnung, Preis) values (4701,'Getriebe Torquemaxx 400',80.5);
insert into Artikel (Artikelnr, Bezeichnung, Preis) values (4702,'Motor Powerturn 250',82.6);
insert into Artikel (Artikelnr, Bezeichnung, Preis) values (4703,'Pumpe Submerge 120',50.45);
insert into Artikel (Artikelnr, Bezeichnung, Preis) values (4704,'Controller Speedy 100',65.6);

REM INSERTING into Reklamation
insert into Reklamation (Reklamationnr, Kundennr, Datum) values (100,2,to_date('12.06.2014','DD.MM.YYYY'));
insert into Reklamation (Reklamationnr, Kundennr, Datum) values (101,2,to_date('12.07.2014','DD.MM.YYYY'));
insert into Reklamation (Reklamationnr, Kundennr, Datum) values (102,2,to_date('12.06.2015','DD.MM.YYYY'));
insert into Reklamation (Reklamationnr, Kundennr, Datum) values (103,1,to_date('13.07.2015','DD.MM.YYYY'));
insert into Reklamation (Reklamationnr, Kundennr, Datum) values (104,4,to_date('28.08.2016','DD.MM.YYYY'));

REM INSERTING into ReklamationPosition
insert into ReklamationPosition (Reklamationnr, Artikelnr, Menge, Fehlerbeschreibung) values (101, 4704, 3, 'Controller bleiben stromlos.');
insert into ReklamationPosition (Reklamationnr, Artikelnr, Menge, Fehlerbeschreibung) values (101, 4703, 1, 'Pumpe schaltet nicht mehr ab.');
insert into ReklamationPosition (Reklamationnr, Artikelnr, Menge, Fehlerbeschreibung) values (102, 4700, 5, 'Motoren drehen schlecht an.');
insert into ReklamationPosition (Reklamationnr, Artikelnr, Menge, Fehlerbeschreibung) values (103, 4702, 1, 'Motor dreht deutlich zu langsam.');
insert into ReklamationPosition (Reklamationnr, Artikelnr, Menge, Fehlerbeschreibung) values (104, 4704, 2, 'Controller steuern nicht immer.');
commit;
