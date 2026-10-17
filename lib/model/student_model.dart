class StudentModel {
  const StudentModel({
    this.fullName,
    this.collegeId,
    this.year,
    this.universityEmail,
    this.semester,
    this.department,
    this.password,
  });

  final String? fullName;
  final String? collegeId;
  final String? year;
  final String? universityEmail;
  final String? semester;
  final String? department;
  final String? password;

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'college_id': collegeId,
      'year': year,
      'university_email': universityEmail,
      'semester': semester,
      'department': department,
    };
  }

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      fullName: json['full_name'] as String?,
      collegeId: json['college_id'] as String?,
      year: json['year'] as String?,
      universityEmail: (json['university_email'] ?? json['email']) as String?,
      semester: json['semester'] as String?,
      department: (json['department'] ?? json['major']) as String?,
    );
  }
}
