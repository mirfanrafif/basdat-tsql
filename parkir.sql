/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     10/10/2019 3:19:55 AM                        */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('KENDARAAN') and o.name = 'FK_KENDARAA_KATEGORI__KATEGORI')
alter table KENDARAAN
   drop constraint FK_KENDARAA_KATEGORI__KATEGORI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('KENDARAAN') and o.name = 'FK_KENDARAA_KENDARAAN_USER')
alter table KENDARAAN
   drop constraint FK_KENDARAA_KENDARAAN_USER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PEMBAYARAN') and o.name = 'FK_PEMBAYAR_PEMBAYARA_USER')
alter table PEMBAYARAN
   drop constraint FK_PEMBAYAR_PEMBAYARA_USER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PEMBAYARAN') and o.name = 'FK_PEMBAYAR_PEMBAYARA_PENJAGA')
alter table PEMBAYARAN
   drop constraint FK_PEMBAYAR_PEMBAYARA_PENJAGA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PENCAIRAN') and o.name = 'FK_PENCAIRA_PENCAIRAN_BANK')
alter table PENCAIRAN
   drop constraint FK_PENCAIRA_PENCAIRAN_BANK
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PENCAIRAN') and o.name = 'FK_PENCAIRA_PENCAIRAN_USER')
alter table PENCAIRAN
   drop constraint FK_PENCAIRA_PENCAIRAN_USER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PENJAGA') and o.name = 'FK_PENJAGA_ALAMAT_JA_TEMPAT')
alter table PENJAGA
   drop constraint FK_PENJAGA_ALAMAT_JA_TEMPAT
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BANK')
            and   type = 'U')
   drop table BANK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('KATEGORI')
            and   type = 'U')
   drop table KATEGORI
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('KENDARAAN')
            and   name  = 'KATEGORI_KENDARAAN_FK'
            and   indid > 0
            and   indid < 255)
   drop index KENDARAAN.KATEGORI_KENDARAAN_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('KENDARAAN')
            and   name  = 'KENDARAAN_USER_FK'
            and   indid > 0
            and   indid < 255)
   drop index KENDARAAN.KENDARAAN_USER_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('KENDARAAN')
            and   type = 'U')
   drop table KENDARAAN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PEMBAYARAN')
            and   name  = 'PEMBAYARAN2_FK'
            and   indid > 0
            and   indid < 255)
   drop index PEMBAYARAN.PEMBAYARAN2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PEMBAYARAN')
            and   name  = 'PEMBAYARAN_FK'
            and   indid > 0
            and   indid < 255)
   drop index PEMBAYARAN.PEMBAYARAN_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PEMBAYARAN')
            and   type = 'U')
   drop table PEMBAYARAN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PENCAIRAN')
            and   name  = 'PENCAIRAN2_FK'
            and   indid > 0
            and   indid < 255)
   drop index PENCAIRAN.PENCAIRAN2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PENCAIRAN')
            and   name  = 'PENCAIRAN_FK'
            and   indid > 0
            and   indid < 255)
   drop index PENCAIRAN.PENCAIRAN_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PENCAIRAN')
            and   type = 'U')
   drop table PENCAIRAN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PENJAGA')
            and   name  = 'ALAMAT_JAGA_FK'
            and   indid > 0
            and   indid < 255)
   drop index PENJAGA.ALAMAT_JAGA_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PENJAGA')
            and   type = 'U')
   drop table PENJAGA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TEMPAT')
            and   type = 'U')
   drop table TEMPAT
go

if exists (select 1
            from  sysobjects
           where  id = object_id('"USER"')
            and   type = 'U')
   drop table "USER"
go

/*==============================================================*/
/* Table: BANK                                                  */
/*==============================================================*/
create table BANK (
   ID_BANK              int                  not null,
   NAMA_BANK            varchar(1024)        not null,
   KODE_BANK            int                  not null,
   constraint PK_BANK primary key nonclustered (ID_BANK)
)
go

/*==============================================================*/
/* Table: KATEGORI                                              */
/*==============================================================*/
create table KATEGORI (
   ID_KATEGORI          int                  not null,
   NAMA_KAKTEGORI       varchar(1024)        not null,
   HARGA                varchar(1024)        not null,
   constraint PK_KATEGORI primary key nonclustered (ID_KATEGORI)
)
go

/*==============================================================*/
/* Table: KENDARAAN                                             */
/*==============================================================*/
create table KENDARAAN (
   ID_KENDARAAN         int                  not null,
   ID_USER              int                  null,
   ID_KATEGORI          int                  null,
   MERK_KENDARAAN       varchar(1024)        not null,
   TIPE_KENDARAAN       varchar(1024)        not null,
   PLAT_NOMOR           varchar(1024)        not null,
   constraint PK_KENDARAAN primary key nonclustered (ID_KENDARAAN)
)
go

/*==============================================================*/
/* Index: KENDARAAN_USER_FK                                     */
/*==============================================================*/
create index KENDARAAN_USER_FK on KENDARAAN (
ID_USER ASC
)
go

/*==============================================================*/
/* Index: KATEGORI_KENDARAAN_FK                                 */
/*==============================================================*/
create index KATEGORI_KENDARAAN_FK on KENDARAAN (
ID_KATEGORI ASC
)
go

/*==============================================================*/
/* Table: PEMBAYARAN                                            */
/*==============================================================*/
create table PEMBAYARAN (
   ID_TRANSAKSI         int                  not null,
   ID_USER              int                  not null,
   ID_PENJAGA           int                  not null,
   TANGGAL              datetime             not null,
   constraint PK_PEMBAYARAN primary key (ID_TRANSAKSI)
)
go

/*==============================================================*/
/* Index: PEMBAYARAN_FK                                         */
/*==============================================================*/
create index PEMBAYARAN_FK on PEMBAYARAN (
ID_USER ASC
)
go

/*==============================================================*/
/* Index: PEMBAYARAN2_FK                                        */
/*==============================================================*/
create index PEMBAYARAN2_FK on PEMBAYARAN (
ID_PENJAGA ASC
)
go

/*==============================================================*/
/* Table: PENCAIRAN                                             */
/*==============================================================*/
create table PENCAIRAN (
   ID_TRANSAKSI         int                  not null,
   ID_BANK              int                  not null,
   ID_USER              int                  not null,
   TANGGAL              datetime             not null,
   constraint PK_PENCAIRAN primary key (ID_TRANSAKSI)
)
go

/*==============================================================*/
/* Index: PENCAIRAN_FK                                          */
/*==============================================================*/
create index PENCAIRAN_FK on PENCAIRAN (
ID_BANK ASC
)
go

/*==============================================================*/
/* Index: PENCAIRAN2_FK                                         */
/*==============================================================*/
create index PENCAIRAN2_FK on PENCAIRAN (
ID_USER ASC
)
go

/*==============================================================*/
/* Table: PENJAGA                                               */
/*==============================================================*/
create table PENJAGA (
   ID_PENJAGA           int                  not null,
   ID_TEMPAT            int                  null,
   NAMA_PENJAGA         varchar(1024)        not null,
   PHONE                varchar(1024)        not null,
   EMAIL                varchar(1024)        not null,
   PASSWORD             varchar(1024)        not null,
   constraint PK_PENJAGA primary key nonclustered (ID_PENJAGA)
)
go

/*==============================================================*/
/* Index: ALAMAT_JAGA_FK                                        */
/*==============================================================*/
create index ALAMAT_JAGA_FK on PENJAGA (
ID_TEMPAT ASC
)
go

/*==============================================================*/
/* Table: TEMPAT                                                */
/*==============================================================*/
create table TEMPAT (
   ID_TEMPAT            int                  not null,
   NAMA_TEMPAT          varchar(1024)        not null,
   ALAMAT               varchar(1024)        not null,
   KOTA                 varchar(1024)        not null,
   constraint PK_TEMPAT primary key nonclustered (ID_TEMPAT)
)
go

/*==============================================================*/
/* Table: "USER"                                                */
/*==============================================================*/
create table "USER" (
   ID_USER              int                  not null,
   NAMA_USER            varchar(1024)        not null,
   PHONE                varchar(1024)        not null,
   EMAIL                varchar(1024)        not null,
   PASSWORD             varchar(1024)        not null,
   constraint PK_USER primary key nonclustered (ID_USER)
)
go

alter table KENDARAAN
   add constraint FK_KENDARAA_KATEGORI__KATEGORI foreign key (ID_KATEGORI)
      references KATEGORI (ID_KATEGORI)
go

alter table KENDARAAN
   add constraint FK_KENDARAA_KENDARAAN_USER foreign key (ID_USER)
      references "USER" (ID_USER)
go

alter table PEMBAYARAN
   add constraint FK_PEMBAYAR_PEMBAYARA_USER foreign key (ID_USER)
      references "USER" (ID_USER)
go

alter table PEMBAYARAN
   add constraint FK_PEMBAYAR_PEMBAYARA_PENJAGA foreign key (ID_PENJAGA)
      references PENJAGA (ID_PENJAGA)
go

alter table PENCAIRAN
   add constraint FK_PENCAIRA_PENCAIRAN_BANK foreign key (ID_BANK)
      references BANK (ID_BANK)
go

alter table PENCAIRAN
   add constraint FK_PENCAIRA_PENCAIRAN_USER foreign key (ID_USER)
      references "USER" (ID_USER)
go

alter table PENJAGA
   add constraint FK_PENJAGA_ALAMAT_JA_TEMPAT foreign key (ID_TEMPAT)
      references TEMPAT (ID_TEMPAT)
go

