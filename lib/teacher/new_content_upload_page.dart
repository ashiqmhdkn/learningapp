// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class NewContentUploadPage extends ConsumerWidget {
//  NewContentUploadPage({super.key});
//   final TextEditingController _titlecontroller = TextEditingController();
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("New Content Upload"),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("Type Exam, Video, unit"),
//             const SizedBox(height: 6),

//             DropdownButtonFormField<String>(
//               value: "Video",
//               items: const [
//                 DropdownMenuItem(value: "Exam", child: Text("Exam")),
//                 DropdownMenuItem(value: "Video", child: Text("Video")),
//                 DropdownMenuItem(value: "Notes", child: Text("Notes")),
//               ],
//               onChanged: (value) {},
//               decoration: InputDecoration(
//                 filled: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
                  
//                 ),
//               ),
//             ),

//             const SizedBox(height: 16),

//             const Text("Name"),
//             const SizedBox(height: 6),

//             TextField(
//               onChanged: (value) {
//                 _titlecontroller.text = value;
//               },
//               decoration: InputDecoration(
//                 hintText: "Enter content name",
//                 filled: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 16),

//             const Text("File"),
//             const SizedBox(height: 8),
//           fileState.selectedFile != null
//               ? Row(
//               children: [
//                 Icon(Icons.image,
//                     color: fileState.selectedFile != null
//                         ? Colors.green
//                         : Colors.grey),
//                 const SizedBox(width: 8),
//                 Text(fileState.selectedFile != null
//                     ? fileState.selectedFile!.path.split('/').last
//                     : "No file selected"),
//               ],
//             ):GestureDetector(
//               onTap: fileNotifier.pickFile,
//               child: Container(
//                 height: 160,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.grey),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     Icon(Icons.cloud_upload_outlined, size: 40),
//                     SizedBox(height: 8),
//                     Text("Drag & Drop File Here"),
//                     Text("or Browse", style: TextStyle(color: Colors.blue)),
//                   ],
//                 ),
//               ),
//             ),
// const SizedBox(height: 12),
//             if (fileState.selectedFile != null)
//               Padding(
//                 padding: const EdgeInsets.only(top: 12),
//                 child: Image.file(
//                   fileState.selectedFile!,
//                   height: 120,
//                   fit: BoxFit.cover,
//                 ),
//               ),

//             const Spacer(),

//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () async{
//                       if (fileState.selectedFile != null &&
//                           !fileState.isUploading) {
//                         String result = await fileNotifier.upload(_titlecontroller.text,"62443f1a-0ded-4096-b9e6-c40ebd88ac44");
//                         if (result != null) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text(result),
//                             ),
//                           );
//                         }
//                         Navigator.pop(context);
//                       }
//                       else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text("Please select a file to upload."),
//                           ),
//                         );
//                       }
//                     },
//                     child: fileState.isUploading
//                         ? const CircularProgressIndicator()
//                         : const Text("Upload"),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: OutlinedButton(
//                     onPressed: () {
//                       _titlecontroller.value = TextEditingValue.empty;
//                       fileState.selectedFile?.delete();
//                       Navigator.pop(context);
//                     },
//                     child: const Text("Cancel"),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }