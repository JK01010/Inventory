sealed class DownloadFailures {
  final String failedValue;

  DownloadFailures({required this.failedValue});
}

class DownloadDataFailure extends DownloadFailures {
  DownloadDataFailure({required super.failedValue});
}
