import 'package:hive_flutter/hive_flutter.dart';
part 'model.g.dart';

@HiveType(typeId: 0)
class StudentModel {

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String phone;

  @HiveField(3)
  String address;

  @HiveField(4)
  String imagePath;

  
  StudentModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.imagePath,
  });
}