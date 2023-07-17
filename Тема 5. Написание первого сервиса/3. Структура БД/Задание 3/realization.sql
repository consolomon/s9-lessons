CREATE TABLE IF NOT EXISTS cdm.user_category_counters (
    id serial,
    user_id uuid NOT NULL,
    category_id uuid NOT NULL,
    category_name varchar(255) NOT NULL,
    order_cnt integer NOT NULL CHECK (order_cnt >= 0),
    PRIMARY KEY (id),
    UNIQUE (user_id, category_id)
)