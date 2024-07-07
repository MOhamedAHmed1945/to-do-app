// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  static const collectionName = 'users';
  String? userId;
  String? userName;
  String? userEmail;
  UserModel({
    required this.userId,
    required this.userName,
    required this.userEmail,
  });

  UserModel.userDataFromFireStore(Map<String, dynamic>? data)
      : this(
          userId: data?['id'] as String,
          userName: data?['name'] as String,
          userEmail: data?['email'] as String,
        );

  Map<String, dynamic> userDataToFireStore() {
    return {
      'id': userId,
      'name': userName,
      'email': userEmail,
    };
  }
}
