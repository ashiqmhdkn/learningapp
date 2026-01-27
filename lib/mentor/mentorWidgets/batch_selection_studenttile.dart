import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learningapp/providers/batch_selection_provider.dart';

class BatchSelectionStudenttile extends ConsumerWidget {
  final String id;
  final String name;

  const BatchSelectionStudenttile({
    super.key,
    required this.id,
    required this.name,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(batchSelectionProvider).contains(id);

    return SizedBox(
      height: 75,
      child: Card(
        color: Theme.of(context).colorScheme.tertiary,
        child: Center(
          child: ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage("lib/assets/image.png"),
            ),
            title: Text(name),
            trailing: Checkbox(
              value: selected,
              onChanged: (_) {
                ref.read(batchSelectionProvider.notifier).toggleStudent(id);
              },
            ),
            onTap: () {
              ref.read(batchSelectionProvider.notifier).toggleStudent(id);
            },
          ),
        ),
      ),
    );
  }
}
