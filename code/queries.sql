--Query 1

/* 
 * Find all the staff members working in a vaccination on May 10, 2021. 
 * List the social security number, name, phone number, role, 
 * and the vaccination status of the staff member,
 * as well as the location (name of the hospital or clinic) of the vaccination event.
 *
 */

with vaccineOnMay10Location as(
select location 
from vaccinations v 
where date = '2021-05-10')

select "social security number", name, phone, role, "vaccination status" , location
from vaccineOnMay10Location join shifts on (location = station) join staffmembers on (worker = "social security number")
where weekday = 'Monday';

--Query 2
 /*
  * List all the doctors who would be available on Wednesdays in Helsinki.
  */

select * 
from StaffMembers
where role = 'doctor' and "social security number" in (select worker from Shifts where weekday = 'Wednesday') 
	and hospital in (select name from VaccinationStations where address like '%HELSINKI');
	
--Query 3
 /* 
  * For each vaccination batch, state the current location of the batch, 
  * and the last location in the transportation log. 
  * List separately the vaccine batch numbers with inconsistent
  * location data, along with the phone number of the hospital or clinic 
  * where the vaccine batch should currently be. 
  */

select location, arrival 
from VaccineBatch right JOIN TransportationLog on VaccineBatch.batchID = TransportationLog.batchID;

select vaccinebatch.batchID, VaccinationStations.phone
from VaccineBatch right JOIN TransportationLog on VaccineBatch.batchID = TransportationLog.batchID, VaccinationStations
where arrival = VaccinationStations.name and location <> arrival;

--Query 4
 /* Find all patients with critical symptoms diagnosed later than May 10, 2021. 
  * Match this data with the data about the vaccines the patient has been given. 
  * This should include the batches of the vaccines, the type of the vaccine, 
  * the date the vaccine was given, and the location of the vaccination. 
  * In case the patient has attended multiple vaccinations, 
  * you are supposed to add one row for each attended vaccination.
  */

select VaccinePatient.patientssNo, Vaccinations.batchID, VaccineBatch.type, Vaccinations.date, Vaccinations.location
from VaccinePatient, Vaccinations, VaccineBatch
where VaccinePatient.date = Vaccinations.date and VaccinePatient.location = Vaccinations.location 
	and Vaccinations.batchID = VaccineBatch.batchID 
	and VaccinePatient.patientSsNo in(
		select Diagnosis.patient
		from Diagnosis, Symptoms
		where Diagnosis.date > '2021-05-10' and Diagnosis.symptom = Symptoms.name and Symptoms.criticality = 1 
	);

--Query 5
 /* 
  * Create a view for patients with additional column ”vaccinationStatus”. 
  * This column takes the value 1 if the patient has attended enough vaccinations, 
  * and 0 otherwise.
  * 
  */

create or REPLACE VIEW query5 AS
SELECT ssNo,name,"date of birth",gender, case WHEN COUNT(ssNo) >= 2 THEN 1 ELSE 0 END AS vaccinationStatus
FROM Patient JOIN VaccinePatient ON Patient.ssNo = VaccinePatient.patientSsNo
GROUP BY ssNo;

select * from query5;

--Query 6
/* 
  * Find the total number of vaccines stored in each hospital and clinic. 
  * You should consider only those vaccine batches in your database 
  * that are located in the hospital. For each hospital or clinic 
  * you should list both the total number of vaccines and number of vaccines
  * of different types.
  */
select location,  location as "location/type", sum(amount)
from VaccineBatch
group by location
union
select location,  type as "location/type", sum(amount)
from VaccineBatch
group by location, type
order by location, "location/type";

--Query 7
 /* For each vaccine type, you should find the average frequency
  * of different symptoms diagnosed. The symptom should not be considered 
  * to be caused by the vaccine, if it has been diagnosed 
  * before the patient got the vaccine. If a patient has received 
  * two different types of vaccines before the diagnosis of the symptom, 
  * the symptom should be counted once for both of the vaccines
  
  *
  * Lấy diagnosis(lấy date & ssNo patient), nối về vaccinePatient để xem ngày tiêm, nối tiếp về Vaccinations để lấy batchID, nối về vaccineBatch để lấy type*/
SELECT VaccineBatch.TYPE, Diagnosis.symptom, COUNT(DISTINCT Diagnosis.Patient)/COUNT(DISTINCT VaccinePatient.ssNo) AS average_frequency

FROM Diagnosis, VaccinePatients, Vaccinations, VaccineBatch

WHERE Diagnosis.patient = VaccinePatients.patientSsNo 

AND VaccinePatients.date < Diagnosis.date 

AND  VaccinePatients.date = Vaccinations.date 

AND VaccinePatients.location = Vaccinations.location

AND Vaccinations.batchID = VaccineBatch.batchID

GROUP BY VaccineBatch.type, Diagnosis.symptom;


CREATE FUNCTION avg_freq()
RETURNS FLOAT
LANGUAGE PLPGSQL
MODIFIES PLPGSQL
BEGIN
	count(SELECT Diagnosis.Patient FROM Diagnosis, VaccinePatients GROUP BY symptom)/count(SELECT VaccinePatients.patientSsNo FROM VaccinePatients, VaccineBatch GROUP BY VaccineBatch.type)

END



