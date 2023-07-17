CREATE TABLE IF NOT EXISTS cdm.user_product_counters (
    id serial,
    user_id uuid NOT NULL,
    product_id uuid NOT NULL,
    product_name varchar(255) NOT NULL,
    order_cnt integer NOT NULL CHECK (order_cnt >= 0),
    PRIMARY KEY (id),
    UNIQUE (user_id, product_id)
)