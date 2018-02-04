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

ActiveRecord::Schema.define(version: 20180204223807) do

  create_table "accounts", force: :cascade do |t|
    t.string "country"
    t.string "email"
    t.string "account_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "account_id"
  end

  create_table "bank_accounts", force: :cascade do |t|
    t.string "country"
    t.string "currency"
    t.string "account_holder_name"
    t.string "account_holder_type"
    t.string "routing_number"
    t.string "account_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cus_id"
  end

  create_table "coupons", force: :cascade do |t|
    t.integer "percent_off"
    t.string "duration"
    t.integer "duration_in_months"
    t.string "currency"
    t.integer "amount_off"
    t.integer "max_redemptions"
    t.datetime "redeem_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "description"
    t.string "email"
    t.integer "exp_month"
    t.integer "exp_year"
    t.string "card_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cvc"
    t.string "cus_id"
  end

  create_table "payments", force: :cascade do |t|
    t.string "cus_id"
    t.integer "amount"
    t.string "description"
    t.string "currency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "coupon", default: false
    t.integer "percent_off"
    t.string "duration"
    t.integer "duration_in_months"
    t.string "coupon_id"
  end

  create_table "payouts", force: :cascade do |t|
    t.integer "amount"
    t.string "currency"
    t.string "destination"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plans", force: :cascade do |t|
    t.string "currency"
    t.string "interval"
    t.string "name"
    t.integer "amount"
    t.integer "interval_count"
    t.string "statement_descriptor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "refunds", force: :cascade do |t|
    t.string "charge_id"
    t.integer "amount"
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "plan_id"
    t.string "cus_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transfers", force: :cascade do |t|
    t.integer "amount"
    t.string "currency"
    t.string "destination"
    t.string "source_transaction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
