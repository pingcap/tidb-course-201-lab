/* source 07-demo-placement-rules-01-show.sql */

/* PREPARE 1: Stop (ctrl-c) playground-start.sh */
/* PREAPRE 2: Run playground-init-geo-01.sh */ 
/* PREPARE 3: Run playground-init-geo-02.sh */

/* Check existing lables on TiKV stores */
SELECT store_id, address, store_state_name, label
FROM information_schema.tikv_store_status;
