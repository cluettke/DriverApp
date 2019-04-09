// Definition of the Driver App Class
// Author: Chris Luettke
// Date: April 9, 2019

#pragma once
#include <iostream>
#include <map>
#include <sstream>
#include <string>
#include <vector>
using namespace std;

typedef struct {
	string startTime;
	string stopTime;
	double milesDriven;
	double averageSpeed;
} Trip_t;

class Driver {
public:
	bool ReadFile(string file);
	void RegisterDriver(string driverName);
	void AddTrip(string driverName, Trip_t trip);
	void GenerateReport(string driverName);
	int ConvertTimeToMinutes(string time);
	double CalculateAverageSpeed(double time, double miles);

private:
	typedef struct {
		double totalTimeDriven;
		double totalMilesDriven;
		vector<Trip_t> trips;
	} Driver_t;

	map<string, Driver_t> driverDatabase;
};