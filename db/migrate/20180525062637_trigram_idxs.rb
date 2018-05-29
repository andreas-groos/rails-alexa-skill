class TrigramIdxs < ActiveRecord::Migration[5.2]
  def up
    # Note the index isn't likely to be used.
    execute <<-SQL
      create extension pg_trgm;
      CREATE INDEX recipe_name_trgm_idx ON recipes USING GIST (name gist_trgm_ops);
    SQL
  end

  def down
    execute <<-SQL
      DROP INDEX recipe_name_trgm_idx;
      drop extension pg_trgm;
    SQL
  end
end
