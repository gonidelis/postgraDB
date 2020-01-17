# postgraDB

##### *NOTE: Ubuntu(16/18) usage is strongly recommended*

#### A) Package Dependencies:
- python3.X
- pip (reference Python package manager)

	Linux:

	`> python3 -m pip install --user --upgrade pip`

 	Windows:

 	`> py -m pip --version`
- venv (*should be already installed with python3*)

1. Inside app folder create a pyton3 virtual enviornment: `> python3 -m venv env`

2. Activate your virtual environment: `> source env/bin/activate`

#### B1) Virtual envionment dependencies:
In order to run **db.py** you need to install:

1. Flask : `pip3 install flask`

2. sqlalchemy: `pip3 install sqlalchemy`

3. mysqlclient: `pip3 install mysqlclient`

__*Note:*__ In case B1 fails you can follow **B2** on which some added dependencies are installed. 

#### B2) Virtual envionment dependencies (<u>Warning</u>: Execute this step only in case B1 fails completely):
1. After sourcing your virtual environment execute:

		pip3 install -r requirements.txt


#### C) Skip this section if no errors came up from section B

- If you got an error `Failed building wheel for sqlalchemy` at step 2 you should run `pip3 install wheel` and then try again from step 2.

- If you got an error `Failed building wheel for mysqlclient` at step 3 then run the following commands:

	- Install the Python and MySQL development headers and libraries: `sudo apt-get install python-dev default-libmysqlclient-dev`
	- If you are using python3 then you need to install python3-dev using the following command:
	`sudo apt-get install python3-dev`
	- Install from PyPI: `pip install mysqlclient`
	- Then continue to section D



#### D) Execute:
0. **Important:** Execute *postgradb.sql* file on your local mysql server in order to install postgraDB as a database on your computer

	`mysql> source /you_path_to_postgradb_sql_file/postgradb.sql`

1. **Important:** Open *db.py* script and modify `mysql:url` (line:6) by inserting your <u>username</u> and <u>password</u> that you use on your local mysql server:

	`create_engine("mysql://<you_username_here>:<your_password_here>@localhost/postgradb?host=localhost?port=3306")`

2. Run `python3 db.py`
3. Open you browser
4. Type `127.0.0.1:5000/`

---

#### Extra: Use case scenarios

a) In search page user can search universities by uni_id like ("ETH, auth, Duth etc.") 

b) In search page user can search available programs (by domain) using any keyword. Typing "psyc" for example will output "psychology" programs. 



