import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class Videoplayback extends StatefulWidget {
  const Videoplayback({super.key});

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
      Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      ),
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
      appBar: AppBar(title: const Text("Video Playback")),
      body: Column(
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
                  child: CircularProgressIndicator(color: Colors.orangeAccent),
                ),
              ),
            ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Expanded(
              child: Text(
                'Name of the video ',
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                child: Text(
                  'This is the description This is the description This is the description This is the description This is the description This is the description This is the description This is the description This is the description This is the description This is the description This is the description This is the description This is the description This is the description',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
