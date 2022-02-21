class CheckRegistRecipeProcedure < ActiveRecord::Migration[6.1]
  def self.up
    execute <<-SQL
CREATE OR REPLACE FUNCTION public.check_regist_recipe(user_id integer)
RETURNS integer
LANGUAGE plpgsql
AS $function$
  BEGIN
return (

  SELECT sum(recipe_cnt) as total_recipe_cnt 
  FROM(
  
    SELECT count(r.id) as recipe_cnt 
    FROM users as u 
      left join recipes as r on u.id = r.user_id 
    WHERE u.id = $1
    
    union 
    
    SELECT count(rt.id) as recipe_cnt 
    FROM users as u 
      left join recipe_templates as rt on u.id = rt.user_id 
    WHERE u.id = $1
  ) as regist_recipe

  );
END;
$function$
SQL
  end

  def self.down
    execute "DROP FUNCTION public.check_regist_recipe;"
  end
end
