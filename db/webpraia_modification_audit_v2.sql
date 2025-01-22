create table if not exists "customer_session_aud" (
    "id" bigint,
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
    "deleted_by" varchar(255) default null,
    "rev" int not null,
    "revtype" smallint null
); 