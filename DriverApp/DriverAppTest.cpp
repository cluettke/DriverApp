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
