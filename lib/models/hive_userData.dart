import 'package:hive/hive.dart';

part 'hive_userData.g.dart';

@HiveType(typeId: 0)
class UserData extends HiveObject {
  @HiveField(0)
  String userName;
  @HiveField(1)
  int userResult;
  @HiveField(2)
  int userId;
  @HiveField(3)
  bool isCurrentUser;
  @HiveField(4)
  DateTime registerDate;

  UserData(
      {this.userName = '',
      this.userResult = 0,
      this.userId = 0,
      this.isCurrentUser = false,
      this.registerDate});
}
