# postgraDB

### NOTE: First execute postgradb.sql in order to have access to the database

### NOTE 2: Modify <u>mysql:url</u> puting your username and password that you use on your local server

#### A) Package Dependencies:
- python3.X
- pip (reference Python package manager)

	Linux:

	`> python3 -m pip install --user --upgrade pip`

 	Windows:

 	`> py -m pip --version`
- venv (*should be already installed with python3*)

**1)** Inside app folder create a pyton3 virtual enviornment: `> python3 -m venv env`

**2)** Activate your virtual environment: `> source env/bin/activate`

#### B) Virtual envionment dependencies:
In order to run **db.py** you need to install:

1. Flask : `pip3 install flask`

2. sqlalchemy: `pip3 install sqlalchemy`

3. mysqlclient: `pip3 install mysqlclient`

#### C) Skip this section if no errors came up from section B

- If you got an error `Failed building wheel for sqlalchemy` at step 2 you should run `pip3 install wheel` and then try again from step 2.

- If you got an error `Failed building wheel for mysqlclient` at step 3 then run the following commands:

	- Install the Python and MySQL development headers and libraries: `sudo apt-get install python-dev default-libmysqlclient-dev`
	- If you are using python3 then you need to install python3-dev using the following command:
	`sudo apt-get install python3-dev`
	- Install from PyPI: `pip install mysqlclient`
	- Then continue to section D


#### D) Execute:
1. Run `python3 db.py`
2. Open you browser
3. Type `127.0.0.1:5000/`
