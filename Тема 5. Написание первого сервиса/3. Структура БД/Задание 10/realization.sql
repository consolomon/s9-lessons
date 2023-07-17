CREATE TABLE IF NOT EXISTS dds.l_order_product (
    hk_order_product_pk uuid,
    h_order_pk uuid NOT NULL,
    h_product_pk uuid NOT NULL,
    load_dt timestamp NOT NULL,
    load_src varchar(50) NOT NULL,
    PRIMARY KEY (hk_order_product_pk),
    FOREIGN KEY (h_order_pk) REFERENCES dds.h_order(h_order_pk),
    FOREIGN KEY (h_product_pk) REFERENCES dds.h_product(h_product_pk)
);