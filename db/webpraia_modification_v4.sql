alter table product add column "parent_id" bigint default null;
alter table product_aud add column "parent_id" bigint default null;

alter table order_item drop column "order_status";
alter table order_item_aud drop column "order_status";

alter table "order" add column "order_status" varchar(100) not null default 'PENDING';
alter table order_aud add column "order_status" varchar(100) not null default 'PENDING';