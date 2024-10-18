
ActiveRecord::Schema[7.2].define(version: 2024_10_18_133745) do
  create_table "product_models", force: :cascade do |t|
    t.string "name"
    t.integer "weight"
    t.integer "width"
    t.integer "height"
    t.integer "depth"
    t.string "sku"
    t.integer "supplier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_id"], name: "index_product_models_on_supplier_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "corporate_name"
    t.string "brand_name"
    t.string "registration_number"
    t.string "full_address"
    t.string "city"
    t.string "state"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "warehouses", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "city"
    t.integer "area"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.string "cep"
    t.string "description"
  end

  add_foreign_key "product_models", "suppliers"
end
