CREATE TABLE IF NOT EXISTS dds.s_product_names (
    hk_product_names_hashdiff uuid,
    h_product_pk uuid NOT NULL,
    "name" varchar(255) NOT NULL,
    load_dt timestamp NOT NULL,
    load_src varchar(50) NOT NULL,
    PRIMARY KEY (hk_product_names_hashdiff),
    FOREIGN KEY (h_product_pk) REFERENCES dds.h_product(h_product_pk)
);