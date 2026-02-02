import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learningapp/api/coursesapi.dart';
import 'package:learningapp/models/course_model.dart';
import 'package:learningapp/teacher/providers/fileprovider.dart';

class Coursebottomsheet extends ConsumerWidget {
  Coursebottomsheet({super.key});
   String course_image="";
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _descreptioncontroller = TextEditingController();
  Future<void> _pickFile(BuildContext context) async {
  final result = await FilePicker.platform.pickFiles(type: FileType.image);
  if (result != null && result.files.single.path != null) {
    course_image = result.files.single.path!;
  }
}



  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return BottomSheet(
      onClosing: (){Navigator.pop(context);},
     builder:(context) => SizedBox(
      height: 500,
       child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text("Course Upload",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                const SizedBox(height: 6),
                const Text("Name"),
                const SizedBox(height: 6),
                   
                TextField(
                  onChanged: (value) {
                    _titlecontroller.text = value;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Course name",
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                   
                const SizedBox(height: 16),
                 const Text("Descreption"),
                const SizedBox(height: 6),
              
                TextField(
                  onChanged: (value) {
                    _descreptioncontroller.text = value;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Course Descreption",
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                   
                const SizedBox(height: 16),
                   
                const Text("File"),
                    const SizedBox(height: 8),
            
            // Check if course_image is not null and not empty
            if (course_image=="")
              GestureDetector(
                onTap: () => _pickFile(context),
                child: Container(
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
            Text("Select Image for the Courses"),
            Text("or Browse", style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                ),
              )
            else
              Image.file(
                File(course_image),
                height: 120,
                fit: BoxFit.cover,
              ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                     onPressed: () async {
                        if (course_image != "" &&
                            _descreptioncontroller.text.isNotEmpty &&
                            _titlecontroller.text.isNotEmpty) {
                          String result = await coursespost(
                            title: _titlecontroller.text, courseImage:course_image, description:_descreptioncontroller.text,
                            token:"eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiNzJmNjFlYmQtYTM2ZS00YTRmLTgwMjctZGFhZjMxYjg1NWYxIiwicm9sZSI6ImFkbWluIiwiZXhwIjoxNzcwMjEzODk5fQ.u_z-xly9s-Glkj0WiHANps9uc05eyEu2pWMgPik63mI");
                          if (result.isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(result)),
                            );
                          }
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please fill all fields and select a file.")),
                          );
                        }
                      },
                      child: const Text("Upload"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          _titlecontroller.value = TextEditingValue.empty;
                          _descreptioncontroller.value=TextEditingValue.empty;
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