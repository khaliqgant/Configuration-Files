$dry brew services start mysql

echo "Once mysql is running, run the following manually:"
echo "  mysql_secure_installation"
echo "  ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '{password}';"
