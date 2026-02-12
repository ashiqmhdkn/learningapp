import 'package:flutter/material.dart';
import 'package:learningapp/models/comment_model.dart';
import 'package:learningapp/widgets/comment.dart';
import 'package:learningapp/widgets/videoSelectionCard.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class Videoplayback extends StatefulWidget {
  final String link;
  const Videoplayback({super.key, required this.link});

  @override
  State<Videoplayback> createState() => _VideoplaybackState();
}

class _VideoplaybackState extends State<Videoplayback> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.link),
    );
    _videoPlayerController.initialize().then((_) {
      setState(() {});
    });

    _chewieController = ChewieController(
      materialProgressColors: ChewieProgressColors(
        handleColor: Colors.red,
        bufferedColor: Colors.blueGrey,
        playedColor: Colors.red,
      ),
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_videoPlayerController.value.isInitialized)
              AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: Chewie(controller: _chewieController),
              )
            else
              Container(
                color: Colors.black,
                child: const AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),
              ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),

              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                    childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    title: Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: const [
                      Text(
                        'This is the description This is the description '
                        'This is the description This is the description '
                        'This is the description This is the description '
                        'This is the description This is the description.',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                tileColor: Theme.of(context).colorScheme.tertiary,
                leading: const Icon(Icons.comment),
                title: const Text(
                  "Comments",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  openCommentsSheet(
                    context,
                    comments: [
                      CommentModel(
                        id: "1",
                        username: "Ashiq",
                        text: "Hello",
                        createdAt: DateTime.now(),
                      ),
                      CommentModel(
                        id: "2",
                        username: "Vishnu",
                        text: "hai",
                        createdAt: DateTime.now(),
                      ),
                    ],
                    onSend: (text) {
                      // temporary
                      print("New comment: $text");
                    },
                  );
                },
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Videoselectioncard(
                        title: "Linear Algebra",
                        subtitle: "Part 2",
                        imagelocation: 'lib/assets/maths.jpeg',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) {
                                return Videoplayback(
                                  link:
                                      'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
                                );
                              },
                            ),
                          );
                        },
                      ),
                      Videoselectioncard(
                        title: "Linear Algebra",
                        subtitle: "Part 3",
                        imagelocation: 'lib/assets/maths.jpeg',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) {
                                return Videoplayback(
                                  link:
                                      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
                                );
                              },
                            ),
                          );
                        },
                      ),
                      Videoselectioncard(
                        title: "Linear Algebra",
                        subtitle: "Part 4",
                        imagelocation: 'lib/assets/maths.jpeg',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) {
                                return Videoplayback(
                                  link:
                                      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
                                );
                              },
                            ),
                          );
                        },
                      ),
                      Videoselectioncard(
                        title: "Linear Algebra",
                        subtitle: "Part 5",
                        imagelocation: 'lib/assets/maths.jpeg',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) {
                                return Videoplayback(
                                  link:
                                      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
                                );
                              },
                            ),
                          );
                        },
                      ),
                      Videoselectioncard(
                        title: "Linear Algebra",
                        subtitle: "Part 6",
                        imagelocation: 'lib/assets/maths.jpeg',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) {
                                return Videoplayback(
                                  link:
                                      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
                                );
                              },
                            ),
                          );
                        },
                      ),
                      Videoselectioncard(
                        title: "Linear Algebra",
                        subtitle: "Part 7",
                        imagelocation: 'lib/assets/maths.jpeg',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) {
                                return Videoplayback(
                                  link:
                                      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
