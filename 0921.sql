-- �������� ������ ������ ���ǻ� �̸� ���
select publisher from customer cs, orders os, book bs
where cs.custid=os.custid and os.bookid=bs.bookid
and name like '������';

-- �������� ������ ������ ���ǻ�� ���� ���ǻ翡�� ������ ������ ���� �̸�
select name from customer cs, orders os, book bs
where cs.custid=os.custid and os.bookid=bs.bookid
and name not like '������'
and publisher in(
    select publisher from customer cs, orders os, book bs
    where cs.custid=os.custid and os.bookid=bs.bookid
    and name like '������'
);

-- �� �� �̻��� ���� �ٸ� ���ǻ翡�� ������ ������ ���� �̸�
select cs.name from customer cs
where cs.custid in (
    select os.custid
    from orders os, customer cs, book bs
    where os.bookid = bs.bookid
    group by os.custid
    having count(distinct bs.publisher) >= 2
);

select name
from customer cm
where(select count(distinct publisher) from customer c, orders o, book b
where c.custid = o.custid and o.bookid = b.bookid
and name like cm.name)>=2;

-- ��ü ���� 30%�̻��� ������ ����
select bookname from book bm
where (select count(b.bookid) from book b, orders o
        where b.bookid = o.bookid and b.bookid = bm.bookid)
        >= (select count(*) from customer)*0.3;
        
-- ���ο� ����('����������', '���ѹ̵��', 10000��)�� ���缭���� �԰�Ǿ���.
insert into book
values(15, '����������', '���ѹ̵��', 10000);

-- '���ڳ���'���� ������ ������ �����Ͻÿ�
delete from book
where publisher='���ڳ���';

-- '�س�'���� ������ ������ �����ؾ� �Ѵ�. ������ �� �� ��� ���� �����غ���
delete from book
where publisher='�س�';

-- ���ǻ� ���ѹ̵� �������ǻ�� �̸��� �ٲپ���.
update book
set publisher='�������ǻ�'
where publisher='���ѹ̵��';
 
-- abs: ���� ���ϴ� �Լ�       
-- 78�� -78�� ������ ���Ͻÿ�
select abs(-78), abs(+78)
from Dual;

-- 4.875�� �Ҽ� ù° �ڸ����� �ݿø��� ���� ���Ͻÿ�
select round(4.875, 1)
from Dual;

-- ���� ��� �ֹ� �ݾ��� �� �� ������ �ݿø��� ���� ���Ͻÿ�
select custid "����ȣ", round(sum(saleprice)/count(*), -2) "��� �ݾ�"
from orders
group by custid;

-- ������ '�ظ�����'�� ���Ե� ������ '�����Ʈ'�� �����Ͽ� ���������� ����Ͻÿ�
-- ���� book ���̺��� ���������͸� �����ϸ� �� �˴ϴ�.
select bookid, replace(bookname, '�ظ�����', '�����Ʈ') bookname, publisher, price
from book;

-- ���ǻ簡 '�س�'�� �������� ���� ���� ����Ʈ ���� ����Ͻÿ�
select bookname "������", length(bookname) ���ڼ�, lengthb(bookname) ����Ʈ��
from book where publisher like '�س�';

-- �� �߿��� ���� ������ ���� ����� �� ������ ������ �ο� ���� ����Ͻÿ�.
select substr(name, 1, 1)"����", count(*) "�ο���" from customer
group by substr(name, 1,1);

-- ������ �ֹ�Ȯ������ �ֹ��Ϸκ��� 10�� ���̴�. �ֹ���ȣ, �ֹ���, �ֹ�Ȯ������ ����Ͻÿ�.
select orderid �ֹ���ȣ, orderdate �ֹ���, orderdate+10 �ֹ�Ȯ����
from orders;

-- 2023/08/23�� �ֹ� ���� �ֹ���ȣ, �ֹ���, ����. �������� ��� ����Ͻÿ�.
-- ��, �ֹ����� "yyyy-mm-dd"�� ���� �������� ǥ���Ͻÿ�.
select orderid �ֹ���ȣ,to_char(orderdate, 'yyyy-mm-dd') �ֹ���, name ����, bookname ������
from orders, book, customer
where orderdate = to_date('20230828','yyyymmdd') 
and orders.bookid = book.bookid 
and orders.custid = customer.custid;

-- DB������ ������ ��¥�� �ð� ������ ����Ͻÿ�
-- ���� ��ȯ�� ��¥�� ������ ������(�⵵ 4�ڸ�/ �� 2�ڸ�/ �� 2�ڸ� ������ ����, ��:��:��) 
-- ��¥�� �ð� 2������ ��� ����Ͻÿ�.
select sysdate ������Ⱥ�Ȱ�, to_char(sysdate, 'yyyy/mm/dd dy hh24:mi:ss') �������ĳ�¥�׽ð� from dual;