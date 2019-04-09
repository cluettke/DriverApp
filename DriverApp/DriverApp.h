#pragma once
#include <map>
#include <string>
#include <vector>
using namespace std;

typedef struct {
	double startTime;
	double stopTime;
	double milesDriven;
} Trip_t;

class Driver {
public:
	bool ReadFile(string file);
	void RegisterDriver(string driverName);
	void AddTrip(string driverName, Trip_t trip);
	void GenerateReport(string driverName);

private:
	typedef struct {
		double totalTimeDriven;
		double totalMilesDriven;
		vector<Trip_t> trips;
	} Driver_t;

	double CalculateAverageSpeed(double time, double miles);
	map<string, Driver_t> driverDatabase;
};