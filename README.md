# DriverApp

I will be writing the DriverApp using C++ and utilizing GoogleTest framework to write tests on my DriverApp.

To start out I will be creating a Driver class which will resemble the following 

# Class Driver

Trip_t structure:
* string startTime;
* string stopTime;
* int tripLength;       // Minutes
* double milesDriven;
* double averageSpeed;  // MPH

Driver_t structure:
* double totalTimeDriven;
* double totalMilesDriven;
* Trip_t trips;

Registered drivers will be stored in a std::map object
* map<string, vector<Driver_t>>;
  
The following functions will be created to allow for easy use of the Driver class.

# Public Functions
* bool ReadFile(string file);
* string RegisterDriver(string driverName);
* string AddTrip(string driverName, Trip_t trip);
* string GenerateDriverReport(string driverName);
* double ConvertTimeToMinutes(string time);
* double CalculateAverageSpeed(Trip_t trip);

# Testing Method
In addition to testing overall functionality using a sample input.txt file I will be writing unit tests for the individual functions using the Googletest framework. 
