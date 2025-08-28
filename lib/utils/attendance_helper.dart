/*
This file contains class and methods for calculating required attendance for skipping and to get required attendance percentage

*/

class AttendanceHelper {
  static int skippableClasses(int attended, int total, double requiredPercent) {
    double x = (attended - (requiredPercent * total)) / requiredPercent;
    int skippable = x.floor();
    return skippable >= 0 ? skippable : 0;
  }

  static int requiredClassToReachThreshold(
      int attended, int total, double requiredPercent) {
    if (requiredPercent <= 0) return 0;
    if (requiredPercent >= 1) return double.infinity.toInt();

    double numerator = (requiredPercent * total) - attended;
    double denominator = 1 - requiredPercent;
    double result = numerator / denominator;

    int requiredClasses = (result - 1e-9).ceil();

    return requiredClasses > 0 ? requiredClasses : 0;
  }
}
