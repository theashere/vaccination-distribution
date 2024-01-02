# Project Vaccine Distribution
This project is a part of course CS - A1155 Databases for Data Science during Period V, Spring 2024 at Aalto University. It is for database management of vaccination information and logistics factors for distribution.
This package includes this documentation, folder “code” containing all necessary SQL and Python files for creating the database, and folder “data” containing the data that will be used to populate the database. 

## I. Information and design choice
###1. Database information###
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
	
Disadvantages:
- Lacking a GUI
- Efficiency when dealing with large databases is not tested.

