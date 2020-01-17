DROP PROCEDURE IF EXISTS store_procedure_name;
CREATE PROCEDURE `store_procedure_name`(IN cat_id INT)
BEGIN
    declare loopId Int;
    SET max_sp_recursion_depth = 255;
    -- If the value of the category that comes as a parameter is not in the table as parent_id, no further action is required
    IF(select count(id) from category_table where parent_id=cat_id) > 0 THEN 
    
    -- create temporary table
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_category_table (
      `id` smallint(5) unsigned,
      `status` tinyint(3)
      ) ENGINE=InnoDB ;
    -- First, save the corresponding value in the temporary table.
    INSERT INTO temp_category_table
    (id, status) 
    VALUES (cat_id, 0);
          
    -- continue loop as long as the appropriate record exists in the temporary table
    WHILE (select count(id) from temp_category_table where status=0) > 0 DO 
      -- in this section, a record with a status of 0 will be extracted from the temporary table and assigned to the variable loopId
      set loopId = (select id from temp_category_table where status=0 limit 1);
      
      INSERT INTO temp_category_table
      (id, status)                                       
      (select id, 0 from category_table where parent_id=loopId);
      
      update temp_category_table set status=1 where id=loopId;
      
      CALL store_procedure_name((select id from temp_category_table where status=0 limit 1));     
      
    END WHILE;
    
    (select DISTINCT(id) from temp_category_table order by id ); 
    
    END IF;
END;
