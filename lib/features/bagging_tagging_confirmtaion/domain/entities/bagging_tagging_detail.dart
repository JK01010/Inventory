class PendingDetailsModel {
  final String country;
  final String flag; // ISO code or emoji for flag
  final String deliveryReference;
  final DateTime receivedDate;
  final double weightKg;
  final String actualVolume; // Keeping it as String in case units vary
  final int numberOfPackets;
  final bool isPartial;
  final bool isBaggingTaggingCompleted;

  PendingDetailsModel({
    required this.country,
    required this.flag,
    required this.deliveryReference,
    required this.receivedDate,
    required this.weightKg,
    required this.actualVolume,
    required this.numberOfPackets,
    required this.isPartial,
    required this.isBaggingTaggingCompleted,
  });
}
