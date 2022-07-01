/* source 03-demo-charset-01-show.sql */

/* English Characters */
SELECT
    length('Enable Encryption for Disk Spill') as Byte_Length,
    char_length('Enable Encryption for Disk Spill') as Char_Length,
    'Enable Encryption for Disk Spill' as English,
    cast('Enable Encryption for Disk Spill' as CHAR character set gbk) as GBK_ENCODED,
    cast('Enable Encryption for Disk Spill' as CHAR character set utf8mb4) as UTF8MB4_ENCODED,
    cast(
        cast('Enable Encryption for Disk Spill' as CHAR character set gbk) 
    as binary) as GBK_BINARY,
    cast(
        cast('Enable Encryption for Disk Spill' as CHAR character set utf8mb4)
    as binary) as UTF8MB4_BINARY\G

/* Japanese Characters */
SELECT
    length('ディスク流出時の暗号化機能を有効にする') as Byte_Length,
    char_length('ディスク流出時の暗号化機能を有効にする') as Char_Length,
    'ディスク流出時の暗号化機能を有効にする' as Japanese,
    cast('ディスク流出時の暗号化機能を有効にする' as CHAR character set gbk) as GBK_ENCODED,
    cast('ディスク流出時の暗号化機能を有効にする' as CHAR character set utf8mb4) as UTF8MB4_ENCODED,
    cast(
        cast('ディスク流出時の暗号化機能を有効にする' as CHAR character set gbk) 
    as binary) as GBK_BINARY,
    cast(
        cast('ディスク流出時の暗号化機能を有効にする' as CHAR character set utf8mb4)
    as binary) as UTF8MB4_BINARY\G

/* Chinese Characters */
SELECT
    length('为磁盘溢出启用加密') as Byte_Length,
    char_length('为磁盘溢出启用加密') as Char_Length,
    '为磁盘溢出启用加密' as Chinese,
    cast('为磁盘溢出启用加密' as CHAR character set gbk) as GBK_ENCODED,
    cast('为磁盘溢出启用加密' as CHAR character set utf8mb4) as UTF8MB4_ENCODED,
    cast(
        cast('为磁盘溢出启用加密' as CHAR character set gbk) 
    as binary) as GBK_BINARY,
    cast(
        cast('为磁盘溢出启用加密' as CHAR character set utf8mb4)
    as binary) as UTF8MB4_BINARY\G
