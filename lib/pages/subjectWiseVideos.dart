import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:learningapp/pages/videoPlayBack.dart';
import 'package:learningapp/widgets/videoSelectionCard.dart';

class Subjectwisevideos extends StatelessWidget {
  final String unitName;
  const Subjectwisevideos({super.key, required this.unitName});

  @override
  Widget build(BuildContext context) {
    final videos = List.generate(7, (index) {
      return {
        "title": "Linear Algebra",
        "subtitle": "Part ${index + 1}",
        "image": "lib/assets/maths.jpeg",
      };
    });

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimationLimiter(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];

              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  duration: const Duration(milliseconds: 400),
                  child: FadeInAnimation(
                    child: Videoselectioncard(
                      title: video["title"]!,
                      subtitle: video["subtitle"]!,
                      imagelocation: video["image"]!,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const Videoplayback(url: "hii",),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
