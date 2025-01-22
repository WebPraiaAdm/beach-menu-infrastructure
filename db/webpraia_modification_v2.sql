create table if not exists "otp_temporary_code" (
	"phone_number" varchar(255) not null primary key,
	"otp" varchar(6) not null,
	"created_at" timestamptz default now ()
);

create table if not exists "customer_session" (
    "id" bigint generated always as identity primary key,
    "role" varchar(150) default 'USER',
    "customer_id" bigint not null,
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

drop table restaurant_document, restaurant_document_aud;

alter table restaurant add column document_type varchar(4) not null;
alter table restaurant add column document_value varchar(255) not null;

alter table restaurant_aud add column document_type varchar(4) not null;
alter table restaurant_aud add column document_value varchar(255) not null;

alter table staff drop column keycloak_user_ref;
alter table staff_aud drop column keycloak_user_ref;
