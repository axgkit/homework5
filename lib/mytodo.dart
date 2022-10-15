import 'package:flutter/material.dart';

class todo extends StatefulWidget{

  @override
  State<todo> createState() => _todoState();
}

class _todoState extends State<todo> {
  @override
  var text = TextEditingController();
  var result = '';
  var List = <Map<String, dynamic>>[];

  void handleAdd(String text) {
    setState(() {
      List.add(
          {
            "text" : text,
            "status" : false
          }
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("MyToDo"),
          leading: Icon(Icons.check_box),
        ),

        body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for(int i = 0; i < List.length ; ++i)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)
                      ),
                      child: Container(
                        height: 60.0,
                        child: Row(
                          children: [
                            Checkbox(
                              value: List[i]['status'], // กำหนดสถานะปัจจุบันให้กับ Checkbox
                              onChanged: (bool? value) {
                                // onChanged จะทำงานเมื่อมีการเปลี่ยนสถานะของ Checkbox
                                // โดยสถานะใหม่จะถูกส่งมาที่พารามิเตอร์ value
                                setState(() {
                                  List[i]['status'] = value;
                                });
                              },
                            ),
                            (List[i]['status']
                                ? Text("${List[i]['text']}",style: TextStyle(decoration: TextDecoration.lineThrough))
                                :Text("${List[i]['text']}",style: TextStyle(decoration: TextDecoration.none))),
                            Expanded(child: SizedBox.shrink()),

                            IconButton(onPressed: () {
                              setState(() {
                                List.removeAt(i);
                              });
                            }, icon: Icon(Icons.delete))
                          ],
                        ),
                      ),
                    ),
                  ),

                const Expanded(child: SizedBox.shrink()),
                Card(
                  elevation: 3.0,
                  child: Container(
                    height: 80.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextField(
                              controller: text,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter new ToDo'
                              ),
                            ),
                          ),
                          TextButton(onPressed: (){
                            handleAdd(text.text);
                            text.clear();
                          }, child: Text("ADD"))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
        )
    );
  }
}