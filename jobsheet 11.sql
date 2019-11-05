-- Soal no. 1
select name, database_id, create_date from sys.databases

--Soal no. 2
select object_id, name, schema_id,
       type, type_desc, create_date, modify_date
from sys.objects where type=N'U';

--Soal no. 3
select object_id, name, schema_name(schema_id) as schema_name,
       type, type_desc, create_date, modify_date
from sys.tables where type=N'U';

--Soal no. 4
select
        name as columnname, column_id, type_name(system_type_id) as data_type,
        max_length, precision, scale, collation_name
from sys.all_columns
where OBJECT_NAME(object_id) = N'Customers';

--Soal no. 5
select
       db_id(), db_name() as database_name,
       user_id(), user_name()

--Soal no. 6
select
       name, type_desc,
       object_name(object_id) as object_name,
       schema_name(schema_id) as schema_name
from sys.objects

--Soal no. 7
select
COLUMN_NAME, TABLE_NAME, TABLE_SCHEMA as SCHEMA_NAME
from INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME LIKE N'%name%'

--Soal no. 8
select
object_definition(object_id)
from sys.all_views
where object_name(object_id) = N'CustOrders'

--Soal no. 9
select session_id,
       login_time, host_name,
       language, login_name,
       date_format
from sys.dm_exec_sessions

--Soal no. 10
select
        cpu_count as [Logical CPU Count],
        hyperthread_ratio as [Hyperthread Ratio],
        cpu_count / hyperthread_ratio as [Physical CPU Count],
        physical_memory_kb / 1024 as [RAM (MB)],
        sqlserver_start_time as [Last SQL Server Start]
from sys.dm_os_sys_info

--Soal no. 11
select
       total_physical_memory_kb /1024/ 1024 as "Total RAM (GB)",
       available_page_file_kb /1024/ 1024 as "Available RAM (GB)",
       total_page_file_kb /1024/ 1024 as "Total Page File (GB)",
       available_page_file_kb /1024/ 1024 as "Available Page File (GB)",
       system_memory_state_desc as "RAM Availibility Status"
from sys.dm_os_sys_memory