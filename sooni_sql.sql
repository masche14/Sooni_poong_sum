create database sooni_group;

use sooni_group;

show tables;

desc bj;

select *
from bj;

select *
from february_poong;

select b.name, b.id, b.department, f.days, f.poong_sum as f_poong
from bj b
join february_poong f
	on b.id=f.id;