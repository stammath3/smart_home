import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerApp extends StatefulWidget {
  const ImagePickerApp({super.key});

  @override
  State<ImagePickerApp> createState() => _ImagePickerAppState();
}

class _ImagePickerAppState extends State<ImagePickerApp> {
  late File _storedImage;
  var image;
  bool imagefile = false;
  File? a;
  String imageName = "NO IMAGE";

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
        source: ImageSource.gallery, maxWidth: 600, maxHeight: 600);
    final appDir = await syspath.getApplicationDocumentsDirectory();
    if (imageFile != null) {
      print("inside");
      final fileName = path.basename(imageFile.path);
      File file = File(imageFile.path);
      final savedImage = await file.copy('${appDir.path}/$fileName');
      print(savedImage.path);
      setState(() {
        _storedImage = File(imageFile.path);
        imageName = _storedImage.path.toString();
        imagefile = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: [
            SizedBox(height: 100),
            Container(
              height: 100,
              width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black
            ),
            child: imagefile != false //αν η εικονα απο την καμερα εχει δημιουργηθει
            ? Image.file(
                //εμφανισε τη στο κουτι
                _storedImage,
                fit: BoxFit.cover,
                height: 100,
                width: 100,
              )
            :  
            Text(
                  //διαφορετικα εμφανισε ενα κειμενο
                  '',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
        CustomButton(
            title: 'Pick from Gallery',
            icon: Icons.image_outlined,
            onClick: () => _takePicture()),
      ])),
    );
  }
}

Widget CustomButton({
  required String title,
  required IconData icon,
  required VoidCallback onClick,
}) {
  return Container(
    width: 200,
    child: ElevatedButton(
       style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black),
      onPressed: onClick,
      child: Row(children: [Icon(icon), Text(title),]),
    ),
  );
}

Widget CustomRow({
  required IconData icon,
  required String text
}){
  return Row(
  children:  <Widget>[
    Expanded(
      child: Icon(icon),
    ),
    Expanded(
      child: Text(text),
    ),
  ],
  );
}