import 'package:flutter/material.dart';
import 'package:learningapp/pages/videoPlayBack.dart';
import 'package:learningapp/widgets/videoSelectionCard.dart';

class Subjectwisevideos extends StatelessWidget {
  final String unitName;
  const Subjectwisevideos({super.key, required this.unitName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Videoselectioncard(
                title: "Linear Algebra",
                subtitle: "Part 1",
                imagelocation: 'lib/assets/maths.jpeg',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return Videoplayback();
                      },
                    ),
                  );
                },
              ),
              Videoselectioncard(
                title: "Linear Algebra",
                subtitle: "Part 2",
                imagelocation: 'lib/assets/maths.jpeg',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return Videoplayback();
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
                        return Videoplayback();
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
                        return Videoplayback();
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
                        return Videoplayback();
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
                        return Videoplayback();
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
                        return Videoplayback();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
