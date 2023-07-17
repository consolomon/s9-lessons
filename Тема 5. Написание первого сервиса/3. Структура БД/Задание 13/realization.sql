CREATE TABLE IF NOT EXISTS dds.l_order_user (
    hk_order_user_pk uuid,
    h_order_pk uuid NOT NULL,
    h_user_pk uuid NOT NULL,
    load_dt timestamp NOT NULL,
    load_src varchar(50) NOT NULL,
    PRIMARY KEY (hk_order_user_pk),
    FOREIGN KEY (h_order_pk) REFERENCES dds.h_order(h_order_pk),
    FOREIGN KEY (h_user_pk) REFERENCES dds.h_user(h_user_pk)
);