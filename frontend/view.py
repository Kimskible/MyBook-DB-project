import os
import mysql.connector
from flask import *
from mysql.connector import Error
from werkzeug.utils import secure_filename
from werkzeug.security import generate_password_hash



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


@app.route('/home/')
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
      sql = 'select user_id from user where email = %s and pwd = %s' 
      password_ = generate_password_hash(password, method='pbkdf2:sha256')
      cursor.execute(sql, (email,password_))
      record = cursor.fetchall()
      if record == None:
        error = 'Invalid email or password'
        session['login'] = False
      else:
        session['login'] = True
        return redirect(url_for('home'))     
    return render_template('main.html', error = error)




@app.route('/profile/')
def profile():
  return render_template('profile.html')


@app.route('/groups/')
def groups():
  return render_template('groups.html')



if __name__ == "__main__":
    app.run(debug=True, host ="localhost", port="8080")

