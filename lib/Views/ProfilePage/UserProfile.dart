import 'package:flutter/material.dart';
import 'package:ecommerce_mobile_application/services/user_profile_service.dart';
import 'package:ecommerce_mobile_application/models/user_profile.dart';
import 'package:ecommerce_mobile_application/Views/UpdateUserProfilePage/UpdateUserProfilePage.dart'; // Import UpdateUserProfilePage

class AccountInfoPage extends StatefulWidget {
  @override
  _AccountInfoPageState createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage> {
  UserProfile? userProfile;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      UserProfileService userProfileService = UserProfileService();
      UserProfile? profile = await userProfileService.getUserProfile();
      setState(() {
        userProfile = profile;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error (e.g., show a dialog or a message)
      print("Error loading user profile: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin tài khoản'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : userProfile == null
          ? Center(child: Text('Không thể tải thông tin tài khoản'))
          : Column(
        children: [
          SizedBox(height: 20),
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  child: Icon(Icons.person, size: 50, color: Colors.blue),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.edit, size: 15, color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Họ & Tên'),
                  subtitle: Text(userProfile?.fullName ?? 'Thêm thông tin'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateUserProfilePage(
                          currentProfile: userProfile,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.cake),
                  title: Text('Ngày sinh'),
                  subtitle: Text(userProfile?.dateOfBirth ?? 'Thêm ngày, tháng, năm sinh'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateUserProfilePage(
                          currentProfile: userProfile,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.wc),
                  title: Text('Giới tính'),
                  subtitle: Text(userProfile?.gender ?? 'Thêm thông tin giới tính'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateUserProfilePage(
                          currentProfile: userProfile,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.public),
                  title: Text('Quốc tịch'),
                  subtitle: Text(userProfile?.nationality ?? 'Thêm thông tin quốc tịch'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateUserProfilePage(
                          currentProfile: userProfile,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Số điện thoại'),
                  subtitle: Text(userProfile?.phoneNumber ?? 'Thêm số điện thoại'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateUserProfilePage(
                          currentProfile: userProfile,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text('Email'),
                  subtitle: Text(userProfile!.emailAddress),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateUserProfilePage(
                          currentProfile: userProfile,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
