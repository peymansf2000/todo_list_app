import 'package:objectbox/objectbox.dart';

@Entity()
class Task {
 
  @Id()
  int id = 0;
  String name = '' ;
  bool status = false;
  // objectbox: convert 
  int priority = 0;


  Task({required this.name, required this.priority});

}


