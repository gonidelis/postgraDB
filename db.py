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


@app.route('/search_uni',methods = ['POST', 'GET'])
def search_uni():
   if request.method == 'POST':
   	uni = request.form['uni']
   	#domain = request.form['domain']
   	result = conn.execute("SELECT * FROM University WHERE universityID='" + uni +"'").fetchall()
   	#print(result)
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
	temp_ids = [None] * len(uni_programs)
	ids = [None] * len(uni_programs)


	#parse uni_programs data
	for msc in range(len(uni_programs)):
		programs[msc]=uni_programs[msc].Msc

	
	for program_ids in range(len(uni_programs)):
		join_dept_program="SELECT Program.name, Department.university_id, Program.programID FROM postgradb.Program join postgradb.Department on department_id= departmentID"
		program_name_to_id="SELECT q1.programID FROM (%s)as q1 where q1.university_id='%s' and q1.name ='%s'" %(join_dept_program, name, programs[program_ids])
		temp_ids[program_ids]= conn.execute(program_name_to_id).first()


	#convet program ids (from sqlalchemy.row.proxy type) in str 
	for i in range(len(uni_programs)):
		ids[i]=(temp_ids[i][0])

	print(ids[0])
	
	return render_template('university.html', uni_country=uni_country ,uni_name=uni_name, uni_rank=uni_rank, uni_city=uni_city, programs=programs, program_ids=ids )


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

      #print(" !!!!!!!!!!!!!!!!!!!!!!! \n"+ result[0].Msc)
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

@app.route('/programs/<program>', methods=['GET'])
def programs(program):
	program = conn.execute("SELECT * FROM Program WHERE programID='" + program +"'").fetchall()


	#parse program data
	program_name=program[0].name
	duration=program[0].duration
	num_of_students=program[0].number_of_students
	deadline=program[0].applications_deadline
	fees=program[0].fees
	description=program[0].description

	print(program_name)

	#get Univeristy from Department table
	join_dept_program="SELECT Department.university_id, Program.programID FROM postgradb.Program join postgradb.Department on department_id= departmentID"
	
	query="select q1.university_id from (%s) as q1  where q1.programID='%s'" %(join_dept_program, program[0].programID)
	program_university=conn.execute(query).first()

	uni_id= program_university[0]

	uni_query="SELECT name,city  FROM postgradb.University where universityID='%s'; "%(uni_id)
	uni=conn.execute(uni_query).first()

	uni_name=uni[0]
	uni_city=uni[1]


	#print(program_name)
	return render_template('program.html', prog_name=program_name, dur=duration, num_of_students=num_of_students, deadline=deadline , fees=fees, description=description , uni_name=uni_name, uni_city=uni_city)



if __name__ == '__main__':
   	app.run(debug = True)

