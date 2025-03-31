drop table if exists "admin_session_aud";

create table if not exists "admin_session_aud" (
    "id" bigint,
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