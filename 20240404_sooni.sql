use sooni_group;

# 비제이 id 컬럼 유니크 지정
alter table bj modify column id varchar(20) unique;

desc bj;

# 비제이 명단 조회
select * from bj;

# daily_income 테이블 date 컬럼 날짜 형식 지정
alter table daily_income modify column id varchar(30);
alter table daily_income modify column date date;
alter table daily_income add unique (id, date);

desc daily_income;

# 일일 수익 데이터 조회
select *
from daily_income;

# bj 테이블과 join 하여 내용 확인
select b.*, d.poong_sum as f_income
from bj b
left join (select id, sum(poong) as poong_sum
from daily_income
where date between '2024-02-08' and '2024-03-07'
group by id) d
on b.id=d.id
order by department, f_income desc;

select *
from daily_income;

# 이번달 수익 데이터, 지난 달 수익 데이터 차이 가상 테이블 생성
with poong_insight as (
select b.name, b.id, b.department, n.n_poong, ifnull(p.p_poong, 0) as p_poong, n.n_poong - ifnull(p.p_poong, 0) as 'p/m'
from bj b 
left join (select id, sum(poong) as n_poong
from daily_income
where date >= '2024-03-08'
group by id) n
on b.id = n.id
left join (select id, sum(poong) as p_poong
from daily_income
where date between '2024-02-08' and '2024-03-07'
group by id) p
on b.id = p.id
order by department)

select *
from poong_insight;

# 누락된 값 찾기
select date, count(*)
from daily_income
group by date;

select b.name, d.*
from bj b
left join (
select *
from daily_income
where date = '240402') d
on b.id=d.id;

select name, id
from bj
where name like '%민서율%';

-- insert into daily_income values('b24ip7','2024-04-02', 0);