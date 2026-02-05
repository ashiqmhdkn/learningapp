import 'package:flutter/material.dart';
import 'package:learningapp/models/quiz_model.dart';
import 'package:learningapp/widgets/customBoldText.dart';
import 'package:learningapp/widgets/customPrimaryText.dart';

class QuizReviewPage extends StatelessWidget {
  final String title;
  final String description;
  final List<QuestionModel> questions;

  const QuizReviewPage({
    super.key,
    required this.title,
    required this.description,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Review Quiz")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Title :  $title",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "Description : $description",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            Customboldtext(text: "Questions", fontValue: 24),
            const SizedBox(height: 10),
            ...questions.asMap().entries.map((entry) {
              int idx = entry.key;
              QuestionModel q = entry.value;

              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Q${idx + 1}: ${q.title}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (q.description.isNotEmpty) Text(q.description),
                    const SizedBox(height: 8),

                    if (q.type == QuestionType.multipleChoice)
                      _buildMCQPreview(q)
                    else
                      _buildTextAnswerPreview(q),

                    const SizedBox(height: 8),
                    Text(
                      "Marks: ${q.marks} | Required: ${q.isRequired ? 'Yes' : 'No'}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMCQPreview(QuestionModel q) {
    return Column(
      children: List.generate(q.optionControllers.length, (i) {
        bool isCorrect = q.correctOptionIndex == i;
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isCorrect
                ? Colors.green.withOpacity(0.1)
                : Colors.grey.withOpacity(0.05),
            border: Border.all(
              color: isCorrect ? Colors.green : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                isCorrect ? Icons.check_circle : Icons.circle_outlined,
                color: isCorrect ? Colors.green : Colors.grey,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(q.optionControllers[i].text),
              if (isCorrect) const Spacer(),
              if (isCorrect)
                const Text(
                  "Correct Answer",
                  style: TextStyle(color: Colors.green, fontSize: 12),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTextAnswerPreview(QuestionModel q) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Answer ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          Text(q.answer.isEmpty ? "No answer provided." : q.answer),
        ],
      ),
    );
  }
}
