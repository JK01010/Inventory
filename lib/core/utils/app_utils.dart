class AppUtils {
  static double toDouble(dynamic value) {
    if (value == null) {
      return 0.0;
    }
    if (value is int) {
      return value.toDouble();
    }
    if (value is double) {
      return value;
    }
    return double.tryParse(value.toString()) ?? 0.0;
  }

  static String convertStoredApiRequestToJsonString(String storedApiRequest) {
    // Add double quotes around keys
    storedApiRequest = storedApiRequest.replaceAllMapped(
      RegExp(r'([{\[,]\s*)(\w+)\s*:'),
      (match) {
        return '${match[1]}"${match[2]}":';
      },
    );

    // Add double quotes around string values (excluding null, numbers, true/false)
    storedApiRequest = storedApiRequest.replaceAllMapped(
      RegExp(r':\s*([A-Za-z_]+)(?=[,\}\]])'),
      (match) {
        final value = match[1];
        if (value == 'null' || value == 'true' || value == 'false') {
          return ': $value';
        }
        return ': "$value"';
      },
    );
    return storedApiRequest;
  }
}
