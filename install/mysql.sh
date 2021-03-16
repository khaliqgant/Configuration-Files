$dry brew services start mysql
$dry mysql_secure_installation

echo "login with the password inputted"
echo "Run the following command:"
echo "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '{password}';"
