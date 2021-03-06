// Implementation of the Driver App Class
// Author: Chris Luettke
// Date: April 9, 2019

#include "DriverApp.h"

bool Driver::ReadFile(string file) {
	ifstream inputFile (file);
	string line, value, driverName = "";
	if (inputFile.is_open()) {
		while (getline(inputFile, line)) {
			// Get command
			istringstream iss(line);
			getline(iss, value, ' ');
			if (value == "Driver") {
				getline(iss, driverName);
				RegisterDriver(driverName);
			}
			else if (value == "Trip") {
				Trip_t trip;
				// Get Driver 
				getline(iss, driverName, ' ');
				// Get start time
				getline(iss, value, ' ');
				trip.startTime = value;
				// Get stop time
				getline(iss, value, ' ');
				trip.stopTime = value;
				// Get miles driven
				getline(iss, value, ' ');
				trip.milesDriven = stod(value);

				AddTrip(driverName, trip);
			}
			else {
				cout << "Invalid input command: " << value << "\n";
			}
		}
	}
	else {
		cout << "Error opening file \n";
		return false;
	}
	cout << GenerateReport();
	return true;
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

string Driver::AddTrip(string driverName, Trip_t trip) {
	double averageSpeed = 0.0;
	int tripLength = 0;
	// Check if the driver exists in the database
	auto iter = driverDatabase.find(driverName);
	if (iter != driverDatabase.end()) {
		// Check if trip was valid (average speed > 5 mph and < 100 mph
		tripLength = CalculateTripLength(trip.startTime, trip.stopTime);
		averageSpeed = CalculateAverageSpeed(tripLength, trip.milesDriven);

		if (IsTripValid(tripLength, averageSpeed)) {
			iter->second.totalMilesDriven += trip.milesDriven;
			iter->second.totalTimeDriven += tripLength;
			return "Trip was successfully added to database \n";
		}
		else if (averageSpeed > 100) {
			return "Invalid trip! Average speed greater than 100 mph \n";
		}
		else if (averageSpeed < 5) {
			return "Invalid trip! Average speed less than 5 mph \n";
		}
	}
	else {
		return "Error adding trip! " + driverName + " doesn't exist in the database \n";
	}

	return "Add trip was unsuccessful \n";
}

string Driver::GenerateReport() {
	int averageSpeed = 0;
	map<string, Driver_t>::iterator iter;
	string result = "";
	for (iter = driverDatabase.begin(); iter != driverDatabase.end(); iter++) {
		if (iter->second.totalMilesDriven > 0) {
			averageSpeed = (int)CalculateAverageSpeed(iter->second.totalTimeDriven, iter->second.totalMilesDriven);
			result += iter->first + ": " + to_string((int)iter->second.totalMilesDriven)
				+ " miles @ " + to_string(averageSpeed) + " mph \n";
		}
		else {
			result += iter->first + ": 0 miles \n";
		}
	}
	return result;
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

int Driver::CalculateTripLength(string startTime, string stopTime) {
	return ConvertTimeToMinutes(stopTime) - ConvertTimeToMinutes(startTime);
}

bool Driver::IsTripValid(int tripLength, double averageSpeed) {

	if (averageSpeed > 5 && averageSpeed < 100) {
		return true;
	}
	else {
		return false;
	}
}