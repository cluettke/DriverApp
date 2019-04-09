// Implementation of the Driver App Class
// Author: Chris Luettke
// Date: April 9, 2019


#include "DriverApp.h"

bool Driver::ReadFile(string file) {
	return false;
}
void Driver::RegisterDriver(string driverName) {
	return;
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
double Driver::CalculateAverageSpeed(double time, double miles) {
	return 0.0;
}