CREATE TABLE IF NOT EXISTS dds.h_user (
    h_user_pk uuid,
    user_id varchar(255) NOT NULL,
    load_dt timestamp NOT NULL,
    load_src varchar(50) NOT NULL,
    PRIMARY KEY (h_user_pk),
    UNIQUE (user_id)
)