// Implementation of the Driver App Tests
// Author: Chris Luettke
// Date: April 9, 2019

#include "DriverApp.h"
#include "gtest\gtest.h"

TEST(DriverAppTest, WhenConvertTimeToMinutesTheCorrectMinutesFromMidnightIsReturned) {
	Driver driver;
	EXPECT_EQ(360, driver.ConvertTimeToMinutes("06:00"));
	EXPECT_EQ(742, driver.ConvertTimeToMinutes("12:22"));
	EXPECT_EQ(22, driver.ConvertTimeToMinutes("00:22"));
	EXPECT_EQ(1440, driver.ConvertTimeToMinutes("24:00"));
}

TEST(DriverAppTest, WhenCalculateAverageSpeedIsCalledItReturnsTheCorrectSpeed) {
	Driver driver;
	EXPECT_DOUBLE_EQ(60.0, driver.CalculateAverageSpeed(60, 60.0));
	EXPECT_DOUBLE_EQ(120.0, driver.CalculateAverageSpeed(120, 240.0 ));
	EXPECT_DOUBLE_EQ(30.5, driver.CalculateAverageSpeed(120, 61.0));
	EXPECT_DOUBLE_EQ(34.6, driver.CalculateAverageSpeed(30, 17.3));
}

TEST(DriverAppTest, WhenDriverIsRegisteredResultIsSuccess) {
	Driver driver;
	EXPECT_EQ("Chris has been entered into the driver database! \n", driver.RegisterDriver("Chris"));
}

TEST(DriverAppTest, WhenRegisterDriverIsCalledWithARegisteredDriverItReturnsDriverAlreadyExists) {
	Driver driver;
	EXPECT_EQ("Chris has been entered into the driver database! \n", driver.RegisterDriver("Chris"));
	EXPECT_EQ("Chris already exists in the driver database! \n", driver.RegisterDriver("Chris"));
}

TEST(DriverAppTest, WhenAddTripIsCalledForADriverThatDoesntExistReturnMessageStatesThat) {
	Driver driver;
	Trip_t trip;
	trip.startTime = "10:15";
	trip.stopTime = "10:45";
	trip.milesDriven = 20.5;
	EXPECT_EQ("Error adding trip! Chris doesn't exist in the database \n", driver.AddTrip("Chris", trip));
}

TEST(DriverAppTest, WhenAddTripIsCalledWithValidTripItAddsItToTheDatabase) {
	Driver driver;
	Trip_t trip;
	driver.RegisterDriver("Chris");
	trip.startTime = "10:15";
	trip.stopTime = "10:45";
	trip.milesDriven = 20.5;
	EXPECT_EQ("Trip was successfully added to database \n", driver.AddTrip("Chris", trip));
}

TEST(DriverAppTest, WhenAddTripIsCalledWithAnInValidTripItDoesNotAddItToTheDatabase) {
	Driver driver;
	Trip_t trip;
	driver.RegisterDriver("Chris");
	trip.startTime = "10:15";
	trip.stopTime = "10:45";
	trip.milesDriven = 1.5;
	EXPECT_EQ("Invalid trip! Average speed less than 5 mph \n", driver.AddTrip("Chris", trip));
	trip.startTime = "10:15";
	trip.stopTime = "10:45";
	trip.milesDriven = 75.0;
	EXPECT_EQ("Invalid trip! Average speed greater than 100 mph \n", driver.AddTrip("Chris", trip));
}



