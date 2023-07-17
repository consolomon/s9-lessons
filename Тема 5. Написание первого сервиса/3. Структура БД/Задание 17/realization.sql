CREATE TABLE IF NOT EXISTS dds.s_order_cost (
    hk_order_cost_hashdiff uuid,
    h_order_pk uuid NOT NULL,
    "cost" decimal(19, 5) NOT NULL CHECK ("cost" >= 0),
    payment decimal(19, 5) NOT NULL CHECK (payment >= 0),
    load_dt timestamp NOT NULL,
    load_src varchar(50) NOT NULL,
    PRIMARY KEY (hk_order_cost_hashdiff),
    FOREIGN KEY (h_order_pk) REFERENCES dds.h_order(h_order_pk)
);