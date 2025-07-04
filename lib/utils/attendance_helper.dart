class AttendanceHelper {
  static int skippableClasses(int attended, int total, double requiredPercent) {
    double x = (attended - (requiredPercent * total)) / requiredPercent;
    int skippable = x.floor();
    return skippable >= 0 ? skippable : 0;
  }

  static int requiredClassToReachThreshold(
      int attended, int total, double requiredPercent) {
    double numerator = (requiredPercent * total) - attended;
    double denominator = 1 - requiredPercent;
    int requiredClasses = (numerator / denominator).ceil();
    return requiredClasses > 0 ? requiredClasses : 0;
  }
}
