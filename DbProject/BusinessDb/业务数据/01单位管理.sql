 CREATE TABLE T_Unit
(
   num                  int                  null,
   UnitID               varchar(50)          not null,
   UnitName             varchar(50)          not null,
   status				int,
   remark             VARCHAR(200),
   constraint PK_T_Unit primary key (UnitID)
)

