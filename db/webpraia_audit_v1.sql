create table if not exists "subscription_aud" (
    "id" bigint,
    "name" varchar(100),
    "charge" decimal(10, 2) not null,
    "created_at" timestamp default now(),
    "updated_at" timestamp default now(),
    "deleted_at" timestamp default null,
    "created_by" varchar(255) not null,
    "updated_by" varchar(255) not null,
    "deleted_by" varchar(255) default null,
    "rev" int not null,
    "revtype" smallint null
);

create table if not exists "customer_aud" (
    "id" bigint,
    "name" varchar(255) not null,
    "email" varchar(255) not null,
    "phone_number" varchar(255) not null,
    "created_at" timestamp default now(),
    "updated_at" timestamp default now(),
    "deleted_at" timestamp default null,
    "created_by" varchar(255) not null,
    "updated_by" varchar(255) not null,
    "deleted_by" varchar(255) default null,
    "rev" int not null,
    "revtype" smallint null
);

create table if not exists "restaurant_aud" (
    "id" varchar(255),
    "subscription_id" bigint references "subscription"(id),
    "name" varchar(255) not null,
    "trade_name" varchar(255) default null,
    "pix_key" text not null,
    "active" boolean default true,
    "created_at" timestamp default now(),
    "updated_at" timestamp default now(),
    "deleted_at" timestamp default null,
    "created_by" varchar(255) not null,
    "updated_by" varchar(255) not null,
    "deleted_by" varchar(255) default null,
    "rev" int not null,
    "revtype" smallint null
);

create table if not exists "contract_aud" (
    "id" bigint generated always as identity primary key,
    "subscription_id" bigint references "subscription"(id),
    "restaurant_id" varchar(255) references "restaurant"(id) not null,
    "start_date" timestamptz not null default now(),
    "ending_date" timestamptz not null,
    "created_at" timestamp default now(),
    "updated_at" timestamp default now(),
    "deleted_at" timestamp default null,
    "created_by" varchar(255) not null,
    "updated_by" varchar(255) not null,
    "deleted_by" varchar(255) default null,
    "rev" int not null,
    "revtype" smallint null
);

create table if not exists "restaurant_metrics_aud" (
    "id" bigint,
    "restaurant_id" varchar(255) references "restaurant"(id) not null,
    "opening_time" time not null,
    "closing_time" time not null,
    "opening_date" date default now(),
    "average_order_value" decimal(10, 2) default 0.00,
    "total_orders" int default 0,
    "total_revenue" decimal(10, 2) default 0.00,
    "created_at" timestamp default now(),
    "updated_at" timestamp default now(),
    "deleted_at" timestamp default null,
    "created_by" varchar(255) not null,
    "updated_by" varchar(255) not null,
    "deleted_by" varchar(255) default null,
    "rev" int not null,
    "revtype" smallint null
);

create table if not exists "restaurant_table_aud" (
    "id" bigint,
    "restaurant_id" varchar(255) references "restaurant"(id) not null,
    "table_number" int not null,
    "table_hash" varchar(255) not null,
    "capacity" int not null,
    "paid_on_restaurant" boolean not null default false,
    "created_at" timestamp default now(),
    "updated_at" timestamp default now(),
    "deleted_at" timestamp default null,
    "created_by" varchar(255) not null,
    "updated_by" varchar(255) not null,
    "deleted_by" varchar(255) default null,
    "rev" int not null,
    "revtype" smallint null
);

create table if not exists "product_aud" (
    "id" bigint,
    "restaurant_id" varchar(255) references "restaurant"(id) not null,
    "name" varchar(255) not null,
    "price" decimal(10, 2) not null,
    "description" text default null,
    "type" varchar(200) not null,
    "active" boolean default true,
    "image_url" text default null,
    "created_at" timestamp default now(),
    "updated_at" timestamp default now(),
    "deleted_at" timestamp default null,
    "created_by" varchar(255) not null,
    "updated_by" varchar(255) not null,
    "deleted_by" varchar(255) default null,
    "rev" int not null,
    "revtype" smallint null
);

create table if not exists "order_aud" (
    "id" bigint,
    "order_number" int not null,
    "restaurant_id" varchar(255) references "restaurant"(id) not null,
    "customer_id" bigint references "customer"(id) not null,
    "table_id" bigint references "restaurant_table"(id) not null,
    "voucher_id" bigint references "voucher"(id) default null,
    "order_opened_date" timestamp default now(),
    "order_closed_date" timestamp default now(),
    "payment_method" varchar(200),
    "paid" boolean default false,
    "total_paid" decimal(10, 2) default 0,
    "created_at" timestamp default now(),
    "updated_at" timestamp default now(),
    "deleted_at" timestamp default null,
    "created_by" varchar(255) not null,
    "updated_by" varchar(255) not null,
    "deleted_by" varchar(255) default null,
    "rev" int not null,
    "revtype" smallint null
);

create table if not exists "voucher_aud" (
    "id" bigint,
    "name" varchar(255) not null,
    "discount_type" varchar(100),
    "discount_value" decimal(10, 2) not null,
    "starting_date" timestamp default now(),
    "ending_date" timestamp default null,
    "times_used" bigint not null default 0,
    "allowed_usages" bigint not null default 0,
    "created_at" timestamp default now(),
    "updated_at" timestamp default now(),
    "deleted_at" timestamp default null,
    "created_by" varchar(255) not null,
    "updated_by" varchar(255) not null,
    "deleted_by" varchar(255) default null,
    "rev" int not null,
    "revtype" smallint null
);

create table if not exists "order_item_aud" (
    "id" bigint,
    "order_id" bigint references "order"(id) not null,
    "product_id" bigint references "product"(id) not null,
    "order_status" varchar(100),
    "quantity" int not null,
    "total_amount" decimal(10, 2) default 0,
    "created_at" timestamp default now(),
    "updated_at" timestamp default now(),
    "deleted_at" timestamp default null,
    "created_by" varchar(255) not null,
    "updated_by" varchar(255) not null,
    "deleted_by" varchar(255) default null,
    "rev" int not null,
    "revtype" smallint null
);

create table if not exists "restaurant_document_aud" (
    "id" bigint,
    "restaurant_id" varchar(255) references "restaurant"(id) not null,
    "type" varchar(4) not null,
    "value" varchar(255) not null,
    "created_at" timestamp default now(),
    "updated_at" timestamp default now(),
    "deleted_at" timestamp default null,
    "created_by" varchar(255) not null,
    "updated_by" varchar(255) not null,
    "deleted_by" varchar(255) default null,
    "rev" int not null,
    "revtype" smallint null
);

create table if not exists "address_aud" (
    "id" bigint,
    "restaurant_id" varchar(255) references "restaurant"(id) not null,
    "street" varchar(255) not null,
    "neighborhood" varchar(255) not null,
    "number" varchar(255) not null,
    "cep" varchar(255) not null,
    "state" varchar(255) not null,
    "city" varchar(255) not null,
    "complement" varchar(255) default null,
    "created_at" timestamp default now(),
    "updated_at" timestamp default now(),
    "deleted_at" timestamp default null,
    "created_by" varchar(255) not null,
    "updated_by" varchar(255) not null,
    "deleted_by" varchar(255) default null,
    "rev" int not null,
    "revtype" smallint null
);

create table if not exists "staff_aud" (
    "id" bigint,
    "restaurant_id" varchar(255) references "restaurant"(id) not null,
    "name" varchar(255) not null,
    "email" varchar(255) not null,
    "password" varchar(255) not null,
    "function" varchar(150) not null,
    "is_owner" boolean not null default false,
    "keycloak_user_ref" varchar(255) not null,
    "created_at" timestamp default now(),
    "updated_at" timestamp default now(),
    "deleted_at" timestamp default null,
    "created_by" varchar(255) not null,
    "updated_by" varchar(255) not null,
    "deleted_by" varchar(255) default null,
    "rev" int not null,
    "revtype" smallint null
);

create table if not exists "revinfo" (
    rev int,
    revtstmp bigint null
);

create sequence public.revinfo_seq
    increment by 50
    minvalue 1
    maxvalue 9223372036854775807
    start 1
    cache 1
    no cycle;
