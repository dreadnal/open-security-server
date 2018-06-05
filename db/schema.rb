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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 1) do

  create_table "areas", force: :cascade do |t|
    t.integer "floor_id"
    t.string "name"
    t.text "verticles"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["floor_id"], name: "index_areas_on_floor_id"
  end

  create_table "devices", force: :cascade do |t|
    t.string "name"
    t.boolean "verified"
    t.string "api_key"
    t.string "one_time_password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_types", force: :cascade do |t|
    t.string "name"
    t.string "ref_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer "event_type_id"
    t.integer "sensor_id"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_type_id"], name: "index_events_on_event_type_id"
    t.index ["sensor_id"], name: "index_events_on_sensor_id"
  end

  create_table "floors", force: :cascade do |t|
    t.string "name"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "preferences", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sensor_types", force: :cascade do |t|
    t.string "name"
  end

  create_table "system_modules", force: :cascade do |t|
    t.integer "area_id"
    t.string "name"
    t.string "type"
    t.float "position_x"
    t.float "position_y"
    t.float "position_z"
    t.float "rotation_x"
    t.float "rotation_y"
    t.float "rotation_z"
    t.integer "sensor_type_id"
    t.string "address"
    t.string "api_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_system_modules_on_area_id"
    t.index ["sensor_type_id"], name: "index_system_modules_on_sensor_type_id"
  end

end
