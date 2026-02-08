import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learningapp/models/course_model.dart';
import 'package:learningapp/providers/courses_provider.dart';

class EditCourse extends ConsumerStatefulWidget {
  final Course course;

  const EditCourse({super.key, required this.course});

  @override
  ConsumerState<EditCourse> createState() => _EditCourseState();
}

class _EditCourseState extends ConsumerState<EditCourse> {
  String? newCourseImage; // New local image path
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  bool _isUploading = false;
  bool _keepExistingImage = true; // Flag to track if we keep the network image

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing course data
    _titleController = TextEditingController(text: widget.course.title);
    _descriptionController = TextEditingController(
      text: widget.course.description,
    );
  }

  Future<void> _pickFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      setState(() {
        newCourseImage = result.files.single.path!;
        _keepExistingImage = false; // New image selected, don't keep old one
      });
    }
  }

  void _removeImage() {
    setState(() {
      newCourseImage = null;
      _keepExistingImage = false; // Remove existing image too
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {
        Navigator.pop(context);
      },
      builder: (context) => SizedBox(
        height: 550,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 2),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Edit Course",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 6),
                const Text("Name"),
                const SizedBox(height: 6),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: "Enter Course name",
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text("Description"),
                const SizedBox(height: 6),
                TextField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Enter Course Description",
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text("Image"),
                const SizedBox(height: 8),

                // Image display logic
                _buildImageWidget(),

                const SizedBox(height: 12),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isUploading ? null : _handleUpdate,
                        child: _isUploading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text("Update"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _isUploading
                            ? null
                            : () {
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

  Widget _buildImageWidget() {
    // If new image is selected, show it
    final String baseUrl = "https://media.crescentlearning.org/";
    if (newCourseImage != null) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              File(newCourseImage!),
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: _removeImage,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      );
    }

    // If keeping existing image, show network image
    if (_keepExistingImage && widget.course.course_image.isNotEmpty) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              baseUrl + widget.course.course_image,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[300],
                  ),
                  child: const Icon(Icons.error, size: 40),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[300],
                  ),
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: _removeImage,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      );
    }

    // No image - show picker
    return GestureDetector(
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
            Text("Select Image for the Course"),
            Text("or Browse", style: TextStyle(color: Colors.blue)),
          ],
        ),
      ),
    );
  }

  Future<void> _handleUpdate() async {
    if (_descriptionController.text.isEmpty || _titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields.")),
      );
      return;
    }

    // Check if at least we have an image (either existing or new)
    if (!_keepExistingImage && newCourseImage == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please select an image.")));
      return;
    }

    setState(() {
      _isUploading = true;
    });

    final result = await ref
        .read(coursesNotifierProvider.notifier)
        .updateCourse(
          courseId: widget.course.course_id!,
          title: _titleController.text,
          courseImage: newCourseImage, // null if keeping existing image
          description: _descriptionController.text,
        );

    setState(() {
      _isUploading = false;
    });

    if (context.mounted) {
      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Course updated successfully"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to update course"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
