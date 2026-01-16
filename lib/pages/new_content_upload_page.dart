import 'package:flutter/material.dart';

class NewContentUploadPage extends StatelessWidget {
  const NewContentUploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Content Upload"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Type Exam, Video, unit"),
            const SizedBox(height: 6),

            DropdownButtonFormField<String>(
              value: "Video",
              items: const [
                DropdownMenuItem(value: "Exam", child: Text("Exam")),
                DropdownMenuItem(value: "Video", child: Text("Video")),
                DropdownMenuItem(value: "Unit", child: Text("Unit")),
              ],
              onChanged: (value) {},
              decoration: InputDecoration(
                filled: true,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Text("Name"),
            const SizedBox(height: 6),

            TextField(
              decoration: InputDecoration(
                hintText: "Enter content name",
                filled: true,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Text("File"),
            const SizedBox(height: 8),

            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.cloud_upload_outlined, size: 40),
                  SizedBox(height: 8),
                  Text("Drag & Drop File Here"),
                  Text("or Browse", style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: const [
                Icon(Icons.image, color: Colors.green),
                SizedBox(width: 8),
                Text("No file selected"),
              ],
            ),

            const Spacer(),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Upload"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text("Cancel"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
