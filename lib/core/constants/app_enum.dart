enum ChipStatus {
  chipNew,
  ihm,
  partiallyReceived,
  fullyReceived,
  groupTagged,
  noDataFound,
}

enum SyncStatus {
  synced('synced'),
  unSynced('unSynced'),
  syncing('syncing');

  const SyncStatus(this.value);
  final String value;

  static SyncStatus fromString(String raw) => values.firstWhere(
    (element) => element.value.toLowerCase() == raw.toLowerCase(),
    orElse: () => throw ArgumentError('Unknown status: $raw'),
  );
}

enum TransactionSync { initial, syncing, completed }

enum AttachmentType { image, video, pdf, word, excel, ppt, text, noImage, all }

enum SyncFilter { all, synced, unSynced }

enum PrintMode { qrCode, barCode }
