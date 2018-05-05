 create view ProjectInfoView
 as
 SELECT Tb_MoneyBill.STitle, Tb_MoneyBill.PersonID, Tb_MoneyBill.GuidID, Tb_MoneyBill.DoMoney, Tb_MoneyBill.DoTime, Tb_MoneyBill.SKind, Tb_Project.prjName
FROM Tb_MoneyBill INNER JOIN Tb_Project ON Tb_MoneyBill.ProjectGuidID=Tb_Project.GuidID;