create table if not exists "otp_temporary_code" (
	"phone_number" varchar(255) not null primary key,
	"otp" varchar(6) not null,
	"created_at" timestamptz default now ()
);

drop table restaurant_document, restaurant_document_aud;

alter table restaurant add column document_type varchar(4) not null;
alter table restaurant add column document_value varchar(255) not null;

alter table restaurant_aud add column document_type varchar(4) not null;
alter table restaurant_aud add column document_value varchar(255) not null;

alter table staff drop column keycloak_user_ref;
alter table staff_aud drop column keycloak_user_ref;
