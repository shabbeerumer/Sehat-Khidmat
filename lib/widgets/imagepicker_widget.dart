import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadPrescriptionField extends StatefulWidget {
  final Function(File?, String) onFileSelected;
  const UploadPrescriptionField({Key? key, required this.onFileSelected})
      : super(key: key);

  @override
  State<UploadPrescriptionField> createState() =>
      _UploadPrescriptionFieldState();
}

class _UploadPrescriptionFieldState extends State<UploadPrescriptionField> {
  final ImagePicker _picker = ImagePicker();
  File? _file;
  String fileName = "No file chosen";

  Future<void> _pickFile() async {
    try {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Choose from Gallery'),
                  onTap: () async {
                    Navigator.pop(context);
                    final XFile? image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      final File file = File(image.path);  // Create File object here
                      setState(() {
                        _file = file;
                        fileName = image.name;
                        widget.onFileSelected(_file, fileName); // Pass _file
                      });
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Take a Photo'),
                  onTap: () async {
                    Navigator.pop(context);
                    final XFile? photo =
                        await _picker.pickImage(source: ImageSource.camera);
                    if (photo != null) {
                      final File file = File(photo.path); // Create File object here
                      setState(() {
                        _file = file;
                        fileName = photo.name;
                        widget.onFileSelected(_file, fileName); // Pass _file
                      });
                    }
                  },
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upload Prescription:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                TextButton(
                  onPressed: _pickFile,
                  child: Text(
                    'Choose file',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    fileName,
                    style: TextStyle(color: Colors.grey[600]),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
