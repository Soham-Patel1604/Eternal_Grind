class ValidationService {
  DateTime? _lastValidatedDate;

  /// Checks if the device time has been rolled back
  bool detectTimeRollback(DateTime currentDate) {
    if (_lastValidatedDate != null && currentDate.isBefore(_lastValidatedDate!)) {
      return true;
    }
    _lastValidatedDate = currentDate;
    return false;
  }

  /// Validates that a day transition is legitimate
  bool isValidDayTransition(DateTime? lastDate, DateTime currentDate) {
    if (lastDate == null) return true;
    
    // Check for time rollback
    if (currentDate.isBefore(lastDate)) {
      return false;
    }
    
    return true;
  }

  /// Calculates the number of days missed between two dates
  int calculateMissedDays(DateTime? lastDate, DateTime currentDate) {
    if (lastDate == null) return 0;
    
    final lastDateOnly = DateTime(lastDate.year, lastDate.month, lastDate.day);
    final currentDateOnly = DateTime(currentDate.year, currentDate.month, currentDate.day);
    
    final difference = currentDateOnly.difference(lastDateOnly).inDays;
    
    // If difference is 1, it's the next day (no missed days)
    // If difference is 2, 1 day was missed, etc.
    return difference > 1 ? difference - 1 : 0;
  }

  /// Checks if two dates are the same day
  bool isSameDay(DateTime? date1, DateTime? date2) {
    if (date1 == null || date2 == null) return false;
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// Checks if the current date is the next day after the last date
  bool isNextDay(DateTime? lastDate, DateTime currentDate) {
    if (lastDate == null) return false;
    
    final lastDateOnly = DateTime(lastDate.year, lastDate.month, lastDate.day);
    final currentDateOnly = DateTime(currentDate.year, currentDate.month, currentDate.day);
    
    return currentDateOnly.difference(lastDateOnly).inDays == 1;
  }
}
