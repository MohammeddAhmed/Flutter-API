import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vp18_api_app/api/models/process_response.dart';
import 'package:vp18_api_app/get/images_getx_controller.dart';
import 'package:vp18_api_app/utils/context_extension.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  late ImagePicker _imagePicker;
  XFile? _pickedImage;
  double? _progressValue = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Upload Image",
          style: GoogleFonts.poppins(),
        ),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            minHeight: 1,
            backgroundColor: const Color(0XFF6A90F2),
            color: Colors.red.shade400,
            value: _progressValue,
          ),
          Expanded(
            child: _pickedImage != null
                ? Image.file(File(_pickedImage!.path))
                : IconButton(
                    onPressed: () => _pickImage(),
                    icon: const Icon(Icons.camera),
                    iconSize: 70,
                  ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              _performSave();
              Future.delayed(const Duration(seconds: 3), () {
                Navigator.pushReplacementNamed(context, "/images_screen");
              });
            },
            icon: const Icon(Icons.cloud_upload),
            label: const Text("UPLOAD"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0XFF6A90F2),
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    XFile? imageFile = await _imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 100);
    if (imageFile != null) {
      setState(() => _pickedImage = imageFile);
    }
  }

  void _performSave() {
    if (checkData()) {
      _save();
    }
  }

  bool checkData() {
    if (_pickedImage != null) {
      return true;
    }
    context.showSnackBar(message: "Pick Image to upload", erorr: true);
    return false;
  }

  void _save() async {
    _updateProgressValue();
    ProcessResponse processResponse =
        await ImagesGetXController.to.uploadImage(_pickedImage!.path);
    _updateProgressValue(processResponse.success ? 1 : 0);
    context.showSnackBar(
      message: processResponse.message,
      erorr: !processResponse.success,
    );

    setState(() => _pickedImage = null);
  }

  void _updateProgressValue([double? value]) {
    setState(() => _progressValue = value);
  }
}
