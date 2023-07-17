CREATE TABLE IF NOT EXISTS dds.l_product_category (
    hk_product_category_pk uuid,
    h_category_pk uuid NOT NULL,
    h_product_pk uuid NOT NULL,
    load_dt timestamp NOT NULL,
    load_src varchar(50) NOT NULL,
    PRIMARY KEY (hk_product_category_pk),
    FOREIGN KEY (h_category_pk) REFERENCES dds.h_category(h_category_pk),
    FOREIGN KEY (h_product_pk) REFERENCES dds.h_product(h_product_pk)
);