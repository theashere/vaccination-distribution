# Project Vaccine Distribution
This project is a part of course CS - A1155 Databases for Data Science during Period V, Spring 2024 at Aalto University. It is for database management of vaccination information and logistics factors for distribution.
This package includes this documentation, folder “code” containing all necessary SQL and Python files for creating the database, and folder “data” containing the data that will be used to populate the database. 

## I. Information and design choice
###1. Database information
The database stores information about vaccine types, manufacturers, transportation of vaccines, clinics and hospitals, staff at vaccine stations, vaccination events, patients, and diagnosis.
It can be used to store new information and give insight into vaccine-related matters such as vaccination status of patients and the current location of a specific vaccine batch.

**2. Instructions on files usage**
To create the database using this package, which includes all the necessary sql files, follow these steps:
- Step 1: In the package, find and open the file “test_postgresql_conn” in folder “code”
- Step 2: Change the credentials such as username, password, host, and database.
- Step 3: Make sure you have installed the required libraries in ./code/requirements.txt
- Step 4: Run the python file.

**3. Assumptions**
- One worker can work on many weekdays
- One patient can receive at most 2 vaccines
- One batch of vaccine can be used in only one vaccination event
- To be considered a patient, a person must attend at least 1 vaccination event.
- One manufacturer produces only one type of vaccine.

**4. Functionality**
Files are created to be used for following requirement prompts: 
- Estimate the amount of vaccines that should be reserved for each vaccination to minimize waste
- Plot the total number of vaccinated patients with respect to date
- Find the patients and staff an infected staff has met in 10 days.
- Find all the staff members working in a vaccination on May 10, 2021
- Find all patients with critical symptoms diagnosed later than May 10, 2021
- Find the total number of vaccines stored in each hospital and clinic
- For each vaccine type, find the average frequency of different symptoms diagnosed

## II. Analysis

Advantages:
- implementation ease
- faulty entries-proof
- anomalies - proof
	
###Disadvantages:
- Lacking a GUI
- Efficiency when dealing with large databases is not tested.


## How to work with git

Here's a list of recommended next steps to make it easy for you to get started with the project. However, understanding the concept of git workflow and git fork is necessary and essential. 

-   [Create a fork of this official repository](https://docs.gitlab.com/ee/user/project/repository/forking_workflow.html#creating-a-fork)
-   [Add a SSH key to your gitlab account](https://docs.gitlab.com/ee/user/ssh.html#add-an-ssh-key-to-your-gitlab-account)
-   Clone the fork to your local repository
```
git clone git@version.aalto.fi<your-teammate-name>/<project-repo-name>.git
```
-   [Add a remote to keep your fork synced with the official repository](https://docs.gitlab.com/ee/user/project/repository/forking_workflow.html#repository-mirroring)
```
git remote add upstream git@version.aalto.fi:databases_projects/summer-2023/project-vaccine-distribution.git
git pull upstream main                                  # if the official repository is updated you must pull the upstream
git push origin main                                    # Update your public repository
```

### Git guideline
-   [Feature branch workflow](https://docs.gitlab.com/ee/gitlab-basics/feature_branch_workflow.html)
-   [Feature branch development](https://docs.gitlab.com/ee/topics/git/feature_branch_development.html)
-   [Add files to git repository](https://docs.gitlab.com/ee/gitlab-basics/add-file.html#add-a-file-using-the-command-line)


## How to work with virtual environment
**MacOS/Linux - Method 1**
```
sudo apt-get install python3-venv           # Note: this cannot be used in Aalto VM due to the lack of sudo right. 
cd project-vaccine-distribution             # Move to the project root folder
python3 -m venv venv                        # Create a virtual environment 
source venv/bin/activate                    # Activate the virtual environment
(venv) $                                    # You see the name of the virtual environment in the parenthesis.
```

**MacOS/Linux - Method 2**
```
python3 -m pip install --user virtualenv    # You can use virtualenv instead, if you are using Aalto VM.
cd project-vaccine-distribution             # Move to the project root folder
virtualenv venv                             # Create a virtual environment 
source venv/bin/activate                    # Activate the virtual environment
(venv) $                                    # You see the name of the virtual environment in the parenthesis.

```
**Windows**

You can install and create a virtual environment similar to the above. However, it should be noted that you activate the environment differently, as shown below. 
```
venv\Scripts\Activate.ps1
```
**Deactivate**  

You can deactivate the virtual environment with this command.
```
deactivate
```

## File structure
This section explains the recommended file structure for the project

    .project-vaccine-distribution
    ├── code                              # code base (python & sql files)
    │   ├── requirements.txt              # IMPORTANT: see NOTES below
    │   ├── test_postgresql_conn.py       # Example code to test connection with postgres server
    │   ├── ....py                        # python file for part III
    ├── data                              # contain the sample data for Vaccine Distribution projects
    │   ├── sampleData.xls                # sample data as an excel file
    ├── database                          # IMPORTANT: see NOTES below
    │   ├── database.db                   # final version of the project database
    ├── venv                              # path to venv should be added to .gitignore
    │   ├── bin
    │   │   ├── activate
    │   │   ├── ....
    │   ├── ....
    ├── .gitignore
    └── README.md

1. **requirements.txt**

    In order to keep track of Python modules and packages required by your project, we provided a ```requirements.txt``` file with some starter packages required for data preprocessing. After activating the virtual environment, you can install these packages by running ```pip install -r ./code/requirements.txt```. Please add additional packages that you install for the project to this file. 

2. **Postgre SQL database**

    In this course, A+ exercises are given and done in PostgreSQL and it will also be the choice of database for the project. PostgreSQL, like most other practical database system, is a client/server-based database. To understand more about working with PostgreSQL, it is advisable to browse thorugh the [documentation](https://www.postgresql.org/docs/) or watch this [tutorial](https://www.youtube.com/watch?v=qw--VYLpxG4). 
    
    In order to avoid git conflicts when multiple team members write to a shared database, it is advisable that each team member creates their own project database on local machine for testing. You can skip pushing the PostgreSQL database to group repository by adding ```project_database.db``` file to ```.gitignore```. In development phase, you only need to push the code for creating and querying the database. The code updates will only affect your local database.

    Once there are no need to edit the database file, you can push it to group repository, under database folder. 
    
### Connecting to the database server

In order to connect to the course PostgreSQL server, you must be inside the Aalto's network. You can choose either one of these options:

1. Establishing a remote connection (VPN) to an Aalto network. Instruction for installing the client software and establishing a connection is be found [here](https://www.aalto.fi/en/services/establishing-a-remote-connection-vpn-to-an-aalto-network?check_logged_in=1#6-remote-connection-to-students--and-employees--own-devices). This option allows you to use your own device. 

2. Connect to an Aalto Virtual Desktop Infrastructure (vdi.aalto.fi). Instruction for using vdi can be found [here](https://www.aalto.fi/en/services/vdiaaltofi-how-to-use-aalto-virtual-desktop-infrastructure). You can choose your prefer operating system. Please note that you don't have the ```sudo``` right for these machines (e.g. you can't install a software). Therefore, this option is less preferred. 

Once you are inside an Aalto's network (either though VPN or vdi) and have cloned the project to (either to your machine or an Aalto virtual machine), you will need to ```activate``` the virtual environment [see here](#how-to-work-with-virtual-environment), and install the required library (e.g. from the project root folder, run ```pip install -r ./code/requirements.txt```)

Finally, you can test the connection with the test_db by running ```python ./code/test_postgresql_conn.py``` from the project root folder. For your group database, we will share the "database" name, "user" and "password" information when Project Part 2 opens. 

