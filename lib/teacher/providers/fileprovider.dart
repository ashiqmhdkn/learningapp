import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;
import 'package:learningapp/api/units.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FileState {
  final File? selectedFile;
  final bool isUploading;
  final String? uploadedUrl;

  FileState({
    this.selectedFile,
    this.isUploading = false,
    this.uploadedUrl,
  });

  FileState copyWith({
    File? selectedFile,
    bool? isUploading,
    String? uploadedUrl,
  }) {
    return FileState(
      selectedFile: selectedFile ?? this.selectedFile,
      isUploading: isUploading ?? this.isUploading,
      uploadedUrl: uploadedUrl ?? this.uploadedUrl,
    );
  }
}


class FileNotifier extends StateNotifier<FileState> {
  FileNotifier() : super(FileState());

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      state = state.copyWith(selectedFile: File(result.files.single.path!));
    }
  }
    void clear() {
    state = FileState(selectedFile: null, isUploading: false);
  }

  Future<String> upload(String unitname, String subjectId) async {
    if (state.selectedFile == null) return "not attached image";

    try {
      state = state.copyWith(isUploading: true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      final url = await unitsupload(state.selectedFile!, unitname, subjectId,"eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZDRhYWIxODQtZmRjNC00YzIxLWE1ZTYtZjU3MWU1YmE5MGExIiwicm9sZSI6InRlYWNoZXIiLCJleHAiOjE3NzAxMjEwNDR9.VsfTwZulbL-YYRT1lPtTwO7mDH8HnhB8fcRaLF_Pyug");

      state = state.copyWith(
        isUploading: false,
        uploadedUrl: url,
      );
      return url;

    } catch (e) {
      state = state.copyWith(isUploading: false);
      print("Upload error: $e");
      return "Upload error: $e";
    }
  }
}


final fileProvider = StateNotifierProvider<FileNotifier, FileState>(
  (ref) => FileNotifier(),
);
