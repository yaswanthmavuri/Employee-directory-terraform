from flask import Flask, request, redirect, render_template_string
import sqlite3

app = Flask(__name__)

def init_db():
    conn = sqlite3.connect('employees.db')
    c = conn.cursor()
    c.execute('CREATE TABLE IF NOT EXISTS employees (name TEXT)')
    conn.commit()
    conn.close()

@app.route('/')
def home():
    conn = sqlite3.connect('employees.db')
    c = conn.cursor()
    c.execute('SELECT name FROM employees')
    employees = c.fetchall()
    conn.close()
    return render_template_string("""
    <html>
    <head>
        <title>Employee Management</title>
        <style>
            body { font-family: Arial; background: #eef2f7; }
            .container {
                width: 400px;
                margin: 50px auto;
                padding: 20px;
                background: white;
                border-radius: 10px;
                text-align: center;
            }
            input { padding: 10px; width: 60%; }
            button { padding: 10px; background: blue; color: white; border: none; }
            li { margin: 10px; list-style-type: none; }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Employee Management</h2>
            <form method="POST" action="/add">
                <input type="text" name="name" placeholder="Enter name" required>
                <button type="submit">Add Employee</button>
            </form>
            <h3>Employee List</h3>
            <ul>
                {% for emp in employees %}
                    <li>{{ emp[0] }}</li>
                {% endfor %}
            </ul>
        </div>
    </body>
    </html>
    """, employees=employees)

@app.route('/add', methods=['POST'])
def add_employee():
    name = request.form.get('name')
    conn = sqlite3.connect('employees.db')
    c = conn.cursor()
    c.execute('INSERT INTO employees (name) VALUES (?)', (name,))
    conn.commit()
    conn.close()
    return redirect('/')

if __name__ == '__main__':
    init_db()
    app.run(host='0.0.0.0', port=5000)