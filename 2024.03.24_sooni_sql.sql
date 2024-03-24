use sooni_group;

# 신규방식 테스트 - 2024.03.18

# 일일 수익 데이터 조회
select *
from daily_income;

# 총 데이터 개수 조회
select count(*)
from daily_income;

# 특정 기간 내 비제이별  수익 데이터 총합 도출
select id, sum(poong) as poong_sum
from daily_income
where date between '2024-02-08' and '2024-03-07'
group by id;

# bj 테이블과 join 하여 내용 확인

select date(now());

select b.*, d.poong_sum as f_income
from bj b
left join (select id, sum(poong) as poong_sum
from daily_income
where date between '2024-02-08' and '2024-03-07'
group by id) d
on b.id=d.id
order by department, f_income desc;

select *
from daily_income
where date = '2024-03-19';

# 이번달 수익 데이터, 지난 달 수익 데이터 차이 가상 테이블 생성
with poong_insight as (
select b.*, n.n_poong, p.p_poong, n.n_poong - p.p_poong as 'p/m'
from bj b 
, (select id, sum(poong) as n_poong
from daily_income
where date >= '2024-03-08'
group by id) n
, (select id, sum(poong) as p_poong
from daily_income
where date between '2024-02-08' and '2024-03-07'
group by id) p
where b.id = n.id and b.id = p.id
order by department)

select * 
from poong_insight;