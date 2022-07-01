/* source 03-demo-charset-01-show.sql */

/* English Characters */
SELECT
    length('Hello') as Byte_Length,
    char_length('Hello') as Char_Length,
    'Hello' as English,
    cast('Hello' as CHAR character set gbk) as GBK_ENCODED,
    cast('Hello' as CHAR character set utf8mb4) as UTF8MB4_ENCODED,
    cast(
        cast('Hello' as CHAR character set gbk) 
    as binary) as GBK_BINARY,
    cast(
        cast('Hello' as CHAR character set utf8mb4)
    as binary) as UTF8MB4_BINARY\G

/* Japanese Characters */
SELECT
    length('こんにちは') as Byte_Length,
    char_length('こんにちは') as Char_Length,
    'こんにちは' as Japanese,
    cast('こんにちは' as CHAR character set gbk) as GBK_ENCODED,
    cast('こんにちは' as CHAR character set utf8mb4) as UTF8MB4_ENCODED,
    cast(
        cast('こんにちは' as CHAR character set gbk) 
    as binary) as GBK_BINARY,
    cast(
        cast('こんにちは' as CHAR character set utf8mb4)
    as binary) as UTF8MB4_BINARY\G

/* Chinese Characters */
SELECT
    length('你好') as Byte_Length,
    char_length('你好') as Char_Length,
    '你好' as Chinese,
    cast('你好' as CHAR character set gbk) as GBK_ENCODED,
    cast('你好' as CHAR character set utf8mb4) as UTF8MB4_ENCODED,
    cast(
        cast('你好' as CHAR character set gbk) 
    as binary) as GBK_BINARY,
    cast(
        cast('你好' as CHAR character set utf8mb4)
    as binary) as UTF8MB4_BINARY\G
