import 'package:flutter/material.dart';
import 'package:learningapp/models/quiz_model.dart';
import 'package:learningapp/teacher/quiz/question_typesheet.dart';
import 'package:learningapp/teacher/quiz/quiz_review_page.dart';
import 'package:learningapp/teacher/quiz/textquestion_editorsheet.dart';
import 'package:learningapp/widgets/customAppBar.dart';
import 'package:learningapp/widgets/customButtonOne.dart';
import 'package:learningapp/widgets/customTextBox.dart';
import 'package:learningapp/widgets/snackbar.dart';

class QuizCreation extends StatefulWidget {
  const QuizCreation({super.key});

  @override
  State<QuizCreation> createState() => _QuizCreationState();
}

class _QuizCreationState extends State<QuizCreation> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final List<QuestionModel> _questions = [];

  void _openEditor(QuestionModel q, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        if (q.type == QuestionType.multipleChoice) {
          return MCQQuestionEditorSheet(
            question: q,
            onUpdate: () => setState(() {}),
            onDelete: () {
              Navigator.pop(context);
              setState(() => _questions.removeAt(index));
            },
          );
        }
        return TextQuestionEditorSheet(
          question: q,
          onUpdate: () => setState(() {}),
          onDelete: () {
            Navigator.pop(context);
            setState(() => _questions.removeAt(index));
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Customappbar(title: "Create Questions"),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Customtextbox(
                hinttext: "Quiz Title",
                textController: _titleController,
                textFieldIcon: Icons.title,
              ),
              const SizedBox(height: 10),
              Customtextbox(
                hinttext: "Quiz Description",
                textController: _descriptionController,
                textFieldIcon: Icons.description,
              ),
              const SizedBox(height: 20),

              ...List.generate(
                _questions.length,
                (i) => TextQuestionCard(
                  index: i,
                  question: _questions[i],
                  onTap: () => _openEditor(_questions[i], i),
                  onDelete: () {
                    setState(() => _questions.removeAt(i));
                  },
                  onUpdate: () => setState(() {}),
                ),
              ),

              const SizedBox(height: 10),

              Custombuttonone(
                text: "Add New",
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => QuestionTypeSheet(
                      onSelect: (type) {
                        Navigator.pop(context);
                        setState(() {
                          _questions.add(
                            QuestionModel(
                              type: type,
                              options: type == QuestionType.multipleChoice
                                  ? ['']
                                  : [],
                              correctOptionIndex: 0,
                            ),
                          );
                        });
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              Custombuttonone(
                text: "Review ",
                onTap: () {
                  if (_titleController.text.trim().isEmpty) {
                    AppSnackBar.show(context, message: "Enter a title ");
                  } else if (_questions.isEmpty) {
                    AppSnackBar.show(
                      context,
                      message: "Have atleast one question ",
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizReviewPage(
                          title: _titleController.text,
                          description: _descriptionController.text,
                          questions: _questions,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextQuestionCard extends StatelessWidget {
  final int index;
  final QuestionModel question;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;
  const TextQuestionCard({
    super.key,
    required this.index,
    required this.question,
    required this.onTap,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        color: Theme.of(context).colorScheme.tertiary,
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${index + 1}. ${question.title.isEmpty ? "Untitled" : question.title}",
                style: TextStyle(fontSize: 17),
              ),
              if (question.description.isNotEmpty)
                Text(
                  question.description,
                  style: const TextStyle(color: Colors.grey),
                ),
              const SizedBox(height: 8),
              Text(
                question.type == QuestionType.multipleChoice
                    ? "${question.optionControllers.length} options"
                    : "Answer: ${question.answer.isEmpty ? "Not specified" : question.answer}",
                style: const TextStyle(color: Colors.redAccent),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text("Marks : ${question.marks} "),
                  const Spacer(),
                  Switch(
                    value: question.isRequired,
                    onChanged: (v) {
                      question.isRequired = v;
                      onUpdate();
                    },
                    activeThumbColor: Colors.green,
                    inactiveThumbColor: Colors.red,
                  ),

                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: onDelete,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextQuestionEditorSheet extends StatelessWidget {
  final QuestionModel question;
  final VoidCallback onUpdate;
  final VoidCallback onDelete;

  const TextQuestionEditorSheet({
    super.key,
    required this.question,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return BaseEditor(
      title: "Edit Question",
      onDelete: onDelete,
      children: [
        (s) => field("Title", question.title, (v) {
          question.title = v;
          onUpdate();
        }),
        (s) => field("Description", question.description, (v) {
          question.description = v;
          onUpdate();
        }),
        (s) => field("Answer", question.answer, (v) {
          question.answer = v;
          onUpdate();
        }),
        (s) => marks(question, onUpdate),
        (s) => required(question, onUpdate, s),
      ],
    );
  }
}

Widget required(
  QuestionModel q,
  VoidCallback onUpdate,
  void Function(void Function()) setSheetState,
) {
  return SwitchListTile(
    title: const Text("Required"),
    value: q.isRequired,
    onChanged: (v) {
      q.isRequired = v;
      setSheetState(() {});
      onUpdate();
    },
  );
}

class MCQQuestionEditorSheet extends StatelessWidget {
  final QuestionModel question;
  final VoidCallback onUpdate;
  final VoidCallback onDelete;

  const MCQQuestionEditorSheet({
    super.key,
    required this.question,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return BaseEditor(
      title: "Edit Multiple Choice",
      onDelete: onDelete,
      children: [
        (s) => field("Title", question.title, (v) {
          question.title = v;
          onUpdate();
        }),
        (s) => field("Description", question.description, (v) {
          question.description = v;
          onUpdate();
        }),
        (s) => buildMCQEditor(
          question: question,
          onUpdate: onUpdate,
          setSheetState: s,
        ),
        (s) => marks(question, onUpdate),
        (s) => required(question, onUpdate, s),
      ],
    );
  }
}

Widget buildMCQEditor({
  required QuestionModel question,
  required VoidCallback onUpdate,
  required void Function(void Function()) setSheetState,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text("Options (Remember to Select one)"),
      const SizedBox(height: 10),
      ...List.generate(
        question.optionControllers.length,
        (i) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Radio<int>(
                value: i,
                groupValue: question.correctOptionIndex,
                onChanged: (v) {
                  setSheetState(() {
                    question.correctOptionIndex = v;
                  });
                  onUpdate();
                },
              ),
              Expanded(
                child: TextField(
                  controller: question.optionControllers[i],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Option ${i + 1}",
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setSheetState(() {
                    question.optionControllers.removeAt(i);
                    if (question.correctOptionIndex == i) {
                      question.correctOptionIndex = null;
                    }
                  });
                  onUpdate();
                },
              ),
            ],
          ),
        ),
      ),
      TextButton.icon(
        icon: const Icon(Icons.add),
        label: const Text("Add option"),
        onPressed: () {
          setSheetState(() {
            question.optionControllers.add(TextEditingController());
          });
          onUpdate();
        },
      ),
    ],
  );
}

class BaseEditor extends StatelessWidget {
  final String title;
  final List<Widget Function(void Function(void Function()))> children;

  final VoidCallback onDelete;

  const BaseEditor({
    required this.title,
    required this.children,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setSheetState) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ...children.map((builder) => builder(setSheetState)),

                TextButton.icon(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  label: const Text(
                    "Delete",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: onDelete,
                ),
                Center(
                  child: Custombuttonone(
                    text: "Save",
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
