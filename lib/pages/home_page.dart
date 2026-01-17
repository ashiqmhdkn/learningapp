import 'package:flutter/material.dart';
import 'package:learningapp/pages/unitsPage.dart';
import 'package:learningapp/pages/videoPlayBack.dart';
import 'package:learningapp/widgets/customAppBar.dart';
import 'package:learningapp/widgets/practiceTIle2.dart';

import 'package:learningapp/widgets/practiseTile.dart';
import 'package:learningapp/widgets/previousLearned.dart';
import 'package:learningapp/pages/login.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Customappbar(title: "Username"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) {
                return Login();
              },
            ),
          );
        },

        child: Icon(Icons.login),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 3, 8, 3),
            child: Text(
              "Ready To learn?",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 3, 8, 18),
            child: Text(
              "Continue where you left of ",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),

          SizedBox(
            height: 180,
            child: ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                Previouslearned(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) {
                          return Videoplayback();
                        },
                      ),
                    );
                  },
                  title: "Maths",
                  subtitle: "Subtitle1",
                  progress: 0.9,
                  color: Colors.purple,
                  icon: Icons.numbers,
                ),
                Previouslearned(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) {
                              return Videoplayback();
                        },
                      ),
                    );
                  },
                  title: "English",
                  subtitle: "Subtitle",
                  progress: 0.6,
                  color: Colors.blue,
                  icon: Icons.language,
                ),
                Previouslearned(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) {
                          return Videoplayback();
                        },
                      ),
                    );
                  },
                  title: "Computer",
                  subtitle: "Data Structure",
                  progress: 0.4,
                  color: Colors.orange,
                  icon: Icons.computer,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 8, 3),
            child: Text(
              "Practice",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              children: [
                PracticeTile2(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) {
                          return Unitspage(unitName: "unitName");
                        },
                      ),
                    );
                  },
                  title: "Maths",
                  backGroundImage: 'lib/assets/maths.jpeg',
                ),
                PracticeTile(
                  title: "physics",
                  backGroundImage: 'lib/assets/physics.jpeg',
                ),
                PracticeTile(
                  title: "Biology",
                  backGroundImage: 'lib/assets/biology.jpeg',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
