class UserProfile {
  final String userName;
  final String? fullName;
  final String? dateOfBirth;
  final String? gender;
  final String? nationality;
  final String? phoneNumber;
  final String emailAddress;

  UserProfile({
    required this.userName,
    this.fullName,
    this.dateOfBirth,
    this.gender,
    this.nationality,
    this.phoneNumber,
    required this.emailAddress,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userName: json['username'] ?? '', // Cung cấp giá trị mặc định nếu null
      fullName: json['full_name'] as String?,
      dateOfBirth: json['birth_date'] as String?, // Đảm bảo tên thuộc tính đúng
      gender: json['gender'] as String?,
      nationality: json['nationality'] as String?,
      phoneNumber: json['phone_number'] as String?,
      emailAddress: json['email'] ?? '', // Cung cấp giá trị mặc định nếu null
    );
  }
}
