CREATE TABLE IF NOT EXISTS dds.l_product_restaurant (
    hk_product_restaurant_pk uuid,
    h_restaurant_pk uuid NOT NULL,
    h_product_pk uuid NOT NULL,
    load_dt timestamp NOT NULL,
    load_src varchar(50) NOT NULL,
    PRIMARY KEY (hk_product_restaurant_pk),
    FOREIGN KEY (h_restaurant_pk) REFERENCES dds.h_restaurant(h_restaurant_pk),
    FOREIGN KEY (h_product_pk) REFERENCES dds.h_product(h_product_pk)
);