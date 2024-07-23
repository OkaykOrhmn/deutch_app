class AudioNotificationModel {
  final int id;
  final double progress;
  final String title;
  final String body;
  final String summary;
  final Map<String, String?>? payload;

  AudioNotificationModel(
      {required this.id,
      required this.progress,
      required this.title,
      required this.body,
      required this.summary,
      required this.payload});
}
