import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learningapp/providers/batch_selection_provider.dart';
import 'package:learningapp/widgets/customAppBar.dart';
import 'package:learningapp/widgets/customPrimaryText.dart';
import 'package:learningapp/widgets/customTextBox.dart';
import '../mentorWidgets/batch_selection_studenttile.dart';

class NewBatchCreation extends ConsumerStatefulWidget {
  const NewBatchCreation({super.key});

  @override
  ConsumerState<NewBatchCreation> createState() => _NewBatchCreationState();
}

class _NewBatchCreationState extends ConsumerState<NewBatchCreation> {
  final TextEditingController _batchNameController = TextEditingController();

  final List<String> studentIds = List.generate(10, (i) => "stu_$i");

  @override
  Widget build(BuildContext context) {
    final selected = ref.watch(batchSelectionProvider);

    return Scaffold(
      appBar: Customappbar(title: "Create a new Batch"),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: Customprimarytext(text: "Name", fontValue: 20),
            ),
            Customtextbox(
              hinttext: "Enter batch name",
              textController: _batchNameController,
              textFieldIcon: Icons.abc,
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value:
                            selected.length == studentIds.length &&
                            studentIds.isNotEmpty,
                        onChanged: (value) {
                          if (value == true) {
                            ref
                                .read(batchSelectionProvider.notifier)
                                .selectAll(studentIds);
                          } else {
                            ref
                                .read(batchSelectionProvider.notifier)
                                .clearAll();
                          }
                        },
                      ),
                      const Text("Select all"),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_alt),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: studentIds.length,
                itemBuilder: (context, index) {
                  return BatchSelectionStudenttile(
                    id: studentIds[index],
                    name: "Name $index",
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
