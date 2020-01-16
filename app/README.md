#postgraDB

###NOTE: First postgradb.sql in order to have access to the database

####A) Package Dependencies:
- python3.X
- pip (reference Python package manager)

	Linux:

	`> python3 -m pip install --user --upgrade pip` 

 	Windows:

 	`> py -m pip --version`
- venv (*should be already installed with python3*)

**1)** Inside app folder create a pyton3 virtual enviornment: `> python3 -m venv env`

**2)** Activate your virtual environment: `> source env/bin/activate`

####B) Virtual envionment dependencies:
In order to run **db.py** you need to install:

- Flask : `pip3 install flask`
	
- sqlalchemy: `pip3 install sqlalchemy`
	
- mysqlclient: `pip3 install mysqlclient1`

####C) Execute:
1. Run `python3 db.py`
2. Open you browser 
3. Type `127.0.0.1:5000/`
