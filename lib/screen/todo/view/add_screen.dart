import 'package:final_exam_flutter/screen/todo/controller/todo_controller.dart';
import 'package:final_exam_flutter/utils/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Add_screen extends StatefulWidget {
  const Add_screen({Key? key}) : super(key: key);

  @override
  State<Add_screen> createState() => _Add_screenState();
}

class _Add_screenState extends State<Add_screen> {
  Todocontroller todocontroller = Get.put(Todocontroller());
  TextEditingController txttitle = TextEditingController();
  TextEditingController txtdesc = TextEditingController();
  TextEditingController txttime = TextEditingController(
      text: "${TimeOfDay
          .now()
          .hour}:${TimeOfDay
          .now()
          .minute}"
  );
  TextEditingController txtdate = TextEditingController();
  TextEditingController txtpr = TextEditingController();


  @override
  void initState() {
    super.initState();
    Dbhelper dbhelper = Dbhelper();
    dbhelper.checkdb();
  }

  @override
  Widget build(BuildContext context) {
    txtdate = TextEditingController(
        text:
            '${todocontroller.current.value.day}/${todocontroller.current.value.month}/${todocontroller.current.value.year}');
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Add Screen"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: txttitle,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  hintText: 'Enter Title',
                  label: Text("Ttile"),
                  labelStyle: TextStyle(color: Colors.blueGrey),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextField(
                controller: txtdesc,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  hintText: 'Enter Description',
                  label: Text("Desc"),
                  labelStyle: TextStyle(color: Colors.blueGrey),
                ),
              ),
              SizedBox(height: 12,),
          Obx(() =>
              Container(
                height: 60,
                width: 393,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton(items: todocontroller
                      .priority
                      .map(
                        (element) =>
                        DropdownMenuItem(
                            child: Text(element), value: element),
                  )
                      .toList(),
                    onChanged: (value) {
                      todocontroller.selectpr.value = value!;
                    },
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 250),
                      child: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Colors.black,
                      ),
                    ),
                    value: todocontroller.selectpr.value,
                  ),
                ),
              ),
          ),
              SizedBox(
                height: 12,
              ),
              TextField(
                controller: txttime,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          showTimePicker(
                              context: context,
                              initialTime: TimeOfDay(
                                  hour: DateTime.now().hour,
                                  minute: DateTime.now().minute));
                        },
                        icon: Icon(Icons.access_time_rounded)),
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(),
                    fillColor: Colors.blueGrey),
              ),
              SizedBox(
                height: 12,
              ),
              // TextField(
              //   controller: txtdate,
              //   decoration: InputDecoration(
              //     focusedBorder: OutlineInputBorder(),
              //     enabledBorder: OutlineInputBorder(),
              //     hintText: 'Enter Date',
              //     label: Text("Date"),
              //     labelStyle: TextStyle(color: Colors.blueGrey),
              //   ),
              // ),
              Container(
                height: 60,
                width: 393,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(
                        () => Text(
                          "${todocontroller.current.value.day}/${todocontroller.current.value.month}/${todocontroller.current.value.year}",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          todocontroller.current.value = (await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2030),
                            builder: (context, child) => Theme(
                                data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                        primary: Colors.black54,
                                        onPrimary: Colors.white,
                                        onSurface: Colors.black),
                                    textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                            primary: Colors.black))),
                                child: child!),
                          ))!;
                        },
                        icon: Icon(Icons.calendar_month))
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  var a = todocontroller.selectpr.value;
                  Dbhelper dbhelper = Dbhelper();
                  dbhelper.insertdata(
                      title: txttitle.text,
                      date: txtdate.text,
                      time: txttime.text,
                      desc: txtdesc.text,
                    priority: a,
                  );
                  Get.back();
                },
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade100,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 2, color: Colors.blueGrey),
                  ),
                  child: Center(
                      child: Text(
                    "ADD",
                    style: TextStyle(fontSize: 15),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
