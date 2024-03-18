use sooni_group;

# 신규방식 테스트 - 2024.03.18

# 일일 수익 데이터 조회
select count(*)
from daily_income;

# 특정 기간 내 수익 데이터 총합 도출
select id, sum(poong) as poong_sum
from daily_income
where date between '2024-02-08' and '2024-03-07'
group by id;

# bj 테이블과 join 하여 내용 확인
select b.*, d.poong_sum as f_income
from bj b
left join (select id, sum(poong) as poong_sum
from daily_income
where date between '2024-02-08' and '2024-03-07'
group by id) d
on b.id=d.id;

