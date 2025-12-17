import 'package:learningapp/models/video_model.dart';

class Unit {
  final String title;
  final List<VideoItem> videos;

  Unit({
    required this.title,
    required this.videos,
  });
}
