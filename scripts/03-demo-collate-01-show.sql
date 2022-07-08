/* source 03-demo-collate-01-show.sql */

/* Observe the result */
SELECT 
    'A'='a' collate utf8mb4_bin, 
    'A'='a' collate utf8mb4_general_ci, 
    'A'='a'\G
