Create database GVols;
use GVols; 

/*==============================================================*/
/* Table: Client                                                */
/*==============================================================*/
create table Client (
   Id_Client            int                  not null,
   Nom                  varchar(254)             null,
   Prenom               varchar(254)         null,
   Adresse              varchar(254)         null,
   Email                varchar(254)         null,
   constraint PK_CLIENT primary key nonclustered (Id_Client),
   constraint AK_IDENTIFIER_1_CLIENT unique (Id_Client)
)
go

/*==============================================================*/
/* Table: Compagnie_Aerienne                                    */
/*==============================================================*/
create table Compagnie_Aerienne (
   Id_Compagnie         int                  not null,
   Nom                  varchar(250)             null,
   constraint PK_COMPAGNIE_AERIENNE primary key nonclustered (Id_Compagnie),
   constraint AK_IDENTIFIER_1_COMPAGNI unique (Id_Compagnie),
   constraint AK_IDENTIFIER_2_COMPAGNI unique (Id_Compagnie)
)
go

/*==============================================================*/
/* Table: Reservation                                           */
/*==============================================================*/
create table Reservation (
   Num_Reservation      int                  not null,
   Id_Client            int                  not null,
   id_Vol               int                  not null,
   Date                 date             null,
   constraint PK_RESERVATION primary key nonclustered (Num_Reservation)
)
go

/*==============================================================*/
/* Index: ASSOCIATION_1_FK                                      */
/*==============================================================*/
create index ASSOCIATION_1_FK on Reservation (
Id_Client ASC
)
go

/*==============================================================*/
/* Index: ASSOCIATION_2_FK                                      */
/*==============================================================*/
create index ASSOCIATION_2_FK on Reservation (
id_Vol ASC
)
go

/*==============================================================*/
/* Table: Vol                                                   */
/*==============================================================*/
create table Vol (
   id_Vol               int                  not null,
   Id_Compagnie         int                  not null,
   Date_Depart          date             null,
   Date_Arrive          date             null,
   constraint PK_VOL primary key nonclustered (id_Vol)
)
go

/*==============================================================*/
/* Index: ASSOCIATION_3_FK                                      */
/*==============================================================*/
create index ASSOCIATION_3_FK on Vol (
Id_Compagnie ASC
)
go

alter table Reservation
   add constraint FK_RESERVAT_ASSOCIATI_CLIENT foreign key (Id_Client)
      references Client (Id_Client)
go

alter table Reservation
   add constraint FK_RESERVAT_ASSOCIATI_VOL foreign key (id_Vol)
      references Vol (id_Vol)
go

alter table Vol
   add constraint FK_VOL_ASSOCIATI_COMPAGNI foreign key (Id_Compagnie)
      references Compagnie_Aerienne (Id_Compagnie)
go


-- Users --

CREATE LOGIN Utilisateur1  
    WITH PASSWORD = 'Utilisateur123';  
GO  

CREATE USER Utilisateur1 FOR LOGIN Utilisateur1;  
GO  
 
GRANT select,insert to Utilisateur1 ;  
GO 


-- Insertion --

insert into Client values(1,'Ahmed','Ben Bahadou','47 Rue el ouzani','Ahmed.Ben@gmail.com')
insert into Compagnie_Aerienne values(1,'CompanyVol')
insert into Vol values (1,1,'2020-04-27',' 2020-04-29')
insert into Reservation values(1,1,1,'2020-04-27')

-- Select From All tables --

select * from Client
select * from  Compagnie_Aerienne
select * from Vol
select * from Reservation

-- Update --
UPDATE Client
SET Nom='Salima'
WHERE Id_Client=1;

UPDATE Compagnie_Aerienne
SET Nom='VolAMC'
WHERE Id_Compagnie=1;

UPDATE Vol
SET Date_Arrive='2020-04-28'
WHERE id_Vol=1;

UPDATE Reservation
SET Date='2020-04-28'
WHERE id_Vol=1;


--Delete --

Delete From Reservation Where Num_Reservation=1;
DELETE FROM Client WHERE Id_Client=1;
DELETE FROM Vol WHERE id_Vol=1;
Delete From Compagnie_Aerienne Where Id_Compagnie=1;

