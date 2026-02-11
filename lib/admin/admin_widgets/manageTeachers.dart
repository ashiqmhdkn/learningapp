import 'package:flutter/material.dart';
import 'package:learningapp/api/usersadminapi.dart';
import 'package:learningapp/models/user_model.dart';

class ManageTeachers extends StatelessWidget {
  String token;
  ManageTeachers({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return FutureBuilder<List<User>>(
      future: usersforadmin(token), // async call
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print(snapshot);
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No users found"));
        }

        final users = snapshot.data!;
        return GridView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: users.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            final user = users[index];
            return Column(
              children: [
                CircleAvatar(
                  radius: 34,
                  backgroundImage: user.image != null
                      ? NetworkImage(user.image!)
                      : null,
                  child: user.image == null
                      ? Icon(Icons.person_outline, color: scheme.onSurface)
                      : null,
                  backgroundColor: scheme.tertiary,
                ),
                const SizedBox(height: 6),
                Text(
                  user.username,
                  style: TextStyle(fontSize: 12, color: scheme.onSurface),
                  maxLines: 1, // Restricts the text to a single line
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
