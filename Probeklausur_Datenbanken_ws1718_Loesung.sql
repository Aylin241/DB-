-- Aufgabe 1 a)
-- unter dem letzten Create Table Statement und über dem ersten Insert Statement
create table reklamationposition (
    reklamationnr int not null,
    artikelnr int not null,
    menge int not null,
    fehlerbeschr varchar2(2000),
    bearbeitungsnr int,
    bemerkung varchar2(500),
    constraint pk_reklamationspos primary key (reklamationnr, artikelnr),
    constraint fk_reklampos_reklamation foreign key (reklamationnr) references reklamation (reklamationnr),
    constraint fk_reklampos_artikel foreign key (artikelnr) references artikel (artikelnr),
    constraint fk_reklampos_reklambearbeit foreign key (bearbeitungsnr) references reklamationbearbeitung (bearbeitungsnr)
);

alter table kunde
add constraint c_kundennr check (kundennr > 0);

alter table mitarbeiter
add constraint c_mitarbeiternr check (mitarbeiternr > 10);

-- Aufgabe 1 a4)
@'C:\temp\script.sql'

-- Aufgabe 1 b1)
create sequence sq_artikelnr 
start with 4711 increment by 2;

create or replace trigger artikel_i
before insert on artikel
for each row
begin
    :new.artikelnr := sq_artikelnr.nextval;
end;
/

-- Aufgabe 1 b2)
create sequence sq_bearbeitungsnr 
start with 1000;

create or replace trigger reklambearbeitung_i
before insert on reklamationbearbeitung
for each row
begin
    :new.bearbeitungsnr := sq_bearbeitungsnr.nextval;
end;
/

-- Aufgabe 1 c)
insert into reklamationbearbeitung (mitarbeiternr, datum) values (16, sysdate);
insert into Reklamationposition (reklamationnr, artikelnr, menge, bearbeitungsnr, fehlerbeschr) values (100, 4701, 1, 1000, 'Der Motor dreht sicht nicht mehr.');

insert into reklamation (reklamationnr, kundennr, datum) values (105, 1, sysdate-1);
insert into Reklamationposition (reklamationnr, artikelnr, menge, fehlerbeschr) values (105, 4703, 5, 'Pumpe baut keinen Druck auf.');
commit;

-- Aufgabe 1 d1)
select *
from kunde
where nachname like 'O%'
order by kundeseit desc;

-- Aufgabe 1 d2)
select distinct a.kundennr, a.nachname
from kunde a
inner join reklamation b
on a.kundennr = b.kundennr
inner join Reklamationposition c
on b.reklamationnr = c.reklamationnr
where c.bearbeitungsnr is not null;

-- Aufgabe 1 d3)
select round(avg(gehalt), 2) avg_gehalt
from mitarbeiter;

-- Aufgabe 1 d4)
select artikelnr
from Reklamationposition
group by artikelnr
having sum(menge) = (select min(sum(menge))
                    from Reklamationposition
                    group by artikelnr);
           
-- Aufgabe 1 d5)
select nachname, vorname, gehalt
from mitarbeiter
where gehalt = (select max(gehalt)
                from mitarbeiter);
                
-- Aufgabe d6)
select *
from kunde
where kundennr not in (select kundennr 
                        from reklamation);

-- Aufgabe 1 e)
select grantee, Privilege
from All_Tab_Privs
where table_name = 'SALGRADE' and table_schema = 'MEURER';

select *
from User_Role_Privs;
-- Die Rechte wurden den Rollen Public und FH_TRIER gegeben. Da ich in beiden Rollen Mitglied bin, erbe ich auch diese Berechtigungen.

-- Aufgabe 1 f)
create or replace procedure p_kundenreklam (kundennr_in in int)
is
begin
    for rec_i in (select b.artikelnr, b.menge
                    from reklamation a
                    inner join reklamationposition b
                    on a.reklamationnr = b.reklamationnr
                    where a.kundennr = kundennr_in)
    loop
        Dbms_Output.Put_Line('Artikelnr:' || rec_i.artikelnr || '  Menge: ' || rec_i.menge);
    end loop;
end;
/

exec p_kundenreklam(1);

-- Aufgabe 1 g)
update mitarbeiter
set gehalt = gehalt*1.1
where lower(Nachname) like '%e%';
