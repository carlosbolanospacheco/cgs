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

ActiveRecord::Schema.define(version: 20170601180309) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", id: :integer, default: -> { "nextval('cuentas_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "banco_id"
    t.string  "oficina"
    t.string  "digitos_control"
    t.string  "cuenta"
    t.string  "iban"
  end

  create_table "bancos", force: :cascade do |t|
    t.string "nombre"
    t.string "codigo_pais",      default: "ES"
    t.string "codigo_entidad"
    t.string "codigo_localidad"
    t.string "clave_entidad"
  end

  create_table "cargo_colegiados", force: :cascade do |t|
    t.integer "cargo_id"
    t.integer "colegiado_id"
    t.date    "alta"
    t.date    "baja"
    t.integer "causa_baja_id"
  end

  create_table "cargos", force: :cascade do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.string   "firma_file_name"
    t.string   "firma_content_type"
    t.integer  "firma_file_size"
    t.datetime "firma_updated_at"
    t.integer  "colegiado_id"
  end

  create_table "causa_bajas", force: :cascade do |t|
    t.string "codigo"
    t.string "nombre"
  end

  create_table "colegiados", force: :cascade do |t|
    t.integer  "numero"
    t.string   "nombre"
    t.string   "apellidos"
    t.string   "nif"
    t.date     "nacimiento"
    t.string   "genero"
    t.string   "fotografia_file_name"
    t.string   "fotografia_content_type"
    t.integer  "fotografia_file_size"
    t.datetime "fotografia_updated_at"
    t.string   "email"
    t.string   "telefono_fijo"
    t.string   "telefono_movil"
    t.string   "fax"
    t.string   "cuenta_bancaria"
    t.date     "alta_colegio"
    t.date     "baja_colegio"
    t.integer  "regimen_colegiado_id"
    t.string   "nombre_empresa"
    t.string   "nif_empresa"
    t.text     "observaciones"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "jura"
    t.integer  "epp"
    t.integer  "titulacion_id"
    t.string   "numero_archivo"
    t.boolean  "excluido_censo",          default: false
    t.index ["apellidos"], name: "index_colegiados_on_apellidos", using: :btree
    t.index ["nif"], name: "index_colegiados_on_nif", using: :btree
    t.index ["numero"], name: "index_colegiados_on_numero", using: :btree
  end

  create_table "colegios", force: :cascade do |t|
    t.string   "nombre"
    t.string   "logo_colegio_file_name"
    t.string   "logo_colegio_content_type"
    t.integer  "logo_colegio_file_size"
    t.datetime "logo_colegio_updated_at"
    t.string   "logo_escuela_file_name"
    t.string   "logo_escuela_content_type"
    t.integer  "logo_escuela_file_size"
    t.datetime "logo_escuela_updated_at"
    t.string   "logo_formacion_file_name"
    t.string   "logo_formacion_content_type"
    t.integer  "logo_formacion_file_size"
    t.datetime "logo_formacion_updated_at"
    t.string   "nombre_recibos"
    t.string   "direccion"
    t.string   "poblacion"
    t.string   "codigo_postal"
    t.integer  "provincia_id"
    t.string   "cif"
    t.string   "telefono"
    t.string   "fax"
    t.string   "sufijo"
    t.string   "url"
    t.integer  "antiguedad_elegible",         default: 2
    t.string   "email"
  end

  create_table "direccion_colegiados", force: :cascade do |t|
    t.integer "colegiado_id"
    t.string  "descripcion"
    t.string  "direccion"
    t.string  "poblacion"
    t.integer "provincia_id"
    t.string  "codigo_postal"
    t.boolean "principal"
    t.index ["colegiado_id"], name: "index_direccion_colegiados_on_colegiado_id", using: :btree
  end

  create_table "documento_colegiados", force: :cascade do |t|
    t.integer  "colegiado_id"
    t.string   "nombre_documento"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "documento_id"
    t.string   "codigo_recibo"
    t.string   "concepto"
    t.float    "importe"
  end

  create_table "documento_colegios", force: :cascade do |t|
    t.integer  "colegio_id"
    t.integer  "documento_id"
    t.string   "nombre_documento"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "documentos", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "firma_1_cargo_id"
    t.integer  "firma_2_cargo_id"
    t.boolean  "documento_personal", default: true
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "codigo"
    t.string   "plantilla"
  end

  create_table "movimiento_colegiados", force: :cascade do |t|
    t.integer  "colegiado_id"
    t.text     "observaciones"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "tipo_movimiento_id"
    t.integer  "regimen_colegiado_id"
  end

  create_table "paises", force: :cascade do |t|
    t.string "nombre"
    t.string "codigo"
  end

  create_table "periods", force: :cascade do |t|
    t.string  "nombre"
    t.integer "multiplicador"
  end

  create_table "provincias", force: :cascade do |t|
    t.string "codigo"
    t.string "nombre"
  end

  create_table "recompensa_colegiados", force: :cascade do |t|
    t.integer  "colegiado_id"
    t.date     "fecha"
    t.text     "recompensa"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "regimen_colegiados", force: :cascade do |t|
    t.string  "literal"
    t.float   "importe_colegio"
    t.float   "importe_consejo"
    t.float   "porcentaje_a_pagar"
    t.integer "period_id"
  end

  create_table "tipo_movimientos", force: :cascade do |t|
    t.string "literal"
    t.string "codigo"
  end

  create_table "titulaciones", force: :cascade do |t|
    t.string "nombre"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "nombre"
    t.string   "apellidos"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "superadmin_role",        default: false
    t.boolean  "supervisor_role",        default: false
    t.boolean  "user_role",              default: true
    t.string   "username"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

end
