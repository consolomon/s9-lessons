CREATE TABLE IF NOT EXISTS dds.s_restaurant_names (
    hk_restaurant_names_hashdiff uuid,
    h_restaurant_pk uuid NOT NULL,
    "name" varchar(255) NOT NULL,
    load_dt timestamp NOT NULL,
    load_src varchar(50) NOT NULL,
    PRIMARY KEY (hk_restaurant_names_hashdiff),
    FOREIGN KEY (h_restaurant_pk) REFERENCES dds.h_restaurant(h_restaurant_pk)
);