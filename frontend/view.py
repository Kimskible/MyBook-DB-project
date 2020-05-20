import os
import mysql.connector
from flask import *
from mysql.connector import Error
from werkzeug.utils import secure_filename
from werkzeug.security import generate_password_hash
import re
from datetime import datetime



app = Flask(__name__)
app.secret_key  = "SECRET KEY"


mydb_connection = mysql.connector.connect(host='localhost',
                                         database='mybook',
                                         port='3308',
                                         user='root',
                                         password='password',
                                         auth_plugin='mysql_native_password')

if mydb_connection.is_connected():
  cursor = mydb_connection.cursor()

@app.route('/')
def main():
  return render_template("main.html")


@app.route('/home/', methods=["POST"])
def home():
  if session['login']:
    return render_template('home.html')
  else:
    return render_template('main.html')



@app.route('/login', methods=['POST', 'GET'])
def login():
    error = None
    if request.method == 'POST':
      email = request.form['email']
      password = request.form['password']
      password_ =str((sum(list(map(ord, password))) * 97))
      sql = 'select * from user where email = "'+email+'" and pwd = "pbkdf2:sha256:'+password_+'$YfVqtHQJ$"'
      print(sql)
      cursor.execute(sql)
      record = cursor.fetchall()
      if cursor.rowcount <= 0:
        error = 'Invalid email or password'
        session['login'] = False
      else:
        session['login'] = True
        print(record)
        session['user_id'] = record[0][0]
        session['fname'] = record[0][1]
        session['lname'] = record[0][2]
        session['email'] = record[0][3]

        return redirect(url_for('home'))     
    return render_template('main.html', error = error)



@app.route('/register', methods = ['POST'])
def register():
  if request.method == 'POST':
    fname = request.form['fname']
    lname = request.form['lname']
    email = request.form['email']
    password = request.form['password']
    con_pass = request.form['con_pass']

    if re.search('^[A-Za-z]+$',fname):
      if re.search('^[A-Za-z]+$',lname):
        print("name is ok")
        if re.search('^\w+@[a-zAzZ]+?\.[a-zA-Z]{2,3}$', email):
          sql = 'select user_id from user where email = "%s";'
          cursor.execute(sql, (email))
          record = cursor.fetchall()
          print(cursor.rowcount, "email is ok")

          if cursor.rowcount >= 1:
            print("Email Already Exist")
          else:
            if re.search('^[a-zA-z]\w{8,25}', password):
              if con_pass == password:
                print("password is ok")
                sql = 'insert into user (fname, lname, email, pwd, datejoined) values (%s,%s,%s,%s,%s);'
                password_ =str((sum(list(map(ord, password))) * 97))
                password_ = 'pbkdf2:sha256:'+password_+'$YfVqtHQJ$'

                cursor.execute(sql, (fname, lname, email, password_, datetime.now()))
                sql = 'select * from user where email = "'+str(email)+'";'
                cursor.execute(sql)
                record = cursor.fetchall()  
                session['login'] = True
                session['user_id'] = record[0][0]
                session['fname'] = record[0][1]
                session['lname'] = record[0][2]
                session['email'] = record[0][3]
                sql = 'insert into profile (user_id, dob, bio, gender) values ('+str(session['user_id'])+',"date of birth","tell me about yourself" ,"M/F");'
                cursor.execute(sql);
                return profile()     
    return render_template('main.html', error = error)



@app.route('/profile/', methods=["POST", "GET"])
def profile():
  fname=session['fname']
  lname=session['lname']
  email=session['email']
  sql = 'select * from profile where user_id = '+ str(session['user_id'])+';'
  print(sql)
  cursor.execute(sql)
  record = cursor.fetchall()
  dob = record[0][2]
  bio = record[0][3]
  gender = record[0][4]
  return render_template('profile.html',fname=fname, lname=lname, email=email, dob= dob, gender=gender, bio=bio)


@app.route('/EditProfile', methods=['POST','GET'])
def EditProfile():

  dob = request.form['dob']
  gender = request.form['gender']
  bio = request.form['bio']
  sql = 'update profile set dob=%s, bio = %s, gender = %s where user_id = %s;'
  cursor.execute(sql, (dob, bio, gender, session['user_id']))
  return render_template('profile.html', fname=session['fname'], lname=session['lname'], email=session['email'], dob=dob, gender=gender, bio=bio)






@app.route('/groups/')
def groups():
  return render_template('groups.html')



if __name__ == "__main__":
    app.run(debug=True, host ="localhost", port="8080")

