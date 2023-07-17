CREATE TABLE IF NOT EXISTS dds.h_product (
    h_product_pk uuid,
    product_id varchar(255) NOT NULL,
    load_dt timestamp NOT NULL,
    load_src varchar(50) NOT NULL,
    PRIMARY KEY (h_product_pk),
    UNIQUE (product_id)
)