<html>

<body>
  <h1>Demo PHP Connection Serverless</h1>
  <?php
  echo "PDO_MySQL Example for TiDB Serverless" . "<p>";

  $host = $argv[1];
  $port = 4000;
  $user = $argv[2];
  $password = $argv[3];
  try {
    $dsname = "mysql:host=$host;port=$port;dbname=test";
    $dbhandle = new PDO($dsname, $user, $password, array(PDO::MYSQL_ATTR_SSL_VERIFY_SERVER_CERT => 1, PDO::MYSQL_ATTR_SSL_CA => "/etc/ssl/cert.pem"));
    print "Connection established.<p>";
    print "End.";
  } catch (PDOException $err) {
    die($err);
  }

  ?>

</body>

</html>