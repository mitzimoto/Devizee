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

ActiveRecord::Schema.define(:version => 20120502015825) do

  create_table "agents", :force => true do |t|
    t.string   "code"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "areas", :force => true do |t|
    t.string   "short"
    t.string   "long"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "bizopps", :primary_key => "listing_id", :force => true do |t|
    t.string   "bu_type"
    t.integer  "lot_sq_ft"
    t.integer  "bldg_sq_feet"
    t.integer  "parking_spcs"
    t.string   "real_estate_incld"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "commercials", :primary_key => "listing_id", :force => true do |t|
    t.string   "ci_type"
    t.string   "space_available"
    t.integer  "rsu_units"
    t.integer  "rsf_bldg_sf"
    t.integer  "ofu_units"
    t.integer  "off_bldg_sf"
    t.integer  "reu_units"
    t.integer  "ref_bldg_sf"
    t.integer  "wau_units"
    t.integer  "waf_bldg_sf"
    t.integer  "mau_units"
    t.integer  "maf_bldg_sf"
    t.integer  "total_units"
    t.integer  "total_bldg_sf"
    t.integer  "lot_size"
    t.integer  "acre"
    t.integer  "parking_spcs"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "condos", :primary_key => "listing_id", :force => true do |t|
    t.string   "cc_type"
    t.integer  "no_living_levels"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "counties", :force => true do |t|
    t.string   "short"
    t.string   "long"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lands", :primary_key => "listing_id", :force => true do |t|
    t.string   "ld_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "listings", :force => true do |t|
    t.string   "subtype",                       :null => false
    t.integer  "list_no",        :limit => 255, :null => false
    t.string   "list_agent"
    t.string   "list_office"
    t.string   "status"
    t.integer  "list_price"
    t.integer  "town_num"
    t.string   "area_code"
    t.string   "zip_code"
    t.integer  "photo_count"
    t.string   "photo_date"
    t.string   "photo_mask"
    t.string   "lender_owned"
    t.string   "virtual_tours"
    t.string   "open_houses"
    t.string   "street_no"
    t.string   "street_name"
    t.integer  "taxes"
    t.string   "tax_year"
    t.string   "style"
    t.integer  "lot_size"
    t.float    "acre"
    t.integer  "square_feet"
    t.integer  "garage_spaces"
    t.string   "garage_parking"
    t.string   "basement"
    t.integer  "no_rooms"
    t.integer  "no_bedrooms"
    t.integer  "no_full_baths"
    t.integer  "no_half_baths"
    t.string   "master_bath"
    t.string   "liv_level"
    t.string   "liv_dimen"
    t.string   "din_level"
    t.string   "din_dimen"
    t.string   "fam_level"
    t.string   "fam_dimen"
    t.string   "kit_level"
    t.string   "kit_dimen"
    t.string   "mbr_level"
    t.string   "mbr_dimen"
    t.string   "bed2_level"
    t.string   "bed2_dimen"
    t.string   "bed3_level"
    t.string   "bed3_dimen"
    t.string   "bed4_level"
    t.string   "bed4_dimen"
    t.string   "bed5_level"
    t.string   "bed5_dimen"
    t.string   "bth1_level"
    t.string   "bth1_dimen"
    t.string   "bth2_level"
    t.string   "bth2_dimen"
    t.string   "bth3_level"
    t.string   "bth3_dimen"
    t.string   "laundry_level"
    t.string   "laundry_dimen"
    t.string   "oth1_room_name"
    t.string   "oth1_level"
    t.string   "oth1_dimen"
    t.string   "oth2_room_name"
    t.string   "oth2_level"
    t.string   "oth2_dimen"
    t.string   "oth3_room_name"
    t.string   "oth3_level"
    t.string   "oth3_dimen"
    t.string   "oth4_room_name"
    t.string   "oth4_level"
    t.string   "oth4_dimen"
    t.string   "oth5_room_name"
    t.string   "oth5_level"
    t.string   "oth5_dimen"
    t.string   "oth6_level"
    t.string   "oth6_dimen"
    t.integer  "year_built"
    t.integer  "assessments"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "mobile_homes", :primary_key => "listing_id", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "multi_families", :primary_key => "listing_id", :force => true do |t|
    t.string   "mf_type"
    t.integer  "no_units"
    t.integer  "no_floors"
    t.integer  "total_rms"
    t.integer  "garage_spaces"
    t.integer  "parking_spaces"
    t.integer  "lot_size"
    t.integer  "acre"
    t.integer  "square_feet"
    t.integer  "assessments"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "offices", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "references", :force => true do |t|
    t.integer  "sf"
    t.integer  "cc"
    t.integer  "mf"
    t.integer  "ld"
    t.integer  "ci"
    t.integer  "bu"
    t.integer  "m"
    t.string   "field"
    t.string   "short"
    t.string   "medium"
    t.string   "long"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rentals", :primary_key => "listing_id", :force => true do |t|
    t.string   "rn_type"
    t.integer  "parking_spaces"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "sfprops", :primary_key => "listing_id", :force => true do |t|
    t.string   "sf_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "towns", :force => true do |t|
    t.string   "num"
    t.string   "long"
    t.string   "county_short"
    t.string   "state"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
