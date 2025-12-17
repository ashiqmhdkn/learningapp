import 'package:flutter/material.dart';
import 'package:learningapp/models/course_model.dart';
import '../models/subject_model.dart';
import '../models/unit_model.dart';
import '../models/video_model.dart';

final courses = <ClassCourse>[
  // CLASS 9
  ClassCourse(
    className: "Class 9",
    subjects: [
      Subject(
        title: 'Mathematics',
        subtitle: 'Algebra, geometry, and more.',
        image: "https://f003.backblazeb2.com/file/crescentlearingapp/images/physics.jpeg",
        color: Colors.indigo,
        units: [
          Unit(
            title: 'Number Systems',
            videos: [
              VideoItem(title: 'Basics of Number Systems', url: "https://videoserver.com/class9/math/number1.mp4"),
              VideoItem(title: 'Rational & Irrational Numbers', url: "https://videoserver.com/class9/math/number2.mp4"),
            ],
          ),
          Unit(
            title: 'Polynomials',
            videos: [
              VideoItem(title: 'Introduction to Polynomials', url: "https://videoserver.com/class9/math/poly1.mp4"),
              VideoItem(title: 'Polynomial Identities', url: "https://videoserver.com/class9/math/poly2.mp4"),
            ],
          ),
          Unit(
            title: 'Geometry',
            videos: [
              VideoItem(title: 'Triangles Basics', url: "https://videoserver.com/class9/math/geo1.mp4"),
              VideoItem(title: 'Properties of Circles', url: "https://videoserver.com/class9/math/geo2.mp4"),
            ],
          ),
        ],
      ),
      Subject(
        title: 'Biology',
        subtitle: 'Cells, tissues, and life processes.',
        image: "https://f003.backblazeb2.com/file/crescentlearingapp/images/physics.jpeg",
        color: Colors.green,
        units: [
          Unit(
            title: 'Cell Structure',
            videos: [
              VideoItem(title: 'Introduction to Cells', url: "https://videoserver.com/class9/bio/cell1.mp4"),
              VideoItem(title: 'Cell Organelles', url: "https://videoserver.com/class9/bio/cell2.mp4"),
            ],
          ),
          Unit(
            title: 'Tissues',
            videos: [
              VideoItem(title: 'Plant Tissues', url: "https://videoserver.com/class9/bio/tissue1.mp4"),
              VideoItem(title: 'Animal Tissues', url: "https://videoserver.com/class9/bio/tissue2.mp4"),
            ],
          ),
        ],
      ),
      Subject(
        title: 'Chemistry',
        subtitle: 'Atoms, molecules, and reactions.',
        image: "https://f003.backblazeb2.com/file/crescentlearingapp/images/physics.jpeg",
        color: Colors.orange,
        units: [
          Unit(
            title: 'Matter in Our Surroundings',
            videos: [
              VideoItem(title: 'States of Matter', url: "https://videoserver.com/class9/chem/matter1.mp4"),
              VideoItem(title: 'Change of State', url: "https://videoserver.com/class9/chem/matter2.mp4"),
            ],
          ),
          Unit(
            title: 'Atoms & Molecules',
            videos: [
              VideoItem(title: 'Dalton’s Atomic Theory', url: "https://videoserver.com/class9/chem/atoms1.mp4"),
              VideoItem(title: 'Molecular Formula', url: "https://videoserver.com/class9/chem/atoms2.mp4"),
            ],
          ),
        ],
      ),
      Subject(
        title: 'Physics',
        subtitle: 'Motion, force, and energy.',
        image: "https://f003.backblazeb2.com/file/crescentlearingapp/images/physics.jpeg",
        color: Colors.red,
        units: [
          Unit(
            title: 'Motion',
            videos: [
              VideoItem(title: 'Distance and Displacement', url: "https://videoserver.com/class9/physics/motion1.mp4"),
              VideoItem(title: 'Velocity and Acceleration', url: "https://videoserver.com/class9/physics/motion2.mp4"),
            ],
          ),
          Unit(
            title: 'Force & Laws of Motion',
            videos: [
              VideoItem(title: 'Newton’s Laws', url: "https://videoserver.com/class9/physics/force1.mp4"),
              VideoItem(title: 'Applications of Force', url: "https://videoserver.com/class9/physics/force2.mp4"),
            ],
          ),
        ],
      ),
      Subject(
        title: 'Social Science',
        subtitle: 'History, Civics, Geography.',
        image: "https://f003.backblazeb2.com/file/crescentlearingapp/images/physics.jpeg",
        color: Colors.brown,
        units: [
          Unit(
            title: 'French Revolution',
            videos: [
              VideoItem(title: 'Causes of French Revolution', url: "https://videoserver.com/class9/ss/french1.mp4"),
              VideoItem(title: 'Impact of Revolution', url: "https://videoserver.com/class9/ss/french2.mp4"),
            ],
          ),
          Unit(
            title: 'India – Size and Location',
            videos: [
              VideoItem(title: 'Geographical Features', url: "https://videoserver.com/class9/ss/geo1.mp4"),
            ],
          ),
        ],
      ),
      Subject(
        title: 'Hindi',
        subtitle: 'Literature and grammar.',
        image: "https://f003.backblazeb2.com/file/crescentlearingapp/images/physics.jpeg",
        color: Colors.deepOrange,
        units: [
          Unit(
            title: 'Kabir Ke Dohe',
            videos: [
              VideoItem(title: 'Kabir’s Philosophy', url: "https://videoserver.com/class9/hindi/kabir1.mp4"),
            ],
          ),
          Unit(
            title: 'Grammar Basics',
            videos: [
              VideoItem(title: 'Sandhi Rules', url: "https://videoserver.com/class9/hindi/grammar1.mp4"),
            ],
          ),
        ],
      ),
      Subject(
        title: 'English',
        subtitle: 'Prose, poetry, and grammar.',
        image: "https://f003.backblazeb2.com/file/crescentlearingapp/images/physics.jpeg",
        color: Colors.blueGrey,
        units: [
          Unit(
            title: 'The Fun They Had',
            videos: [
              VideoItem(title: 'Story Explanation', url: "https://videoserver.com/class9/english/fun1.mp4"),
            ],
          ),
          Unit(
            title: 'Poetry – The Road Not Taken',
            videos: [
              VideoItem(title: 'Poem Analysis', url: "https://videoserver.com/class9/english/poem1.mp4"),
            ],
          ),
        ],
      ),
    ],
  ),

  // CLASS 10
  ClassCourse(
    className: "Class 10",
    subjects: [
      Subject(
        title: 'Mathematics',
        subtitle: 'Advanced algebra and geometry.',
        image: "https://f003.backblazeb2.com/file/crescentlearingapp/images/physics.jpeg",
        color: Colors.blue,
        units: [
          Unit(
            title: 'Real Numbers',
            videos: [
              VideoItem(title: 'Euclid’s Division Lemma', url: "https://videoserver.com/class10/math/real1.mp4"),
            ],
          ),
          Unit(
            title: 'Trigonometry',
            videos: [
              VideoItem(title: 'Trigonometric Ratios', url: "https://videoserver.com/class10/math/trig1.mp4"),
              VideoItem(title: 'Trigonometric Identities', url: "https://videoserver.com/class10/math/trig2.mp4"),
            ],
          ),
        ],
      ),
      Subject(
        title: 'Biology',
        subtitle: 'Life processes and genetics.',
        image: "https://f003.backblazeb2.com/file/crescentlearingapp/images/physics.jpeg",
        color: Colors.green,
        units: [
          Unit(
            title: 'Life Processes',
            videos: [
              VideoItem(title: 'Nutrition in Plants', url: "https://videoserver.com/class10/bio/life1.mp4"),
              VideoItem(title: 'Respiration in Humans', url: "https://videoserver.com/class10/bio/life2.mp4"),
            ],
          ),
          Unit(
            title: 'Control & Coordination',
            videos: [
              VideoItem(title: 'Nervous System', url: "https://videoserver.com/class10/bio/control1.mp4"),
              VideoItem(title: 'Hormonal Control', url: "https://videoserver.com/class10/bio/control2.mp4"),
            ],
          ),
        ],
      ),
      Subject(
        title: 'Chemistry',
        subtitle: 'Chemical reactions and equations.',
        image: "https://f003.backblazeb2.com/file/crescentlearingapp/images/physics.jpeg",
        color: Colors.orange,
        units: [
          Unit(
            title: 'Chemical Reactions',
            videos: [
              VideoItem(title: 'Types of Reactions', url: "https://videoserver.com/class10/chem/reaction1.mp4"),
              VideoItem(title: 'Balancing Equations', url: "https://videoserver.com/class10/chem/reaction2.mp4"),
            ],
          ),
          Unit(
            title: 'Periodic Classification',
            videos: [
              VideoItem(title: 'Mendeleev’s Table', url: "https://videoserver.com/class10/chem/periodic1.mp4"),
              VideoItem(title: 'Modern Periodic Table', url: "https://videoserver.com/class10/chem/periodic2.mp4"),
            ],
          ),
        ],
      ),
      Subject(
        title: 'Physics',
        subtitle: 'Electricity and magnetism.',
        image: "https://f003.backblazeb2.com/file/crescentlearingapp/images/physics.jpeg",
        color: Colors.red,
        units: [

          Unit(
            title: 'Electricity',
            videos: [
              VideoItem(
                title: 'Ohm’s Law',
                url: "https://videoserver.com/class10/physics/electricity1.mp4",
              ),
            ],
          ),
        ],
      ),
      Subject(
        title: 'Social Science',
        subtitle: 'History, Civics, Geography, Economics.',
        image: "https://f003.backblazeb2.com/file/crescentlearingapp/images/physics.jpeg",
        color: Colors.brown,
        units: [
          Unit(
            title: 'Nationalism in India',
            videos: [
              VideoItem(
                title: 'Gandhi’s Role',
                url: "https://videoserver.com/class10/ss/nationalism1.mp4",
              ),
            ],
          ),
        ],
      ),
      Subject(
        title: 'Hindi',
        subtitle: 'Literature and grammar.',
        image: "https://f003.backblazeb2.com/file/crescentlearingapp/images/physics.jpeg",
        color: Colors.deepOrange,
        units: [
          Unit(
            title: 'Poem – Dust of Snow',
            videos: [
              VideoItem(
                title: 'Explanation of Poem',
                url: "https://videoserver.com/class10/hindi/poem1.mp4",
              ),
            ],
          ),
        ],
      ),
      Subject(
        title: 'English',
        subtitle: 'Prose, poetry, and grammar.',
        image: "https://f003.backblazeb2.com/file/crescentlearingapp/images/physics.jpeg",
        color: Colors.blueGrey,
        units: [
          Unit(
            title: 'First Flight',
            videos: [
              VideoItem(
                title: 'A Letter to God',
                url: "https://videoserver.com/class10/english/letter1.mp4",
              ),
            ],
          ),
        ],
      ),
    ],
  ),
];
