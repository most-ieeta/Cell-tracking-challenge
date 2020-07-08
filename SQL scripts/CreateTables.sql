-- drop table FluoN2DHSIM;
create table FluoN2DHSIM (time int, name varchar(50), object geometry);
alter table FluoN2DHSIM add constraint PK_FluoN2DHSIM primary key (time, name);

-- drop table FluoN2DLHeLa;
create table FluoN2DLHeLa (time int, name varchar(50), object geometry);
alter table FluoN2DLHeLa add constraint PK_FluoN2DLHeLa primary key (time, name);

-- drop table DICC2DHHeLa;
create table DICC2DHHeLa (time int, name varchar(50), object geometry);
alter table DICC2DHHeLa add constraint PK_DICC2DHHeLa primary key (time, name);

-- drop table PhCC2DHU373;
create table PhCC2DHU373 (time int, name varchar(50), object geometry);
alter table PhCC2DHU373 add constraint PK_PhCC2DHU373 primary key (time, name);

-- drop table FluoN2DHGOWT1;
create table FluoN2DHGOWT1 (time int, name varchar(50), object geometry);
alter table FluoN2DHGOWT1 add constraint PK_FluoN2DHGOWT1 primary key (time, name);

-- drop table FluoC2DLMSC;
create table FluoC2DLMSC (time int, name varchar(50), object geometry);
alter table FluoC2DLMSC add constraint PK_FluoC2DLMSC primary key (time, name);

-- drop table PhCC2DLPSC;
create table PhCC2DLPSC (time int, name varchar(50), object geometry);
alter table PhCC2DLPSC add constraint PK_PhCC2DLPSC primary key (time, name);

-- drop table BFC2DLHSC;
create table BFC2DLHSC (time int, name varchar(50), object geometry);
alter table BFC2DLHSC add constraint PK_BFC2DLHSC primary key (time, name);

-- drop table BFC2DLMuSC;
create table BFC2DLMuSC (time int, name varchar(50), object geometry);
alter table BFC2DLMuSC add constraint PK_BFC2DLMuSC primary key (time, name);
