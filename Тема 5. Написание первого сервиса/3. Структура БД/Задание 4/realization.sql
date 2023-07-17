CREATE TABLE IF NOT EXISTS stg.order_events (
    id serial,
    object_id uuid NOT NULL,
    object_type varchar(50) NOT NULL,
    sent_dttm timestamp(3) NOT NULL,
    payload json NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (object_id)
)