CREATE TABLE IF NOT EXISTS dds.h_restaurant (
    h_restaurant_pk uuid,
    restaurant_id varchar(255) NOT NULL,
    load_dt timestamp NOT NULL,
    load_src varchar(50) NOT NULL,
    PRIMARY KEY (h_restaurant_pk),
    UNIQUE (restaurant_id)
)