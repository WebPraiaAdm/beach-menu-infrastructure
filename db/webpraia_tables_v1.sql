-- create type subscription_type as enum ('Basic', 'Premium');
-- create type document_type as enum ('CPF', 'CNPJ');
-- create type product_type as enum ('Entrada', 'Prato Principal', 'Bebida Não Alcoólica', 'Bebida Alcoólica', 'Sobremesa');
-- create type payment_method as enum('PIX', 'Cartão de Crédito', 'Cartão de Débito', 'Dinheiro', 'Vale Refeição', 'Restaurante');
-- create type order_status as enum ('Aberto', 'Aguardando Pagamento', 'Confirmado', 'Cancelado', 'Finalizado');
-- create type voucher_discount_type as enum ('Percentual', 'Fixo');

create table if not exists "subscription" (
    "id" bigint generated always as identity primary key,
    "name" varchar(100),
    "charge" decimal(10, 2) not null,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    "deleted_at" timestamptz default null,
    "created_by" varchar(255) not null,
    "updated_by" varchar(255) not null,
    "deleted_by" varchar(255) default null
);

create table if not exists "customer" (
    "id" bigint generated always as identity primary key,
    "name" varchar(255) not null,
    "email" varchar(255) not null,
    "phone_number" varchar(255) not null,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    "deleted_at" timestamptz default null,
    "created_by" varchar(255) not null,
    "updated_by" varchar(255) not null,
    "deleted_by" varchar(255) default null
);

create table if not exists "restaurant" (
    "id" varchar(255) primary key,
    "name" varchar(255) not null,
    "trade_name" varchar(255) default null,
    "pix_key" text not null,
    "active" boolean default true,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    "deleted_at" timestamptz default null,
    "created_by" varchar(255) not null,
    "updated_by" varchar(255) not null,
    "deleted_by" varchar(255) default null
);

create table if not exists "contract" (
    "id" bigint generated always as identity primary key,
    "subscription_id" bigint references "subscription"(id),
    "restaurant_id" varchar(255) references "restaurant"(id) not null,
    "start_date" timestamptz not null default now(),
    "ending_date" timestamptz not null,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    "deleted_at" timestamptz default null,
    "created_by" varchar(255) not null,
    "updated_by" varchar(255) not null,
    "deleted_by" varchar(255) default null
);


create table if not exists "restaurant_metrics" (
    "id" bigint generated always as identity primary key,
    "restaurant_id" varchar(255) references "restaurant"(id) not null,
    "opening_time" time not null,
    "closing_time" time not null,
    "opening_date" date default now(),
    "average_order_value" decimal(10, 2) default 0.00,
    "total_orders" int default 0,
    "total_revenue" decimal(10, 2) default 0.00,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    "deleted_at" timestamptz default null,
    "created_by" varchar(255) not null,
    "updated_by" varchar(255) not null,
    "deleted_by" varchar(255) default null
);

create table if not exists "restaurant_table" (
    "id" bigint generated always as identity primary key,
    "restaurant_id" varchar(255) references "restaurant"(id) not null,
    "table_number" int not null,
    "table_hash" varchar(255) not null,
    "capacity" int not null,
    "paid_on_restaurant" boolean not null default false, -- Verificar o que isso significa e se é necessário esse atributo, ou é um atributo de conta
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    "deleted_at" timestamptz default null,
    "created_by" varchar(255) not null,
    "updated_by" varchar(255) not null,
    "deleted_by" varchar(255) default null
);

create table if not exists "product" (
    "id" bigint generated always as identity primary key,
    "restaurant_id" varchar(255) references "restaurant"(id) not null,
    "name" varchar(255) not null,
    "price" decimal(10, 2) not null,
    "description" text default null,
    "type" varchar(200) not null,
    "active" boolean default true,
    "image_url" text default null,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    "deleted_at" timestamptz default null,
    "created_by" varchar(255) not null,
    "updated_by" varchar(255) not null,
    "deleted_by" varchar(255) default null
);

create table if not exists "voucher" (
    "id" bigint generated always as identity primary key,
    "name" varchar(255) not null,
    "discount_type" varchar(100),
    "discount_value" decimal(10, 2) not null,
    "starting_date" timestamptz default now(),
    "ending_date" timestamptz default null,
    "times_used" bigint not null default 0,
    "allowed_usages" bigint not null default 0,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    "deleted_at" timestamptz default null,
    "created_by" varchar(255) not null,
    "updated_by" varchar(255) not null,
    "deleted_by" varchar(255) default null
);

create table if not exists "order" (
    "id" bigint generated always as identity primary key,
    "voucher_id" bigint references "voucher"(id) default null,
    "order_number" int not null,
    "restaurant_id" varchar(255) references "restaurant"(id) not null,
    "customer_id" bigint references "customer"(id) not null,
    "table_id" bigint references "restaurant_table"(id) not null,
    "order_opened_date" timestamptz default now(),
    "order_closed_date" timestamptz default now(),
    "payment_method" varchar(200),
    "paid" boolean default false,
    "total_paid" decimal(10, 2) default 0,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    "deleted_at" timestamptz default null,
    "created_by" varchar(255) not null,
    "updated_by" varchar(255) not null,
    "deleted_by" varchar(255) default null
);

create table if not exists "order_item" (
    "id" bigint generated always as identity primary key,
    "order_id" bigint references "order"(id) not null,
    "product_id" bigint references "product"(id) not null,
    "order_status" varchar(100),
    "total_amount" decimal(10, 2) default 0,
    "quantity" int not null,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    "deleted_at" timestamptz default null,
    "created_by" varchar(255) not null,
    "updated_by" varchar(255) not null,
    "deleted_by" varchar(255) default null
);

create table if not exists "restaurant_document" (
    "id" bigint generated always as identity primary key,
    "restaurant_id" varchar(255) references "restaurant"(id) not null,
    "type" varchar(4) not null,
    "value" varchar(255) not null,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    "deleted_at" timestamptz default null,
    "created_by" varchar(255) not null,
    "updated_by" varchar(255) not null,
    "deleted_by" varchar(255) default null
);

create table if not exists "address" (
    "id" bigint generated always as identity primary key,
    "restaurant_id" varchar(255) references "restaurant"(id) not null,
    "street" varchar(255) not null,
    "neighborhood" varchar(255) not null,
    "number" varchar(255) not null,
    "cep" varchar(255) not null,
    "state" varchar(255) not null,
    "city" varchar(255) not null,
    "complement" varchar(255) default null,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    "deleted_at" timestamptz default null,
    "created_by" varchar(255) not null,
    "updated_by" varchar(255) not null,
    "deleted_by" varchar(255) default null
);

create table if not exists "staff" (
    "id" bigint generated always as identity primary key,
    "restaurant_id" varchar(255) references "restaurant"(id) not null,
    "name" varchar(255) not null,
    "email" varchar(255) not null,
    "password" varchar(255) not null,
    "function" varchar(150) not null,
    "is_owner" boolean not null default false,
    "keycloak_user_ref" varchar(255) not null,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    "deleted_at" timestamptz default null,
    "created_by" varchar(255) not null,
    "updated_by" varchar(255) not null,
    "deleted_by" varchar(255) default null
);

comment on column "restaurant"."trade_name" is 'Nome fantasia';
comment on column "customer"."name" is 'Nome encriptado';
comment on column "customer"."email" is 'email encriptado';
comment on column "customer"."phone_number" is 'Telefone encriptado';
comment on column "restaurant"."pix_key" is 'Chave pix encriptada caso o cliente tenha CPF e não uma chave para o comércio';
comment on column "restaurant_document"."value" is 'Documento encriptado';
comment on column "address"."street" is 'Rua encriptada';
comment on column "address"."neighborhood" is 'Bairro encriptado';
comment on column "address"."number" is 'Número encriptado';
comment on column "address"."cep" is 'CEP encriptado';
comment on column "address"."state" is 'Estado encriptado';
comment on column "address"."city" is 'Cidade encriptada';
comment on column "address"."complement" is 'Complemento encriptado';
comment on column "staff"."name" is 'Nome encriptado';
comment on column "staff"."email" is 'Email encriptado';

create index idx_table_hash on "restaurant_table" ("table_hash");
create index idx_voucher_name on "voucher"("name");
