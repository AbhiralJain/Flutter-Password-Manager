import 'package:hive/hive.dart';
part 'hivedb.g.dart';

@HiveType(typeId: 1, adapterName: "PData")
class ClassDB {
  @HiveField(0)
  String? aname;

  @HiveField(1)
  String? uname;

  @HiveField(2)
  String? paswd;
}
