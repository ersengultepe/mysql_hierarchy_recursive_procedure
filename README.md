# mysql_hierarchy_recursive_procedure
store procedure written for mysql that captures all subcategories of any of the categories held in the category table as parent and child

+-------------+----------------------+--------+
| category_id | name                 | parent |
+-------------+----------------------+--------+
|           1 | ELECTRONICS          |   NULL |
|           2 | TELEVISIONS          |      1 |
|           3 | TUBE                 |      2 |
|           4 | LCD                  |      2 |
|           5 | PLASMA               |      2 |
|           6 | PORTABLE ELECTRONICS |      1 |
|           7 | MP3 PLAYERS          |      6 |
|           8 | FLASH                |      7 |
|           9 | CD PLAYERS           |      6 |
|          10 | 2 WAY RADIOS         |      6 |
|          11 | CURVE                |      5 |
+-------------+----------------------+--------+

# Considering you have a table like the one above,
If you give the value of 2 as an argument to the procedure and you want to get the television and its subcategories 2,3,4,5,11 it will return its values.

And so you can reach the account of the products that are linked to these categories.
