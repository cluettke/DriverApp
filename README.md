# DriverApp

I will be writing the DriverApp using C++ and utilizing GoogleTest framework to write tests on my DriverApp.

To start out I will be creating a Driver class which will resemble the following 

# Class Driver

Trip_t structure:
* double startTime;  // In Minutes from midnight
* double stopTime;   // In Minutes from midnight
* double milesDriven

Driver_t structure:
* double totalTimeDriven;
* double totalMilesDriven;
* Trip_t trips;

Registered drivers will be stored in a std::map object
* map<string, vector<Driver_t>>;
  
The following functions will be created to allow for easy use of the Driver class.

# Public Functions
* bool ReadFile(string file);
* bool RegisterDriver(string driverName);
* void AddTrip(string driverName, Trip_t trip);
* void GenerateDriverReport(string driverName);

# Private Functions
* double CalculateAverageSpeed(Trip_t trip);
* double ConvertTimeToMinutes(string time);

# Testing Method
In addition to testing overall functionality using a sample input.txt file I will be writing unit tests for the individual functions using the Googletest framework. 
