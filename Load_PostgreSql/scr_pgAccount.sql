/* !!! ��� ��� POSTGRES, ��������� ���� !!!���������!!!
UPDATE ObjectLink set ChildObjectId = null where DescId = zc_ObjectLink_Account_AccountGroup();
UPDATE ObjectLink set ChildObjectId = null where DescId = zc_ObjectLink_Account_AccountDirection();
UPDATE ObjectLink set ChildObjectId = null where DescId = zc_ObjectLink_Account_InfoMoneyDestination();
UPDATE ObjectLink set ChildObjectId = null where DescId = zc_ObjectLink_Account_InfoMoney();
*/

drop table dba._pgAccount;

create table dba._pgAccount (Id integer not null default autoincrement, ObjectCode Integer not null, Name1 TVarCharMedium not null, Name2 TVarCharMedium not null, Name3 TVarCharMedium not null, Id1_Postgres integer null, Id2_Postgres integer null, Id3_Postgres integer null, PRIMARY KEY (ObjectCode));

insert into dba._pgAccount (ObjectCode, Name1, Name2, Name3)

select '10101', '����������� ������', '���������������� ��', '�������� ��������' union all
select '10102', '����������� ������', '���������������� ��', '����������� ������' union all
select '10103', '����������� ������', '���������������� ��', '����������� �������������' union all
select '10104', '����������� ������', '���������������� ��', '����������� ����������' union all
select '10105', '����������� ������', '���������������� ��', '������ �������� ��-��' union all
select '10201', '����������� ������', '���������������� ��', '�������� ��������' union all
select '10202', '����������� ������', '���������������� ��', '����������� ������' union all
select '10203', '����������� ������', '���������������� ��', '����������� �������������' union all
select '10204', '����������� ������', '���������������� ��', '����������� ����������' union all
select '10205', '����������� ������', '���������������� ��', '������ �������� ��-��' union all
select '10301', '����������� ������', '������������ ����������', '������������ ����������' union all
select '10401', '����������� ������', '���', '���' union all
select '20101', '������', '�� ������� ��', '���������' union all
select '20102', '������', '�� ������� ��', '������' union all
select '20103', '������', '�� ������� ��', '������ ���������' union all
select '20104', '������', '�� ������� ��', '�����������' union all
select '20201', '������', '�� ������� ', '������ �����' union all
select '20202', '������', '�� ������� ', '������ �����' union all
select '20203', '������', '�� ������� ', '�������� � �������' union all
select '20204', '������', '�� ������� ', '������ ���' union all
select '20205', '������', '�� ������� ', '���' union all
select '20206', '������', '�� ������� ', '������ ���������' union all
select '20207', '������', '�� ������� ', '�����������' union all
select '20301', '������', '�� ��������', '������ �����' union all
select '20401', '������', '�� ������������', '������ �����' union all
select '20402', '������', '�� ������������', '������ �����' union all
select '20403', '������', '�� ������������', '������ ���������' union all
select '20404', '������', '�� ������������', '������������� ������������' union all
select '20405', '������', '�� ������������', '�����������' union all
select '20501', '������', '���������� (��)', '�������� � �������' union all
select '20502', '������', '���������� (��)', '������ ���' union all
select '20503', '������', '���������� (��)', '���' union all
select '20601', '������', '���������� (�����������)', '������ �����' union all
select '20602', '������', '���������� (�����������)', '������ ���������' union all
select '20603', '������', '���������� (�����������)', '���������' union all
select '20604', '������', '���������� (�����������)', '������' union all
select '20701', '������', '�� ��������', '�������� � �������' union all
select '20702', '������', '�� ��������', '������ ���' union all
select '20703', '������', '�� ��������', '���' union all
select '20704', '������', '�� ��������', '������ ���������' union all
select '20705', '������', '�� ��������', '���������' union all
select '20706', '������', '�� ��������', '������' union all
select '20801', '������', '�� ��������', '������ �����' union all
select '20802', '������', '�� ��������', '������ ���������' union all
select '20803', '������', '�� ��������', '���������' union all
select '20804', '������', '�� ��������', '������' union all
select '20901', '������', '��������� ����', '��������� ����' union all
select '30101', '��������', '���������� ', '������ �����' union all
select '30102', '��������', '���������� ', '������ �����' union all
select '30103', '��������', '���������� ', '�������� � �������' union all
select '30104', '��������', '���������� ', '������ ���' union all
select '30105', '��������', '���������� ', '���' union all
select '30106', '��������', '���������� ', '��������� ����' union all
select '30107', '��������', '���������� ', '������ ���������' union all
select '30108', '��������', '���������� ', '���������' union all
select '30109', '��������', '���������� ', '������' union all
select '30110', '��������', '���������� ', '�����������' union all
select '30201', '��������', '���� ��������', '����' union all
select '30202', '��������', '���� ��������', '���� ' union all
select '30203', '��������', '���� ��������', '�����' union all
select '30204', '��������', '���� ��������', '�������' union all
select '30301', '��������', '������ ���������������', '������ ���������������' union all
select '30401', '��������', '������ ��������', '������ ������' union all
select '30402', '��������', '������ ��������', '��������' union all
select '30403', '��������', '������ ��������', '�����' union all
select '30501', '��������', '���������� (����������� ����)', '������ �����' union all
select '30502', '��������', '���������� (����������� ����)', '������ �����' union all
select '30503', '��������', '���������� (����������� ����)', '�������� � �������' union all
select '30504', '��������', '���������� (����������� ����)', '������ ���' union all
select '30505', '��������', '���������� (����������� ����)', '���' union all
select '30506', '��������', '���������� (����������� ����)', '��������� ����' union all
select '30507', '��������', '���������� (����������� ����)', '������ ���������' union all
select '30508', '��������', '���������� (����������� ����)', '����������������' union all
select '30601', '��������', '���������� (���������, �����)', '������ �����' union all
select '30602', '��������', '���������� (���������, �����)', '������ �����' union all
select '30603', '��������', '���������� (���������, �����)', '�������� � �������' union all
select '30604', '��������', '���������� (���������, �����)', '������ ���' union all
select '30605', '��������', '���������� (���������, �����)', '���' union all
select '30606', '��������', '���������� (���������, �����)', '��������� ����' union all
select '30607', '��������', '���������� (���������, �����)', '������ ���������' union all
select '30608', '��������', '���������� (���������, �����)', '���������' union all
select '30609', '��������', '���������� (���������, �����)', '������' union all
select '30701', '��������', '������� ����������', '������ �����' union all
select '30702', '��������', '������� ����������', '���������' union all
select '30703', '��������', '������� ����������', '������' union all
select '30704', '��������', '������� ����������', '�����������' union all
select '40101', '�������� �������� ', '�����', '�����' union all
select '40201', '�������� �������� ', '����� ��������', '�����' union all
select '40301', '�������� �������� ', '���������� ����', '��������� ����' union all
select '50101', '������� ������� ��������', '���������� �����', '���������� �����' union all
select '50201', '������� ������� ��������', '���', '���' union all
select '50301', '������� ������� ��������', '������ ����������', '������ ����������' union all
select '60101', '������� ������� ��������', '���������� (�����������)', '���������' union all
select '60102', '������� ������� ��������', '���������� (�����������)', '������' union all
select '60201', '������� ������� ��������', '�� ��������', '���������' union all
select '60202', '������� ������� ��������', '�� ��������', '������' union all
select '70101', '���������', '����������', '������ �����' union all
select '70102', '���������', '����������', '������ �����' union all
select '70103', '���������', '����������', '�������� � �������' union all
select '70104', '���������', '����������', '������ ���' union all
select '70105', '���������', '����������', '���' union all
select '70106', '���������', '����������', '��������� ����' union all
select '70107', '���������', '����������', '������ ���������' union all
select '70108', '���������', '����������', '������' union all
select '70201', '���������', '������ ����������', '������ ����������' union all
select '70301', '���������', '���������', '���������' union all
select '70401', '���������', '������������ ������', '������������ ������' union all
select '70501', '���������', '���������� �����', '���������� �����' union all
select '70601', '���������', '���������� (������������)', '������ �����' union all
select '70701', '���������', '���������������� ��', '����������� ������' union all
select '70702', '���������', '���������������� ��', '����������� �������������' union all
select '70703', '���������', '���������������� ��', '����������� ����������' union all
select '70704', '���������', '���������������� ��', '������ �������� ��-��' union all
select '70801', '���������', '���������������� ��', '����������� ������' union all
select '70802', '���������', '���������������� ��', '����������� �������������' union all
select '70803', '���������', '���������������� ��', '����������� ����������' union all
select '70804', '���������', '���������������� ��', '������ �������� ��-��' union all
select '70901', '���������', '���', '���' union all
select '71001', '���������', '������� ��������', '������ �����' union all
select '71002', '���������', '������� ��������', '������ �����' union all
select '71003', '���������', '������� ��������', '�������� � �������' union all
select '71004', '���������', '������� ��������', '������ ���' union all
select '71005', '���������', '������� ��������', '���' union all
select '71006', '���������', '������� ��������', '��������� ����' union all
select '71007', '���������', '������� ��������', '������ ���������' union all
select '71008', '���������', '������� ��������', '������' union all
select '80101', '������������', '������� ������', '������� ������' union all
select '80201', '������������', '������ �������', '������ �������' union all
select '80301', '������������', '���������', '���������' union all
select '80401', '������������', '�������� �� ��������', '�������� �� ��������' union all
select '90101', '������� � ��������', '��������� �������', '��������� �������' union all
select '90201', '������� � ��������', '��������� ������� (������)', '��������� ������� (������)' union all
select '90301', '������� � ��������', '��������� ������� �� ��', '��������� ������� �� ��' union all
select '90401', '������� � ��������', '������ � ������', '������ � ������' union all
select '100101', '����������� �������', '�������������� �������', '�������������� �������' union all
select '100201', '����������� �������', '�������������� �������', '�������������� �������' union all
select '100301', '����������� �������', '������� �������� �������', '������� �������� �������' union all
select '100401', '����������� �������', '������� � �����������', '������� � �����������';

-- update _pgAccount set Id = 5000+Id;


commit;

