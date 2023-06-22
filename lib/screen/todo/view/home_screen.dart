import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/database_helper.dart';
import '../controller/todo_controller.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({Key? key}) : super(key: key);

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  Todocontroller todocontroller = Get.put(Todocontroller());
  TextEditingController txttitle = TextEditingController();
  TextEditingController txtdesc = TextEditingController();
  TextEditingController txttime = TextEditingController(
      text: "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}");
  TextEditingController txtdate = TextEditingController();
  TextEditingController txtpr = TextEditingController();

  @override
  void initState() {
    super.initState();
    todocontroller.readtodo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("TODO LIST"),
          centerTitle: true,
        ),
        body: Obx(
          () => ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 120,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade50,
                    border: Border.all(
                      width: 2,
                      color: Colors.blueGrey,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text("${todocontroller.TodoList[index]['title']}",style: TextStyle(fontSize: 20),),
                            SizedBox(
                              height: 5,
                            ),
                            Text("${todocontroller.TodoList[index]['desc']}",style: TextStyle(fontSize: 15),),
                            SizedBox(height: 15,),
                            Container(
                              height: 30,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.shade50,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(width: 2,color: Colors.blueGrey),
                              ),
                              child: Center(child: Text("${todocontroller.TodoList[index]['priority']}")),
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            IconButton(
                                onPressed: () {
                                  int id = todocontroller.TodoList[index]['id'];
                                  todocontroller.delettodo(id);
                                  todocontroller.readtodo();
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
                            SizedBox(
                              height: 4,
                            ),
                            IconButton(
                                onPressed: () {
                                  txttitle = TextEditingController(
                                      text:
                                          '${todocontroller.TodoList[index]['title']}');
                                  txtdesc = TextEditingController(
                                      text:
                                          '${todocontroller.TodoList[index]['desc']}');
                                  txtpr = TextEditingController(
                                      text:
                                          '${todocontroller.TodoList[index]['priority']}');
                                  txtdate = TextEditingController(
                                      text:
                                          '${todocontroller.TodoList[index]['date']}');
                                  txttime = TextEditingController(
                                      text:
                                          '${todocontroller.TodoList[index]['time']}');

                                  Get.defaultDialog(
                                    title: 'Update',
                                    content: Container(
                                      height: 300,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextField(
                                              controller: txttitle,
                                              decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(),
                                                  focusedBorder:
                                                      OutlineInputBorder(),
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                  label: Text("Title"),
                                                  fillColor: Colors.black),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            TextField(
                                              controller: txtdesc,
                                              decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(),
                                                  focusedBorder:
                                                      OutlineInputBorder(),
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                  label: Text("desc"),
                                                  fillColor: Colors.black),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            TextField(
                                              controller: txtpr,
                                              decoration: InputDecoration(
                                                  label: Text("priority"),
                                                  enabledBorder:
                                                      OutlineInputBorder(),
                                                  focusedBorder:
                                                      OutlineInputBorder(),
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                  fillColor: Colors.black),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            TextField(
                                              controller: txtdate,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  label: Text("Date"),
                                                  fillColor: Colors.black),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            TextField(
                                              controller: txttime,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  label: Text("Time"),
                                                  fillColor: Colors.black),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Dbhelper dbhelper = Dbhelper();
                                                dbhelper.updatedata(
                                                    title: txttitle.text,
                                                    desc: txtdesc.text,
                                                    time: txttime.text,
                                                    date: txtdate.text,
                                                    priority: txtpr.text,
                                                    id: todocontroller.TodoList[index]['id']);
                                                Get.back();
                                              },
                                              child: Container(
                                                height: 50,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  color: Colors.blueGrey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: Border.all(
                                                      width: 2,
                                                      color: Colors.blueGrey),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  "UPDATE",
                                                  style: TextStyle(fontSize: 12),
                                                )),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: todocontroller.TodoList.length,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed('/add')!.then((value) => todocontroller.readtodo(),);
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blueGrey,
        ),
      ),
    );
  }
}
