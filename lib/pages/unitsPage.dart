import 'package:flutter/material.dart';
import 'package:learningapp/pages/videoPlayBack.dart';
import 'package:learningapp/widgets/customAppBar.dart';
import 'package:learningapp/widgets/videoSelectionCard.dart';

class UnitsPage extends StatelessWidget {
  final String unitName;
  const UnitsPage({super.key, required this.unitName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: Customappbar(title: unitName),
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
            ],
          ),
        ),
      ),
    );
  }
}
