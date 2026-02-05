import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learningapp/providers/subject_provider.dart';

class AddSubject extends ConsumerStatefulWidget {
  const AddSubject({super.key});

  @override
  ConsumerState<AddSubject> createState() => _AddSubjectState();
}

class _AddSubjectState extends ConsumerState<AddSubject> {
  String subjectImage = "";
  final TextEditingController _titleController = TextEditingController();
  bool _isUploading = false;

  Future<void> _pickFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      setState(() {
        subjectImage = result.files.single.path!;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {
        Navigator.pop(context);
      },
      builder: (context) => SizedBox(
        height: 390,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8,0,8,16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Subject Upload",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 6),
                const Text("Name"),
                const SizedBox(height: 6),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: "Enter Subject name",
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text("File"),
                const SizedBox(height: 8),
                
                // Image selection/preview
                if (subjectImage == "")
                  GestureDetector(
                    onTap: () => _pickFile(context),
                    child: Container(
                      height: 160,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cloud_upload_outlined, size: 40),
                          SizedBox(height: 8),
                          Text("Select Image for the Subject"),
                          Text("or Browse", style: TextStyle(color: Colors.blue)),
                        ],
                      ),
                    ),
                  )
                else
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(subjectImage),
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              subjectImage = "";
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 12),
                
                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isUploading ? null : () async {
                          if (subjectImage != "" &&_titleController.text.isNotEmpty) {
                            setState(() {
                              _isUploading = true;
                            });

                            final result = await ref
                                .read(subjectsNotifierProvider.notifier)
                                .createSubject(      
                                  title: _titleController.text,
                                  subjectImage: subjectImage,
                                );

                            setState(() {
                              _isUploading = false;
                            });

                            if (context.mounted) {
                              if (result) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Subject created successfully"),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Failed to create subject"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please fill all fields and select a file."),
                              ),
                            );
                          }
                        },
                        child: _isUploading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text("Upload"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _isUploading ? null : () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}