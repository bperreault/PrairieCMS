delete from userprofile where id=733019
delete from EnabledControlTable where userProfileID=733019
delete from linkedAccountMapping where userProfileID=733019
delete from UserAccountMapping where userProfileID=733019
delete from UserActivityLog where userProfileID=733019
delete from UserPassword  where userProfileID=733019
select top 1 * from linkedaccountmapping

select top 100 * from useraccountmapping --where accountNumber='22222222'

select top 1 * from UserProfile where id=619259 --order by id desc
select * from UserAccountMapping where userProfileID=619259--733020
select * from UserPassword where userProfileID=733020
select * from linkedAccountMapping

telephono                                                                         
payme1    

update useraccountmapping set nickname='test''s 2' where  userProfileID=733020
