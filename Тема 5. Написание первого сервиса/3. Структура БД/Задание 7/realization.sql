CREATE TABLE IF NOT EXISTS dds.h_category (
    h_category_pk uuid,
    category_name varchar(255) NOT NULL,
    load_dt timestamp NOT NULL,
    load_src varchar(50) NOT NULL,
    PRIMARY KEY (h_category_pk),
    UNIQUE (category_name)
)