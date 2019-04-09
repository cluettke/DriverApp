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
