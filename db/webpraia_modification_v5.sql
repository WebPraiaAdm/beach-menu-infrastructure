alter table order_item add column "order_item_status" varchar(100) not null default 'PENDING';
alter table order_item_aud add column "order_item_status" varchar(100) not null default 'PENDING';

alter table customer_session drop column "role";
alter table customer_session_aud drop column "role";

create table if not exists "admin_session" (
    "id" bigint generated always as identity primary key,
    "role" varchar(150),
    "staff_id" bigint not null,
    "name" varchar(255) not null,
    "refresh_token" text not null,
    "expiration" timestamptz not null,
    "revoked" boolean not null default false,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    "deleted_at" timestamptz default null,
    "created_by" varchar(255) not null,
    "updated_by" varchar(255) not null,
    "deleted_by" varchar(255) default null
);

create table if not exists "admin_session_aud" (
    "id" bigint generated always as identity primary key,
    "role" varchar(150),
    "staff_id" bigint not null,
    "name" varchar(255) not null,
    "refresh_token" text not null,
    "expiration" timestamptz not null,
    "revoked" boolean not null default false,
    "created_at" timestamptz default now(),
    "updated_at" timestamptz default now(),
    "deleted_at" timestamptz default null,
    "created_by" varchar(255) not null,
    "updated_by" varchar(255) not null,
    "deleted_by" varchar(255) default null,
    "rev" int not null,
    "revtype" smallint null
);

alter table staff drop column "is_owner";
alter table staff_aud drop column "is_owner";