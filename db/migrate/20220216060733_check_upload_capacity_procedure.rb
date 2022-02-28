class CheckUploadCapacityProcedure < ActiveRecord::Migration[6.1]
  def self.up
    execute <<-SQL
CREATE OR REPLACE FUNCTION public.check_upload_capacity(user_id integer)
RETURNS integer
LANGUAGE plpgsql
AS $function$
  BEGIN
    return (
SELECT sum(cap) as total_cap
FROM (
  SELECT sum(asb.byte_size) as cap
  FROM users as u 
    left join recipes as r on u.id = r.user_id 
    left join active_storage_attachments as asa on r.id = asa.record_id 
    left join active_storage_blobs as asb on asa.blob_id = asb.id 
  WHERE u.id = $1 and asa.record_type = 'Recipe'

  union all 

  SELECT sum(asb.byte_size) as cap 
  FROM users as u 
    left join recipe_templates as rt on u.id = rt.user_id 
    left join active_storage_attachments as asa on rt.id = asa.record_id 
    left join active_storage_blobs as asb on asa.blob_id = asb.id 
  WHERE u.id = $1 and asa.record_type = 'RecipeTemplate'

) as capacity

  );
  END;
$function$
SQL
  end

  def self.down
    execute "DROP PROCEDURE public.check_upload_capacity;"
  end

end
