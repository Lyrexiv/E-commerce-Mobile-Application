import 'package:flutter/material.dart';
import 'package:ecommerce_mobile_application/services/user_profile_service.dart';
import 'package:ecommerce_mobile_application/models/user_profile.dart';

class UpdateUserProfilePage extends StatefulWidget {
  final UserProfile? currentProfile;

  UpdateUserProfilePage({this.currentProfile});

  @override
  _UpdateUserProfilePageState createState() => _UpdateUserProfilePageState();
}

class _UpdateUserProfilePageState extends State<UpdateUserProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _dateOfBirthController;
  late TextEditingController _genderController;
  late TextEditingController _nationalityController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.currentProfile?.fullName ?? '');
    _dateOfBirthController = TextEditingController(text: widget.currentProfile?.dateOfBirth ?? '');
    _genderController = TextEditingController(text: widget.currentProfile?.gender ?? '');
    _nationalityController = TextEditingController(text: widget.currentProfile?.nationality ?? '');
    _phoneNumberController = TextEditingController(text: widget.currentProfile?.phoneNumber ?? '');
    _emailController = TextEditingController(text: widget.currentProfile?.emailAddress ?? '');
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _dateOfBirthController.dispose();
    _genderController.dispose();
    _nationalityController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Ensure userName is available
        final userName = widget.currentProfile?.userName ?? '';

        UserProfile updatedProfile = UserProfile(
          userName: userName, // Include userName
          fullName: _fullNameController.text,
          dateOfBirth: _dateOfBirthController.text,
          gender: _genderController.text,
          nationality: _nationalityController.text,
          phoneNumber: _phoneNumberController.text,
          emailAddress: _emailController.text,
        );

        bool success = await UserProfileService().updateUserProfile(updatedProfile);

        if (success) {
          Navigator.pop(context, updatedProfile);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Cập nhật thông tin thành công')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Cập nhật thông tin không thành công')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cập nhật thông tin'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(labelText: 'Họ & Tên'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập họ tên';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateOfBirthController,
                decoration: InputDecoration(labelText: 'Ngày sinh'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập ngày sinh';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _genderController,
                decoration: InputDecoration(labelText: 'Giới tính'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập giới tính';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nationalityController,
                decoration: InputDecoration(labelText: 'Quốc tịch'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập quốc tịch';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Số điện thoại'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số điện thoại';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Email không hợp lệ';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProfile,
                child: Text('Lưu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
