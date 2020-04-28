# import sys
# print(sys.path)
import mysql.connector
from faker import Faker
from mysql.connector import Error
from werkzeug.security import generate_password_hash
from datetime import datetime

date = datetime.now()

mydb_connection = mysql.connector.connect(
  host="localhost",
  user="root",
  pwd=" ",
  database="mybook"
)