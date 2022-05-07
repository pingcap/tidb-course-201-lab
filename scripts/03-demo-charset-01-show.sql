/* source 03-demo-charset-01-show.sql */

/* Chinese Characters */
SELECT
    length('曹操') as Byte_Length,
    char_length('曹操') as Char_Length,
    '曹操' as Chinese,
    cast('曹操' as CHAR character set gbk) as GBK_ENCODED,
    cast('曹操' as CHAR character set utf8mb4) as UTF8MB4_ENCODED,
    cast(
        cast('曹操' as CHAR character set gbk) 
    as binary) as GBK_BINARY,
    cast(
        cast('曹操' as CHAR character set utf8mb4)
    as binary) as UTF8MB4_BINARY\G

/* Japanese Characters */
SELECT
    length('うぬぼれ刑事') as Byte_Length,
    char_length('うぬぼれ刑事') as Char_Length,
    'うぬぼれ刑事' as Japanese,
    cast('うぬぼれ刑事' as CHAR character set gbk) as GBK_ENCODED,
    cast('うぬぼれ刑事' as CHAR character set utf8mb4) as UTF8MB4_ENCODED,
    cast(
        cast('うぬぼれ刑事' as CHAR character set gbk) 
    as binary) as GBK_BINARY,
    cast(
        cast('うぬぼれ刑事' as CHAR character set utf8mb4)
    as binary) as UTF8MB4_BINARY\G

/* English Characters */
SELECT
    length('Supreme Commander') as Byte_Length,
    char_length('Supreme Commander') as Char_Length,
    'Supreme Commander' as English,
    cast('Supreme Commander' as CHAR character set gbk) as GBK_ENCODED,
    cast('Supreme Commander' as CHAR character set utf8mb4) as UTF8MB4_ENCODED,
    cast(
        cast('Supreme Commander' as CHAR character set gbk) 
    as binary) as GBK_BINARY,
    cast(
        cast('Supreme Commander' as CHAR character set utf8mb4)
    as binary) as UTF8MB4_BINARY\G
