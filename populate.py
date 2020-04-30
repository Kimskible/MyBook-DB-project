# import sys
# print(sys.path)
import mysql.connector
from faker import Faker
from mysql.connector import Error
from werkzeug.security import generate_password_hash
from datetime import datetime
random_names = Faker()
date = datetime.now()
mydb_connection = mysql.connector.connect(host="localhost",
                                          user="root",
                                          password="",
                                          database="mybook"
                                          # auth_plugin="mysql_native_password"
                                          )

if mydb_connection.is_connected():
  cursor = db_connection.cursor()
  for _ in range(10):
    name = random_names.name().split(" ")
    firstname = name[0]
    lastname = name[1]
    email = firstname + lastname + "@notreal.com"
    password = "password123"
    password_ = generate_password_hash(pwd, method = "pdkdf2:sha256")
    sql = "INSERT INTO User (fname, lname, email, password, datejoined) VALUES (%s,%s,%s,%s,%s)"
    val = ("firstname", "lastname", "email","password_", "datejoined")
    cursor.execute(sql, val)
    connection.commit()
    print("Record Inserted, ID:", cursor.lastrowid)