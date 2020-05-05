import mysql.connector
import random
import string
from faker import Faker
from mysql.connector import Error
from werkzeug.security import generate_password_hash
from datetime import datetime
random_names = Faker()
date = datetime.now()
mydb_connection = mysql.connector.connect(host='localhost',
                                         database='mybook',
                                         port='3308',
                                         user='root',
                                         password='password',
                                         auth_plugin='mysql_native_password')

if mydb_connection.is_connected():
  cursor = mydb_connection.cursor()

  for x in range(499990):
    name = random_names.name().split(" ")
    firstname = name[0]
    lastname = name[1]
    email = firstname + lastname + "@notreal.com"
    datejoined = date.today()
    password = str(random.sample(string.ascii_letters+string.digits,random.randint(8,15)))
    password_ = generate_password_hash(password, method='pbkdf2:sha256')
    sql = "INSERT INTO User (fname, lname, email, pwd, datejoined) VALUES (%s,%s,%s,%s,%s)"
    val = (firstname, lastname, email,password_, datejoined)
    cursor.execute(sql, val)
    mydb_connection.commit()
    print("Record Inserted, ID:", cursor.lastrowid)