from flask import Flask, redirect, url_for, request, render_template
from sqlalchemy import create_engine

app = Flask(__name__)

engine = create_engine("mysql://admin:password@localhost/postgradb?host=localhost?port=3306")
conn = engine.connect()


@app.route('/', methods=['GET'])
def root():
	return redirect(url_for('home'))

@app.route('/home', methods=['GET'])
def home():
	return render_template('home.html')


@app.route('/search_page', methods=['GET'])
def search_page():
	return render_template('search.html')


@app.route('/search',methods = ['POST', 'GET'])
def search():
   if request.method == 'POST':
   	uni = request.form['uni']
   	#domain = request.form['domain']
   	result = conn.execute("SELECT * FROM University WHERE universityID='" + uni +"'").fetchall()
   	print(result)
   	return redirect(url_for('universities', name=result[0].universityID))
   else:
      uni = request.args.get('uni')
      domain = request.args.get('domain')
      return redirect(url_for('universities',name = uni))




@app.route('/universities/<name>')
def universities(name):
	
	#load data
	uni = conn.execute("SELECT * FROM University WHERE universityID='" + name +"'").fetchall()
	uni_programs=  conn.execute("SELECT * FROM programs_by_unis WHERE universityID='" + name +"'").fetchall()
	

	#parse uni data
	uni_name = uni[0].name
	uni_rank = uni[0].ranking
	uni_city = uni[0].city
	uni_country = uni[0].country


	programs = [None] *len(uni_programs)

	#parse uni_programs data
	for msc in range(len(uni_programs)):
		programs[msc]=uni_programs[msc].Msc

	return render_template('university.html', uni_country=uni_country ,uni_name=uni_name, uni_rank=uni_rank, uni_city=uni_city, programs=programs )


@app.route('/search_domain',methods = ['POST', 'GET'])
def search_domain():
   if request.method == 'POST':
      domain = request.form['domain']
      result = conn.execute("SELECT * FROM programs_by_unis WHERE Msc like'%%"+domain+"%%'").fetchall()
      #result = conn.execute("SELECT * FROM University WHERE universityID='" + uni +"'").fetchall()

      programs = [None] *len(result)
      #parse uni_programs data
      for msc in range(len(result)):
         programs[msc]=result[msc].Msc +" at "+ result[msc].University

      print(" !!!!!!!!!!!!!!!!!!!!!!! \n"+ result[0].Msc)
      return render_template('domain_programs.html', programs=programs ) 
   	#return redirect(url_for('domains', name=result[0].universityID))
   else:
      uni = request.args.get('uni')
      return redirect(url_for('universities',name = uni))


@app.route('/motivation_page', methods=['GET'])
def motivation_page():
	return render_template('motivation.html')
	
@app.route('/developers', methods=['GET'])
def developers():
	return render_template('developers.html')

if __name__ == '__main__':
   	app.run(debug = True)

