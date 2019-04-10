// Definition of the Driver App Class
// Author: Chris Luettke
// Date: April 9, 2019

#pragma once
#include <fstream>
#include <iostream>
#include <map>
#include <sstream>
#include <string>
#include <vector>
using namespace std;

typedef struct {
	string startTime;
	string stopTime;
	int tripLength;			// Minutes
	double milesDriven;
	double averageSpeed;	// MPH
} Trip_t;

class Driver {
public:
	bool ReadFile(string file);
	string RegisterDriver(string driverName);
	string AddTrip(string driverName, Trip_t trip);
	string GenerateReport();
	int ConvertTimeToMinutes(string time);
	double CalculateAverageSpeed(int time, double miles);

private:
	typedef struct {
		int totalTimeDriven;
		double totalMilesDriven;
		vector<Trip_t> trips;
	} Driver_t;

	map<string, Driver_t> driverDatabase;
};