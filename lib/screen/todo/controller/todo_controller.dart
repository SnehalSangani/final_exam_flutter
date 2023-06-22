import 'package:get/get.dart';

import '../../../utils/database_helper.dart';

class Todocontroller extends GetxController {
  RxList<Map> TodoList = <Map>[].obs;
  Rx<DateTime> current = DateTime.now().obs;
  Rx<DateTime> date = DateTime.now().obs;
  Rx<DateTime> Date = DateTime.now().obs;
  RxList<String> priority=<String>[
    "Urgent",
    "High",
    "Low"
  ].obs;
  var selectpr="Urgent".obs;

  Future<void> readtodo() async {
    Dbhelper dbhelper = Dbhelper();
    TodoList.value = await dbhelper.readdata();
  }

  void delettodo(int id) {
    Dbhelper dbhelper = Dbhelper();
    dbhelper.deletedata(id: id);
    readtodo();
  }

  void updatetodo(int id, String title, String date, String time, String desc,
      String priority) {
    Dbhelper dbhelper = Dbhelper();
    dbhelper.updatedata(
        id: id,
        title: title,
        desc: desc,
        time: time,
        date: date,
        priority: priority);
    readtodo();
  }
}
