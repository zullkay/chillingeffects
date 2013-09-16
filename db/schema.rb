# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130911174350) do

  create_table "blog_entries", :force => true do |t|
    t.integer  "user_id"
    t.string   "author",       :null => false
    t.string   "title",        :null => false
    t.text     "abstract"
    t.text     "content"
    t.datetime "published_at"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "image"
  end

  create_table "blog_entry_categorizations", :force => true do |t|
    t.integer "blog_entry_id"
    t.integer "category_id"
  end

  add_index "blog_entry_categorizations", ["blog_entry_id"], :name => "index_blog_entry_categorizations_on_blog_entry_id"
  add_index "blog_entry_categorizations", ["category_id"], :name => "index_blog_entry_categorizations_on_category_id"

  create_table "categories", :force => true do |t|
    t.string "name",        :null => false
    t.text   "description"
    t.string "ancestry"
  end

  add_index "categories", ["ancestry"], :name => "index_categories_on_ancestry"

  create_table "categories_category_managers", :force => true do |t|
    t.integer "category_id"
    t.integer "category_manager_id"
  end

  add_index "categories_category_managers", ["category_id"], :name => "index_categories_category_managers_on_category_id"
  add_index "categories_category_managers", ["category_manager_id"], :name => "index_categories_category_managers_on_category_manager_id"

  create_table "categories_relevant_questions", :force => true do |t|
    t.integer "category_id"
    t.integer "relevant_question_id"
  end

  add_index "categories_relevant_questions", ["category_id"], :name => "index_categories_relevant_questions_on_category_id"
  add_index "categories_relevant_questions", ["relevant_question_id"], :name => "index_categories_relevant_questions_on_relevant_question_id"

  create_table "categorizations", :force => true do |t|
    t.integer "category_id"
    t.integer "notice_id"
  end

  add_index "categorizations", ["category_id"], :name => "index_categories_notices_on_category_id"
  add_index "categorizations", ["notice_id"], :name => "index_categories_notices_on_notice_id"

  create_table "category_managers", :force => true do |t|
    t.string "name", :null => false
  end

  create_table "copyrighted_urls", :force => true do |t|
    t.string   "url",        :limit => 8192, :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "copyrighted_urls", ["url"], :name => "index_copyrighted_urls_on_url", :unique => true

  create_table "copyrighted_urls_works", :id => false, :force => true do |t|
    t.integer "copyrighted_url_id", :null => false
    t.integer "work_id",            :null => false
  end

  add_index "copyrighted_urls_works", ["copyrighted_url_id"], :name => "index_copyrighted_urls_works_on_copyrighted_url_id"
  add_index "copyrighted_urls_works", ["work_id"], :name => "index_copyrighted_urls_works_on_work_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "entities", :force => true do |t|
    t.string  "name",                                     :null => false
    t.string  "kind",           :default => "individual", :null => false
    t.string  "address_line_1"
    t.string  "address_line_2"
    t.string  "state"
    t.string  "country_code"
    t.string  "phone"
    t.string  "email"
    t.string  "url"
    t.string  "ancestry"
    t.string  "city"
    t.string  "zip"
    t.integer "user_id"
  end

  add_index "entities", ["ancestry"], :name => "index_entities_on_ancestry"
  add_index "entities", ["name"], :name => "index_entities_on_name", :unique => true
  add_index "entities", ["user_id"], :name => "index_entities_on_user_id"

  create_table "entity_notice_roles", :force => true do |t|
    t.integer  "entity_id",  :null => false
    t.integer  "notice_id",  :null => false
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "entity_notice_roles", ["entity_id"], :name => "index_entity_notice_roles_on_entity_id"
  add_index "entity_notice_roles", ["notice_id"], :name => "index_entity_notice_roles_on_notice_id"

  create_table "file_uploads", :force => true do |t|
    t.integer  "notice_id"
    t.string   "kind"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "file_uploads", ["notice_id"], :name => "index_file_uploads_on_notice_id"

  create_table "infringing_urls_0", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_0", ["routing_key"], :name => "index_infringing_urls_0_on_routing_key"
  add_index "infringing_urls_0", ["url"], :name => "index_infringing_urls_0_on_url", :unique => true

  create_table "infringing_urls_1", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_1", ["routing_key"], :name => "index_infringing_urls_1_on_routing_key"
  add_index "infringing_urls_1", ["url"], :name => "index_infringing_urls_1_on_url", :unique => true

  create_table "infringing_urls_2", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_2", ["routing_key"], :name => "index_infringing_urls_2_on_routing_key"
  add_index "infringing_urls_2", ["url"], :name => "index_infringing_urls_2_on_url", :unique => true

  create_table "infringing_urls_3", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_3", ["routing_key"], :name => "index_infringing_urls_3_on_routing_key"
  add_index "infringing_urls_3", ["url"], :name => "index_infringing_urls_3_on_url", :unique => true

  create_table "infringing_urls_4", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_4", ["routing_key"], :name => "index_infringing_urls_4_on_routing_key"
  add_index "infringing_urls_4", ["url"], :name => "index_infringing_urls_4_on_url", :unique => true

  create_table "infringing_urls_5", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_5", ["routing_key"], :name => "index_infringing_urls_5_on_routing_key"
  add_index "infringing_urls_5", ["url"], :name => "index_infringing_urls_5_on_url", :unique => true

  create_table "infringing_urls_6", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_6", ["routing_key"], :name => "index_infringing_urls_6_on_routing_key"
  add_index "infringing_urls_6", ["url"], :name => "index_infringing_urls_6_on_url", :unique => true

  create_table "infringing_urls_7", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_7", ["routing_key"], :name => "index_infringing_urls_7_on_routing_key"
  add_index "infringing_urls_7", ["url"], :name => "index_infringing_urls_7_on_url", :unique => true

  create_table "infringing_urls_8", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_8", ["routing_key"], :name => "index_infringing_urls_8_on_routing_key"
  add_index "infringing_urls_8", ["url"], :name => "index_infringing_urls_8_on_url", :unique => true

  create_table "infringing_urls_9", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_9", ["routing_key"], :name => "index_infringing_urls_9_on_routing_key"
  add_index "infringing_urls_9", ["url"], :name => "index_infringing_urls_9_on_url", :unique => true

  create_table "infringing_urls_a", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_a", ["routing_key"], :name => "index_infringing_urls_a_on_routing_key"
  add_index "infringing_urls_a", ["url"], :name => "index_infringing_urls_a_on_url", :unique => true

  create_table "infringing_urls_b", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_b", ["routing_key"], :name => "index_infringing_urls_b_on_routing_key"
  add_index "infringing_urls_b", ["url"], :name => "index_infringing_urls_b_on_url", :unique => true

  create_table "infringing_urls_c", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_c", ["routing_key"], :name => "index_infringing_urls_c_on_routing_key"
  add_index "infringing_urls_c", ["url"], :name => "index_infringing_urls_c_on_url", :unique => true

  create_table "infringing_urls_d", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_d", ["routing_key"], :name => "index_infringing_urls_d_on_routing_key"
  add_index "infringing_urls_d", ["url"], :name => "index_infringing_urls_d_on_url", :unique => true

  create_table "infringing_urls_e", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_e", ["routing_key"], :name => "index_infringing_urls_e_on_routing_key"
  add_index "infringing_urls_e", ["url"], :name => "index_infringing_urls_e_on_url", :unique => true

  create_table "infringing_urls_etc", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_etc", ["routing_key"], :name => "index_infringing_urls_etc_on_routing_key"
  add_index "infringing_urls_etc", ["url"], :name => "index_infringing_urls_etc_on_url", :unique => true

  create_table "infringing_urls_f", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_f", ["routing_key"], :name => "index_infringing_urls_f_on_routing_key"
  add_index "infringing_urls_f", ["url"], :name => "index_infringing_urls_f_on_url", :unique => true

  create_table "infringing_urls_g", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_g", ["routing_key"], :name => "index_infringing_urls_g_on_routing_key"
  add_index "infringing_urls_g", ["url"], :name => "index_infringing_urls_g_on_url", :unique => true

  create_table "infringing_urls_h", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_h", ["routing_key"], :name => "index_infringing_urls_h_on_routing_key"
  add_index "infringing_urls_h", ["url"], :name => "index_infringing_urls_h_on_url", :unique => true

  create_table "infringing_urls_i", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_i", ["routing_key"], :name => "index_infringing_urls_i_on_routing_key"
  add_index "infringing_urls_i", ["url"], :name => "index_infringing_urls_i_on_url", :unique => true

  create_table "infringing_urls_j", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_j", ["routing_key"], :name => "index_infringing_urls_j_on_routing_key"
  add_index "infringing_urls_j", ["url"], :name => "index_infringing_urls_j_on_url", :unique => true

  create_table "infringing_urls_k", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_k", ["routing_key"], :name => "index_infringing_urls_k_on_routing_key"
  add_index "infringing_urls_k", ["url"], :name => "index_infringing_urls_k_on_url", :unique => true

  create_table "infringing_urls_l", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_l", ["routing_key"], :name => "index_infringing_urls_l_on_routing_key"
  add_index "infringing_urls_l", ["url"], :name => "index_infringing_urls_l_on_url", :unique => true

  create_table "infringing_urls_m", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_m", ["routing_key"], :name => "index_infringing_urls_m_on_routing_key"
  add_index "infringing_urls_m", ["url"], :name => "index_infringing_urls_m_on_url", :unique => true

  create_table "infringing_urls_n", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_n", ["routing_key"], :name => "index_infringing_urls_n_on_routing_key"
  add_index "infringing_urls_n", ["url"], :name => "index_infringing_urls_n_on_url", :unique => true

  create_table "infringing_urls_o", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_o", ["routing_key"], :name => "index_infringing_urls_o_on_routing_key"
  add_index "infringing_urls_o", ["url"], :name => "index_infringing_urls_o_on_url", :unique => true

  create_table "infringing_urls_p", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_p", ["routing_key"], :name => "index_infringing_urls_p_on_routing_key"
  add_index "infringing_urls_p", ["url"], :name => "index_infringing_urls_p_on_url", :unique => true

  create_table "infringing_urls_q", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_q", ["routing_key"], :name => "index_infringing_urls_q_on_routing_key"
  add_index "infringing_urls_q", ["url"], :name => "index_infringing_urls_q_on_url", :unique => true

  create_table "infringing_urls_r", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_r", ["routing_key"], :name => "index_infringing_urls_r_on_routing_key"
  add_index "infringing_urls_r", ["url"], :name => "index_infringing_urls_r_on_url", :unique => true

  create_table "infringing_urls_s", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_s", ["routing_key"], :name => "index_infringing_urls_s_on_routing_key"
  add_index "infringing_urls_s", ["url"], :name => "index_infringing_urls_s_on_url", :unique => true

  create_table "infringing_urls_t", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_t", ["routing_key"], :name => "index_infringing_urls_t_on_routing_key"
  add_index "infringing_urls_t", ["url"], :name => "index_infringing_urls_t_on_url", :unique => true

  create_table "infringing_urls_template", :force => true do |t|
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_template", ["routing_key"], :name => "index_infringing_urls_template_on_routing_key"
  add_index "infringing_urls_template", ["url"], :name => "index_infringing_urls_template_on_url", :unique => true

  create_table "infringing_urls_u", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_u", ["routing_key"], :name => "index_infringing_urls_u_on_routing_key"
  add_index "infringing_urls_u", ["url"], :name => "index_infringing_urls_u_on_url", :unique => true

  create_table "infringing_urls_v", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_v", ["routing_key"], :name => "index_infringing_urls_v_on_routing_key"
  add_index "infringing_urls_v", ["url"], :name => "index_infringing_urls_v_on_url", :unique => true

  create_table "infringing_urls_w", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_w", ["routing_key"], :name => "index_infringing_urls_w_on_routing_key"
  add_index "infringing_urls_w", ["url"], :name => "index_infringing_urls_w_on_url", :unique => true

  create_table "infringing_urls_works", :id => false, :force => true do |t|
    t.integer "infringing_url_id", :null => false
    t.integer "work_id",           :null => false
  end

  add_index "infringing_urls_works", ["infringing_url_id"], :name => "index_infringing_urls_works_on_infringing_url_id"
  add_index "infringing_urls_works", ["work_id"], :name => "index_infringing_urls_works_on_work_id"

  create_table "infringing_urls_x", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_x", ["routing_key"], :name => "index_infringing_urls_x_on_routing_key"
  add_index "infringing_urls_x", ["url"], :name => "index_infringing_urls_x_on_url", :unique => true

  create_table "infringing_urls_y", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_y", ["routing_key"], :name => "index_infringing_urls_y_on_routing_key"
  add_index "infringing_urls_y", ["url"], :name => "index_infringing_urls_y_on_url", :unique => true

  create_table "infringing_urls_z", :id => false, :force => true do |t|
    t.integer  "id",                          :null => false
    t.string   "url",         :limit => 8192, :null => false
    t.string   "routing_key", :limit => 3,    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "infringing_urls_z", ["routing_key"], :name => "index_infringing_urls_z_on_routing_key"
  add_index "infringing_urls_z", ["url"], :name => "index_infringing_urls_z_on_url", :unique => true

  create_table "notices", :force => true do |t|
    t.string   "title",                                 :null => false
    t.text     "body"
    t.datetime "date_received"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "source"
    t.string   "subject"
    t.boolean  "review_required"
    t.text     "body_original"
    t.datetime "date_sent"
    t.integer  "reviewer_id"
    t.string   "language"
    t.boolean  "rescinded",          :default => false, :null => false
    t.string   "action_taken",       :default => "No",  :null => false
    t.string   "type"
    t.integer  "original_notice_id"
    t.boolean  "spam",               :default => false
    t.boolean  "hidden",             :default => false
  end

  add_index "notices", ["reviewer_id"], :name => "index_notices_on_reviewer_id"
  add_index "notices", ["type"], :name => "index_notices_on_type"

  create_table "notices_relevant_questions", :force => true do |t|
    t.integer "notice_id"
    t.integer "relevant_question_id"
  end

  add_index "notices_relevant_questions", ["notice_id"], :name => "index_notices_relevant_questions_on_notice_id"
  add_index "notices_relevant_questions", ["relevant_question_id"], :name => "index_notices_relevant_questions_on_relevant_question_id"

  create_table "notices_works", :id => false, :force => true do |t|
    t.integer "notice_id"
    t.integer "work_id"
  end

  add_index "notices_works", ["notice_id"], :name => "index_notices_works_on_notice_id"
  add_index "notices_works", ["work_id"], :name => "index_notices_works_on_work_id"

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item"], :name => "index_rails_admin_histories_on_item"
  add_index "rails_admin_histories", ["month"], :name => "index_rails_admin_histories_on_month"
  add_index "rails_admin_histories", ["table"], :name => "index_rails_admin_histories_on_table"
  add_index "rails_admin_histories", ["year"], :name => "index_rails_admin_histories_on_year"

  create_table "relevant_questions", :force => true do |t|
    t.text "question", :null => false
    t.text "answer",   :null => false
  end

  create_table "risk_triggers", :force => true do |t|
    t.string  "field"
    t.string  "condition_field"
    t.string  "condition_value"
    t.boolean "negated"
  end

  create_table "roles", :force => true do |t|
    t.string "name", :null => false
  end

  create_table "roles_users", :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "works", :force => true do |t|
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "kind"
  end

end
