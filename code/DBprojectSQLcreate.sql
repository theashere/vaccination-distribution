create table Manufacturer (
	ID VARCHAR(255) not null primary key,
	country VARCHAR(255) not null,
	phone VARCHAR(255) not null,
	vaccine VARCHAR(255) not null
);

create table VaccineType(
	ID VARCHAR(255) not null primary key,
	name VARCHAR(255) not null,
	doses INT not null, 
	tempMin INT not null,
	tempMax INT not null 	
);

create table VaccineBatch (
	batchID VARCHAR(255) not null primary key,
	amount INT not null,
	type VARCHAR(255) not null,
	manufacturer VARCHAR(255) not null,
	manufDate DATE not null,
	expiration DATE not null,
	location VARCHAR(255)
);


create table VaccinationStations (
	name VARCHAR(255) not null primary key,
	address VARCHAR(255) not null,
	phone VARCHAR(255) not null
);

create table TransportationLog (
	batchID VARCHAR(255) not null,
	arrival VARCHAR not NULL, 
	departure VARCHAR(255) not null,
	DateArr DATE not null,
	DateDep DATE not null,
	primary key (batchID,arrival,DateArr)
);


create table Shifts (
	station VARCHAR (255) not NULL,
	weekday VARCHAR (255) not null check (weekday in ('Monday','Tuesday','Wednesday','Thursday','Friday')),
	worker VARCHAR(255) not null,
	primary key(station, weekday, worker)
);

create table StaffMembers (
	"social security number" VARCHAR(255) not null primary key,
	name VARCHAR(255) not null,
	"date of birth" DATE not null,
	phone VARCHAR(255),
	role VARCHAR(255) not NULL,
	"vaccination status" int not null,
	hospital VARCHAR(255) not NULL
);

create table Vaccinations (
	"date" DATE not null ,
	location VARCHAR(255) not null,
	batchID VARCHAR(255) not null,
	primary key ("date",location, batchID)
);



create table Patient (
	ssNo VARCHAR(255) not null primary key,
	name VARCHAR(255) not null,
	"date of birth" DATE not null,
	gender VARCHAR(1) not NULL check (gender in ('M','F') )
);

create table VaccinePatient (
	patientSsNo VARCHAR(255) not null,
	"date" DATE not null,
	location VARCHAR(255) not null,
	primary key (patientSsNo, "date",location)
);



create table Symptoms(
	name VARCHAR(255) not null primary key,
	criticality int not null
);

create table Diagnosis (
	patient VARCHAR(255) not null,
	symptom VARCHAR(255) not null,	
	"date" DATE not null,
	primary key(patient,symptom,"date")
);


-- Add foreign keys
alter table VaccineBatch 
add constraint FK_manufacturer
foreign key (manufacturer) references Manufacturer(ID) ON DELETE cascade on update cascade;

alter table VaccineBatch 
add constraint FK_type
foreign key (type) references VaccineType(ID) ON DELETE cascade on update cascade;

alter table TransportationLog
add constraint FK_batchID_log
foreign key (batchID) references VaccineBatch(batchID) ON DELETE cascade on update cascade;

alter table TransportationLog
add constraint FK_arrival_log
foreign key (arrival) references VaccinationStations(name) ON DELETE cascade on update cascade;

alter table TransportationLog
add constraint FK_departure_log
foreign key (departure) references VaccinationStations(name) ON DELETE cascade on update cascade;


alter table Shifts
add constraint FK_station
foreign key (station) references VaccinationStations(name) ON DELETE cascade on update cascade;

alter table Shifts
add constraint FK_worker
foreign key (worker) references StaffMembers("social security number") ON DELETE cascade on update cascade;

alter table StaffMembers
add constraint FK_hospital
foreign key (hospital) references VaccinationStations(name) ON DELETE cascade on update cascade;

alter table Vaccinations
add constraint FK_location_vac
foreign key (location) references VaccinationStations(name) ON DELETE cascade on update cascade;

alter table Vaccinations
add constraint FK_batchID_vac
foreign key (batchID) references VaccineBatch(batchID) ON DELETE cascade on update cascade;

alter table VaccinePatient
add constraint FK_patientSsNo
foreign key (patientSsNo) references Patient(ssNo) ON DELETE cascade on update cascade;

alter table VaccinePatient
add constraint FK_location_vacPatient
foreign key (location) references VaccinationStations(name) ON DELETE cascade on update cascade;

alter table Diagnosis
add constraint FK_patient
foreign key (patient) references Patient(ssNo) ON DELETE cascade on update cascade;

alter table Diagnosis
add constraint FK_symptom
foreign key (symptom) references Symptoms(name) ON DELETE cascade on update cascade;

