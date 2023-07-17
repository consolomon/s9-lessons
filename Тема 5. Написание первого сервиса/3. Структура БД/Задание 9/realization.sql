CREATE TABLE IF NOT EXISTS dds.h_order (
    h_order_pk uuid,
    order_id integer NOT NULL,
    order_dt timestamp NOT NULL,
    load_dt timestamp NOT NULL,
    load_src varchar(50) NOT NULL,
    PRIMARY KEY (h_order_pk),
    UNIQUE (order_id)
)