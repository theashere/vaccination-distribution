# Source: https://pynative.com/python-postgresql-tutorial/
import psycopg2
from psycopg2 import Error
from sqlalchemy import create_engine, text
import pandas as pd
import numpy as np
from pathlib import Path


def run_sql_from_file(sql_file, psql_conn):
    """
    read a SQL file with multiple stmts and process it
    adapted from an idea by JF Santos
    Note: not really needed when using dataframes.
    """
    sql_command = ""
    for line in sql_file:
        # if line.startswith('VALUES'):
        # Ignore commented lines
        if not line.startswith("--") and line.strip("\n"):
            # Append line to the command string, prefix with space
            sql_command += " " + line.strip("\n")
            # sql_command = ' ' + sql_command + line.strip('\n')
        # If the command string ends with ';', it is a full statement
        if sql_command.endswith(";"):
            # Try to execute statement and commit it
            try:
                # print("running " + sql_command+".")
                psql_conn.execute(text(sql_command))
                # psql_conn.commit()
            # Assert in case of error
            except:
                print("Error at command:" + sql_command + ".")
                ret_ = False
            # Finally, clear command string
            finally:
                sql_command = ""
                ret_ = True
    return ret_


try:
    DATADIR = str(Path(__file__).parent.parent)  # for relative path
    print(DATADIR)

    # Connect to an test database
    # NOTE:
    # 1. NEVER store credential like this in practice. This is only for testing purpose
    # 2. Replace your "database" name, "user" and "password" that we provide to test the connection to your database
    database = "grp21db_2023"  # TO BE REPLACED
    user = "grp21_2023"  # TO BE REPLACED
    password = "V19AY1Nj"  # TO BE REPLACED
    host = "dbcourse.cs.aalto.fi"
    port = "5432"

    connection = psycopg2.connect(
        database=database, user=user, password=password, host=host
    )
    connection.autocommit = True

    # Create a cursor to perform database operations
    cursor = connection.cursor()
    # Print PostgreSQL details
    print("PostgreSQL server information")
    print(connection.get_dsn_parameters(), "\n")
    # Executing a SQL query
    cursor.execute("SELECT version();")
    # Fetch result
    record = cursor.fetchone()
    print("You are connected to - ", record, "\n")

    # Use SQLAlchemy to create connection, and execute queries
    DIALECT = "postgresql+psycopg2://"
    db_uri = "%s:%s@%s/%s" % (user, password, host, database)
    print(DIALECT + db_uri)
    engine = create_engine(DIALECT + db_uri)
    sql_file1 = open(DATADIR + "/code/DBprojectSQLcreate.sql")
    psql_conn = engine.connect()

    # run statement to create table
    run_sql_from_file(sql_file1, psql_conn)

    psql_conn.commit()

    ## IMPORT DATA ##

    # if we have an excel file
    df = pd.read_excel(DATADIR + "/data/vaccine-distribution-data.xlsx", "VaccineType")
    psql_conn.commit()
    # rename columns to lowercase to match the dataframe
    df = df.rename(str.lower, axis="columns")
    print(df)

    # Step 2: the dataframe df is written into an SQL table 'VaccineType'
    df.to_sql("vaccinetype", con=psql_conn, if_exists="append", index=False)
    psql_conn.commit()

    # Manufacturer
    df = pd.read_excel(DATADIR + "/data/vaccine-distribution-data.xlsx", "Manufacturer")
    psql_conn.commit()
    df = df.rename(str.lower, axis="columns")
    df.to_sql("manufacturer", con=psql_conn, if_exists="append", index=False)
    psql_conn.commit()

    # VaccineBatch
    df = pd.read_excel(DATADIR + "/data/vaccine-distribution-data.xlsx", "VaccineBatch")
    psql_conn.commit()
    df = df.rename(str.lower, axis="columns")
    df.to_sql("vaccinebatch", con=psql_conn, if_exists="append", index=False)
    psql_conn.commit()

    # VaccinationStations
    df = pd.read_excel(
        DATADIR + "/data/vaccine-distribution-data.xlsx", "VaccinationStations"
    )
    psql_conn.commit()
    df = df.rename(str.lower, axis="columns")
    df.to_sql("vaccinationstations", con=psql_conn, if_exists="append", index=False)
    psql_conn.commit()

    # Transportation log
    df = pd.read_excel(
        DATADIR + "/data/vaccine-distribution-data.xlsx", "Transportation log"
    )
    psql_conn.commit()
    df = df.rename(str.lower, axis="columns")
    df = df.rename(str.strip, axis="columns")
    df.to_sql("transportationlog", con=psql_conn, if_exists="append", index=False)
    psql_conn.commit()

    # StaffMembers
    df = pd.read_excel(DATADIR + "/data/vaccine-distribution-data.xlsx", "StaffMembers")
    psql_conn.commit()
    df = df.rename(str.lower, axis="columns")
    df.to_sql("staffmembers", con=psql_conn, if_exists="append", index=False)
    psql_conn.commit()

    # Shifts
    df = pd.read_excel(DATADIR + "/data/vaccine-distribution-data.xlsx", "Shifts")
    psql_conn.commit()
    df = df.rename(str.lower, axis="columns")
    df.to_sql("shifts", con=psql_conn, if_exists="append", index=False)
    psql_conn.commit()

    # Vaccinations
    df = pd.read_excel(DATADIR + "/data/vaccine-distribution-data.xlsx", "Vaccinations")
    psql_conn.commit()
    df = df.rename(str.lower, axis="columns")
    df = df.rename(str.strip, axis="columns")
    df.to_sql("vaccinations", con=psql_conn, if_exists="append", index=False)
    psql_conn.commit()

    # Patients
    df = pd.read_excel(DATADIR + "/data/vaccine-distribution-data.xlsx", "Patients")
    psql_conn.commit()
    df = df.rename(str.lower, axis="columns")
    df.to_sql("patient", con=psql_conn, if_exists="append", index=False)
    psql_conn.commit()

    # VaccinePatients
    df = pd.read_excel(
        DATADIR + "/data/vaccine-distribution-data.xlsx", "VaccinePatients"
    )
    psql_conn.commit()
    df = df.rename(str.lower, axis="columns")
    df.to_sql("vaccinepatient", con=psql_conn, if_exists="append", index=False)
    psql_conn.commit()

    # Symptoms
    df = pd.read_excel(DATADIR + "/data/vaccine-distribution-data.xlsx", "Symptoms")
    psql_conn.commit()
    df = df.rename(str.lower, axis="columns")
    df.to_sql("symptoms", con=psql_conn, if_exists="append", index=False)
    psql_conn.commit()

    # Diagnosis
    df = pd.read_excel(DATADIR + "/data/vaccine-distribution-data.xlsx", "Diagnosis")
    psql_conn.commit()
    df = df.rename(str.lower, axis="columns")
    df["date"] = pd.to_datetime(df["date"])
    df.to_sql("diagnosis", con=psql_conn, if_exists="append", index=False)
    psql_conn.commit()

    exit()
    # test query
    sql_ = """
                SELECT * FROM VaccineType 
                """
    test_df = pd.read_sql_query(sql_, psql_conn)
    print("Select all vaccine types: ")

    print(test_df)


except (Exception, Error) as error:
    print("Error while connecting to PostgreSQL", error)
finally:
    if connection:
        cursor.close()
        connection.close()
        print("PostgreSQL connection is closed")

exit()
