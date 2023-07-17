CREATE TABLE IF NOT EXISTS dds.s_order_status (
    hk_order_status_hashdiff uuid,
    h_order_pk uuid NOT NULL,
    status varchar(50) NOT NULL,
    load_dt timestamp NOT NULL,
    load_src varchar(50) NOT NULL,
    PRIMARY KEY (hk_order_status_hashdiff),
    FOREIGN KEY (h_order_pk) REFERENCES dds.h_order(h_order_pk)
);