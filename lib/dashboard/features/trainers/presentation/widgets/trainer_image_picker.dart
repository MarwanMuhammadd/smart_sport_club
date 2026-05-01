import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TrainerImagePicker extends StatefulWidget {
  final Function(XFile?, Uint8List?) onImageSelected;

  const TrainerImagePicker({super.key, required this.onImageSelected});

  @override
  State<TrainerImagePicker> createState() => _TrainerImagePickerState();
}

class _TrainerImagePickerState extends State<TrainerImagePicker> {
  Uint8List? _imageBytes;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _imageBytes = bytes;
        });
        widget.onImageSelected(pickedFile, bytes);
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _pickImage,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: _imageBytes != null
              ? ClipOval(
                  child: Image.memory(
                    _imageBytes!,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, color: Colors.grey[400], size: 30),
                    const SizedBox(height: 4),
                    Text(
                      'Upload',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
