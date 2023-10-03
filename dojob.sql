USE game;

CREATE TABLE player(
 id INT,
 name VARCHAR(255),#VARCHAR后面要确定字符的长度
 level INT,
 exp INT,
 gold DECIMAL(10,2)
)
DESC player;
INSERT INTO player (id, name, level, exp, gold) VALUES (1, 'Bob', 1, 1, 1);#添加单条数据
INSERT INTO player (id, name, level, exp, gold) VALUES (2, 'John', 2, 2, 2),(3,'Steve',3,3,3);#添加多条数据

SELECT * FROM player;#查询所有数据

ALTER TABLE player MODIFY LEVEL INT DEFAULT 1;#给level添加默认值

INSERT INTO player (id, name) VALUES (4,'Nana');

UPDATE player SET exp =1,gold =1 where name = 'Nana';#修改某一个数据

UPDATE player SET exp=0,gold=0;#修改所有的

DELETE FROM player WHERE name = 'Bob';#删除数据

ALTER TABLE player MODIFY COLUMN name VARCHAR(200);#修改列的数据类型
ALTER TABLE player RENAME COLUMN name to nick_name;#修改column的名称
ALTER TABLE player ADD COLUMN last_login TIMESTAMP;#添加新的一列
ALTER TABLE player DROP COLUMN last_login;
DROP TABLE player;


#常用语句
SELECT * FROM sheet1 WHERE `国庆状态` = '留校'AND`学生类型`='硕士研究生' OR `国庆状态` = '留校'AND`学生类型`='本科生';#两个condition类型
#优先级AND>OR>NOT,可以通过加（）改变优先级
SELECT * FROM sheet1 WHERE `国庆状态` = '留校'AND (`学生类型`='硕士研究生' OR `国庆状态` = '留校')AND`学生类型`='本科生';

SELECT * FROM sheet1 WHERE `所在楼号`IN (42,43,45);#查询多个条件的数据

SELECT * FROM sheet1 WHERE `离沪学生填写` LIKE '江西%' AND `学号` LIKE '23%'

SELECT * FROM sheet1 WHERE `所在楼号` BETWEEN 42 AND 43;#查询某个区间的数据
SELECT * FROM sheet1 WHERE `所在楼号` NOT BETWEEN 42 AND 43;

SELECT * FROM sheet1 WHERE `所在楼号` <= 42 AND `所在楼号` >=44;

SELECT * FROM sheet1 WHERE `姓名` LIKE '廖%'; #模糊查询 %多个字符 _一个字符
SELECT * FROM sheet1 WHERE `姓名` LIKE '%王%'; #姓名中包含王
SELECT * FROM sheet1 WHERE `姓名` LIKE '王_';
SELECT * FROM sheet1 WHERE `姓名` LIKE '王__';

SELECT * FROM sheet1 WHERE `姓名` REGEXP '^王.$';
SELECT * FROM sheet1 WHERE `姓名` REGEXP '^王..$';
SELECT * FROM sheet1 WHERE `姓名` REGEXP '王';#用正则化找包含王的
#正则化表达式，以^开头，以$结尾，.表示任意字符，[abc]表示其中任意一个字符，[a-z]表示区间内任意一个字符，A|B表示A或者B

SELECT * FROM sheet1 WHERE `离沪学生填写` IS NULL;#查找null
SELECT * FROM sheet1 WHERE `离沪学生填写` <=> NULL;#常用写法
SELECT * FROM sheet1 WHERE `离沪学生填写` IS NOT NULL;
SELECT * FROM sheet1 WHERE `离沪学生填写` = '';#区分null与空白

SELECT * FROM sheet1 ORDER BY `学号` ;#数据排序，默认升序
SELECT * FROM sheet1 ORDER BY `学号` DESC;#降序
SELECT * FROM sheet1 ORDER BY 3 DESC;#也可以将column替换成其索引

SELECT * FROM sheet1 ORDER BY `学号` DESC,`所在楼号` ASC;#按照某一列降序排列

SELECT COUNT(*) FROM sheet1;#聚合函数count max min avg sum

SELECT `学生类型`,COUNT(*) FROM sheet1 GROUP BY `学生类型`; #分组groupby
SELECT `所在楼号`,COUNT(所在楼号) FROM sheet1 GROUP BY `所在楼号`; #按照具体的column分组

SELECT `所在楼号`,COUNT(所在楼号) FROM sheet1 GROUP BY `所在楼号` HAVING COUNT(`所在楼号`) >40;#按照条件分组

SELECT `所在楼号`,COUNT(所在楼号) FROM sheet1 GROUP BY `所在楼号` HAVING COUNT(`所在楼号`) >40 ORDER BY COUNT(`所在楼号`) DESC;#HAVING经常与ORDER BY结合使用

#统计每个姓氏的学生，并按照姓氏数量排序
SELECT SUBSTR(`姓名`,1,1),COUNT(SUBSTR(`姓名`,1,1)) FROM sheet1 
GROUP BY SUBSTR(`姓名`,1,1) 
HAVING COUNT(SUBSTR(`姓名`,1,1)) >0
ORDER BY COUNT(SUBSTR(`姓名`,1,1)) DESC 
LIMIT 5,2#加上这个意味着只取前5,加上，之后表示偏移量 ，即往5开始的第一二个
;

SELECT DISTINCT `姓名` FROM sheet1;#去重

SELECT * FROM sheet1 WHERE `离沪学生填写` IS NULL;
UNION #ALL则不去重复
SELECT * FROM sheet1 WHERE `国庆状态` = '留校'AND`学生类型`='硕士研究生';#将两个条件结合取并集，且默认去掉重复

SELECT * FROM sheet1 WHERE `离沪学生填写` IS NULL;
INTERSECT
SELECT * FROM sheet1 WHERE `国庆状态` = '留校'AND`学生类型`='硕士研究生';#将两个条件结合取交集

SELECT * FROM sheet1 WHERE `离沪学生填写` IS NULL;
EXCEPT
SELECT * FROM sheet1 WHERE `国庆状态` = '留校'AND`学生类型`='硕士研究生';#取差集

#subselection子查询
SELECT AVG(`学号`) FROM sheet1;
SELECT `学号`,AVG(`学号`) FROM sheet1;
SELECT * FROM sheet1 where `学号` > (SELECT AVG(`学号`) FROM sheet1); #注意格式
SELECT `学号`,
ROUND((SELECT AVG(`学号`) FROM sheet1)) AS avg  ,
`学号`-ROUND((SELECT AVG(`学号`) FROM sheet1)) AS diff FROM sheet1; #ROUND(X)函数能取整,as 将column重新命名

SELECT * FROM sheet1 where `学号` < (SELECT AVG(`学号`) FROM sheet1); #注意格式

CREATE TABLE new_table  SELECT * FROM sheet1 where `学号` < (SELECT AVG(`学号`) FROM sheet1);#将筛选出的信息形成一个新的table
SELECT * FROM new_table;

INSERT INTO new_table SELECT * FROM new_table WHERE `所在楼号`= 42;#将符合条件的插入到表中

SELECT EXISTS(SELECT * FROM new_table WHERE `所在楼号`= 43
);#这是一个bool函数




CREATE TABLE equip (
id INT,
name VARCHAR(100),
play_id INT);

ALTER TABLE equip RENAME COLUMN play_id TO player_id;

DESC equip;
INSERT INTO equip (id,name,player_id) VALUES (1,'Bob',1),(2,'John',2);

SELECT * FROM equip;
DESC player;

SELECT* FROM player 
INNER JOIN equip
ON player.id = equip.player_id;

SELECT* FROM player 
LEFT JOIN equip
ON player.id = equip.player_id;#左连接

SELECT* FROM player 
RIGHT JOIN equip
ON player.id = equip.player_id;#右连接

SELECT* FROM player , equip
WHERE player.id = equip.player_id;#右连接

SELECT* FROM player p, equip e
WHERE p.id = e.player_id;#右连接

#注意笛卡尔积的问题，条件不可丢失


#索引index，对一张表的主键字段创建索引
CREATE INDEX `学号index` ON sheet1(`学号`);
SELECT * FROM sheet1;
SHOW INDEX FROM sheet1;

DROP INDEX `学号index` ON sheet1;

ALTER TABLE sheet1 add INDEX `学号index`(`学号`);#给某一列添加索引

#视图
CREATE VIEW top10
AS
SELECT * FROM sheet1 ORDER BY `学号` DESC LIMIT 10;

SELECT * from top10;
#视图是动态的，会随着表的数据变化而变化。

ALTER VIEW top10 
AS
SELECT * FROM sheet1 ORDER BY `学号` LIMIT 10;#更新视图

DROP VIEW top10;#删除视图