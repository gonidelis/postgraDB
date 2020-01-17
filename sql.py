from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)


#app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_DATABASE_URI'] = "mysql+pymysql://admin:password@127.0.0.1/postgradb?host=127.0.0.1?port=3306"
db = SQLAlchemy(app)

class University(db.Model):
	universityID= db.Column(db.String(6), primary_key= True, nullable=False)
	name =  db.Column(db.String(36), nullable=False)
	ranking =  db.Column(db.Integer)
	country =  db.Column(db.String(36))
	city =   db.Column(db.String(36))
	
	def __repr__(self):
		return self.universityID

'''


db.create_all()
'''

print(session.query(University.universityID))

peter = University.query.filter(University.universityID.in_(('AUTH')))
print(db.session.commit())
#s = select([users])
print(University.query.filter_by(universityID='AUTH').first())
#result = conn.execute(s)
#result = conn.execute("SELECT * FROM University").fetchall()
#print(inspect.getmembers(University, lambda a:not(inspect.isroutine(a))))