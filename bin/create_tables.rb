#!/usr/bin/env ruby

def generate_constraint(prefix, condition)
  # "lower(substring(#{prefix}url from '[hHfFtTpPsS]{3,5}://(?:w+\\d*?\\.)?(.)')) #{condition} "
  "#{prefix}routing_key #{condition} "
  # "lower(regexp_replace(#{prefix}url, '[hHfFtTpP]{3,5}://(w+\\d*\\.)?(.{1})', '\\2')) #{condition} "
end

puts %q|
drop table infringing_urls_template cascade;
drop table infringing_urls cascade;

CREATE TABLE infringing_urls_template (
    id serial PRIMARY KEY,
    url character varying(8192) NOT NULL,
    routing_key character varying(3) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE UNIQUE INDEX index_infringing_urls_template_on_url ON infringing_urls_template USING btree (url);
CREATE INDEX index_infringing_urls_template_on_routing_key ON infringing_urls_template USING btree (routing_key);

CREATE VIEW infringing_urls as select * from infringing_urls_template;
|

seeds = [('a'..'z').to_a, (0..9).to_a].flatten

tables = seeds.map do |seed|
  {
    name: seed,
    constraint: generate_constraint('', "= '#{seed}'")
  }
end

tables << {
  name: 'etc',
  constraint: generate_constraint('', "!~ '[a-z\\d]+'")
}

tables.each do |table_def|
  puts %Q|
CREATE TABLE infringing_urls_#{table_def[:name]} (
    CHECK ( #{table_def[:constraint]} )
) INHERITS (infringing_urls_template);

CREATE UNIQUE INDEX index_infringing_urls_#{table_def[:name]}_on_url ON infringing_urls_#{table_def[:name]} USING btree (url);
CREATE INDEX index_infringing_urls_#{table_def[:name]}_on_routing_key ON infringing_urls_#{table_def[:name]} USING btree (routing_key);
|
end

tables = seeds.map do |seed|
  {
    name: seed,
    constraint: generate_constraint('NEW.', "= '#{seed}'")
  }
end

tables << {
  name: 'etc',
  constraint: generate_constraint('NEW.', "!~ '[a-z\\d]+'")
}

puts %Q|
CREATE OR REPLACE FUNCTION infringing_urls_insert_redirector()
RETURNS TRIGGER AS $$
DECLARE
  fake_row infringing_urls_template%ROWTYPE;
BEGIN
|
constraints = ''
tables.each_with_index do |table_def, i|
  if i == 0

    constraints += %Q|IF ( #{table_def[:constraint]}) THEN
  INSERT INTO infringing_urls_#{table_def[:name]}(url, created_at, updated_at, routing_key) VALUES (NEW.url, NEW.created_at, NEW.updated_at, NEW.routing_key);
  fake_row.id = currval('infringing_urls_template_id_seq');
  fake_row.url = NEW.url;
  fake_row.created_at = NEW.created_at;
  fake_row.updated_at = NEW.updated_at;
  RETURN fake_row;
|
  else
    constraints += %Q|
ELSIF ( #{table_def[:constraint]}) THEN
  INSERT INTO infringing_urls_#{table_def[:name]}(url, created_at, updated_at, routing_key) VALUES (NEW.url, NEW.created_at, NEW.updated_at, NEW.routing_key);
  fake_row.id = currval('infringing_urls_template_id_seq');
  fake_row.url = NEW.url;
  fake_row.created_at = NEW.created_at;
  fake_row.updated_at = NEW.updated_at;
  RETURN fake_row;
|
  end
end

puts %Q|
#{constraints}
    ELSE
        RAISE EXCEPTION 'URL cannot be routed to a partition.  Fix the infringing_urls_insert_redirector() function!';
    END IF;

    RETURN fake_row;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER insert_infringing_url_trigger
    INSTEAD OF INSERT ON infringing_urls
    FOR EACH ROW EXECUTE PROCEDURE infringing_urls_insert_redirector();
|

# puts %Q|CREATE OR REPLACE FUNCTION infringing_urls_id_return()
# RETURNS TRIGGER AS $$
# DECLARE
#   id_inserted record;
# BEGIN
#   SELECT * into id_inserted from infringing_urls order by id limit 1;
# RETURN id_inserted;
# END;
# $$
# LANGUAGE plpgsql;
# 
# CREATE TRIGGER after_insert_infringing_url_trigger
#     AFTER INSERT ON infringing_urls
#     FOR EACH ROW EXECUTE PROCEDURE infringing_urls_id_return();|


puts "insert into infringing_urls(created_at, updated_at, url, routing_key) values(NOW(), NOW(), 'http://www.a.com','a') returning \"id\";"
puts "select * from infringing_urls;"
puts "select * from infringing_urls_a;"

