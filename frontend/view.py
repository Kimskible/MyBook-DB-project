from flask import Flask, redirect, url_for, render_template

app = Flask(__name__)

@app.route('/main/')
def main():
  return render_template("main.html")


@app.route('/home/')
def home():
  return render_template('home.html')


@app.route('/profile/')
def profile():
  return render_template('profile.html')


@app.route('/groups/')
def groups():
  return render_template('groups.html')


















if __name__ == "__main__":
    app.run(debug=True, host ="localhost", port="8080")

