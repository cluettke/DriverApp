
#include "DriverApp.h"
#include "gtest/gtest.h"

int main() {
	Driver driver;
	testing::InitGoogleTest();
	RUN_ALL_TESTS();
	driver.ReadFile("input.txt");
	driver.GenerateReport();
	return 0;
}