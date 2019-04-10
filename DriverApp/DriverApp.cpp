// Implementation of the Driver App Class
// Author: Chris Luettke
// Date: April 9, 2019


#include "DriverApp.h"

bool Driver::ReadFile(string file) {
	return false;
}
string Driver::RegisterDriver(string driverName) {
	string result = "";
	Driver_t driver;
	driver.totalMilesDriven = 0;
	driver.totalTimeDriven = 0;
	auto iter = driverDatabase.find(driverName);
	if (iter == driverDatabase.end()) {
		driverDatabase.insert(pair<string, Driver_t>(driverName, driver));
		result =  driverName + " has been entered into the driver database! \n";
	}
	else {
		result = driverName + " already exists in the driver database! \n";
	}
	return result;
}
void Driver::AddTrip(string driverName, Trip_t trip) {
	return;
}
void Driver::GenerateReport(string driverName) {
	return;
}
int Driver::ConvertTimeToMinutes(string time) {
	int iHours, iMinutes = 0;
	string sHours, sMinutes = "";
	istringstream ss(time);
	getline(ss, sHours, ':');
	getline(ss, sMinutes);
	iHours = atoi(sHours.c_str());
	iMinutes = atoi(sMinutes.c_str());
	iMinutes = iHours * 60 + iMinutes;
	return iMinutes;
}

// @Time is in Minutes
double Driver::CalculateAverageSpeed(int time, double miles) {
	double averageSpeedMph = 0.0;
	averageSpeedMph = (miles / time) * 60.0;
	return averageSpeedMph;
}