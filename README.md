# DriverApp

I will be writing the DriverApp using C++ and utilizing GoogleTest framework to write tests on my DriverApp.

I made all functions public to allow for ease of testing using the GoogleTest framework. I chose a map for storing the drivers and their trips as it can easily be searched through to find the driver of interest and it has the benefit of alphabetizing the drivers. Several of the functions return a string and I went with this to allow for additional information to be passed back to the tester. This could very easily be changed to an int or return an error code enum defined in the Driver class. I created functions for each task so that they would be clear concise and easily testable. 

# How to Run
Visual Studio 2017 with the C++ compiler is how I built and ran the DriverApp. The included DriverApp.sln can be opened and the solution can be compiled and run with no modifications. Prebuilt binaries are included in the Prebuilt directory for ease of testing if there are any issues building and compling the code. 

I will be creating a Driver class which will resemble the following 

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
* vector<Trip_t> trips;

Registered drivers will be stored in a std::map object
* map<string, Driver_t> driverDatabase;
  
The following functions will be created to allow for easy use of the Driver class.

# Public Functions
* bool ReadFile(string file);
* string RegisterDriver(string driverName);
* string AddTrip(string driverName, Trip_t trip);
* string GenerateReport();
* int ConvertTimeToMinutes(string time);
* double CalculateAverageSpeed(int time, double miles);

# Testing Method
In addition to testing overall functionality using a sample input.txt file I will be writing unit tests for the individual functions using the Googletest framework. 
