import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kriscent_assignment/controllers/profile/profile_controller.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../widgets/custom_button.dart';

class UpdateProfileScreen extends StatefulWidget {
  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  File? _image;
  final picker = ImagePicker();
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  String _gender = 'Select Gender';
  final ProfileController _firebaseService = ProfileController();

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _requestPermissions() async {
    final statuses = await [
      Permission.camera,
      Permission.photos, // for gallery access
    ].request();

    if (statuses[Permission.camera] != PermissionStatus.granted ||
        statuses[Permission.photos] != PermissionStatus.granted) {
    }
  }

  Future<void> _saveProfile() async {
    if (_nameController.text.isEmpty ||
        _bioController.text.isEmpty ||
        _gender == 'Select Gender') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please complete all fields'),
      ));
      return;
    }

    try {
      String? imageUrl;
      if (_image != null) {
        imageUrl = await _firebaseService.uploadImage(_image!);
      }

      if (imageUrl != null) {
        await _firebaseService.updateUserProfile(
          name: _nameController.text,
          bio: _bioController.text,
          gender: _gender,
          imageUrl: imageUrl,
        );

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Profile updated!'),
        ));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please select an image'),
        ));
      }
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred, please try again later'),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () => _showImageSourceDialog(),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                  _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? const Icon(
                    Icons.add_a_photo,
                    size: 50,
                    color: Colors.grey,
                  )
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _bioController,
                decoration: InputDecoration(
                  labelText: 'Bio',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _gender,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: <String>['Select Gender', 'Male', 'Female', 'Other']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _gender = newValue!;
                  });
                },
              ),
              SizedBox(height: 20),
              CustomButton(text: 'Save Profile', onPressed: () =>_saveProfile())
              // ElevatedButton(
              //   onPressed: _saveProfile,
              //   child: Text('Save Profile'),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.grey,
              //     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Choose Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera),
              title: Text('Camera'),
              onTap: () {
                Navigator.of(context).pop();
                _getImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text('Gallery'),
              onTap: () {
                Navigator.of(context).pop();
                _getImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }
}
