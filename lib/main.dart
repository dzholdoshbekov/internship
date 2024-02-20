import 'package:fluent_ui/fluent_ui.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart' as material;
import 'package:internship/update_screen.dart';


const apiKey = 'AIzaSyDOMoHDLxW5UwnpUOnklDSRcFfFA7JZJJw';
const projectId = 'internship-4ba64';

void main() {
  Firestore.initialize(projectId);
  runApp(const InternshipApp());
  }

class InternshipApp extends StatelessWidget {
  const InternshipApp({super.key});



  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Internship App',
      initialRoute: '/',
      routes: 
      {
        '/': (context) => const InternshipHome(),
      },
    );
  }
}

class InternshipHome extends StatefulWidget {
  const InternshipHome({super.key});

  @override
  State<InternshipHome> createState() => _InternshipHomeState();
}

class _InternshipHomeState extends State<InternshipHome> {
  CollectionReference teachersCollect = 
    Firestore.instance.collection('teachers');
  final textController = TextEditingController();
  String? selectedId;


  Future<List<Document>> getTeachers() async{
    List<Document> teachers = await teachersCollect.orderBy('lastName').get();
    return teachers;
  } 

  

 

 
  @override
  Widget build(BuildContext context) {
    return material.Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // TextBox(
                  //   controller: textController,
                  //   placeholder: 'Add a techer',
                  // ),
                  // Row(
                  //   children: [
                  //     Button(child:
                  //     const Text('Add'),
                  //     onPressed: () async {
                  //       Navigator.push(context, 
                  //       material.MaterialPageRoute(builder: (context) => UpdateScreen(teacherCollect: teachersCollect),)
                        
                  //       );
                  //     }),
                  //     Button(child: const Text("Update"),
                  //      onPressed: () async {
                  //       Navigator.of(context).pushNamed('/updateScreen');
                  //       // await updateTeacher(
                  //       //   textController.text
                  //       // );
                  //       // setState(() {
                  //       //   textController.clear();
                  //       // });
                  //      }),
                  //      Button(child: const Text("Delete"),
                  //       onPressed: (){
                  //         deleteTeacher();
                  //         setState(() {
                  //           textController.clear();
                  //         });
                  //       })
                  //   ],
                  // ),
                  FutureBuilder<List<Document>>(
                    future: getTeachers(),
                    builder: (BuildContext context,
                      AsyncSnapshot<List<Document>> snapshot){
                        if(!snapshot.hasData){
                          return const Center(child: Text('Loading...'),);
                        }
                        return snapshot.data!.isEmpty
                          ? const Center(child: Text('There is no teachers'))
                          : SingleChildScrollView(
                            child: material.DataTable(columns:const [
                              material.DataColumn(label: Text("№"), tooltip: 'represents etc'),
                              material.DataColumn(label: Text("Last Name"), tooltip: 'represents etc'),
                              material.DataColumn(label: Text("First Name"), tooltip: 'represents etc'),
                              material.DataColumn(label: Text("Middle Name"), tooltip: 'represents etc'),
                              material.DataColumn(label: Text("Subject"), tooltip: 'represents etc'),
                              material.DataColumn(label: Text("Age"), tooltip: 'represents etc'),
                              material.DataColumn(label: Text("Gender"), tooltip: 'represents etc'),
                              material.DataColumn(label: Text("Location"), tooltip: 'represents etc'),
              
                              ],
                              rows: List.generate(snapshot.data!.length, (index) {
                                final data = snapshot.data![index];
                                index = index + 1;
              
                                return material.DataRow(cells: [
                                  material.DataCell(Text('$index')),
                                  material.DataCell(Text(data['lastName'])),
                                  material.DataCell(Text(data['firstName'])),
                                  material.DataCell(Text(data['middleName'])),
                                  material.DataCell(Text(data['subject'])),
                                  material.DataCell(Text(data['age'])),
                                  material.DataCell(Text(data['gender'])),
                                  material.DataCell(Text(data['location']))
                                ],
                                onLongPress: () async {
                                  setState(() {
                                    selectedId = data.id;
                                  });
                                  Navigator.push(context, 
                        material.MaterialPageRoute(builder: (context) => UpdateScreen(teacherCollect: teachersCollect, selectedId: selectedId, data: data,),)
                        
                        );
                                },);
                              }),
                            //   rows: snapshot.data!.map((data) => 
                            //   material.DataRow(cells: [
                            //     material.DataCell(Text()),
                            //     material.DataCell(Text(data['lastName'])),
                            //     material.DataCell(Text(data['firstName'])),
                            //     material.DataCell(Text(data['middleName'])),
                            //     material.DataCell(Text(data['subject'])),
                            //     material.DataCell(Text(data['age'])),
                            //     material.DataCell(Text(data['gender'])),
                            //     material.DataCell(Text(data['location']))
                            //   ]
                            //   )
                            //    ).toList()
                            // ,),
                          ));
              
                          // : Row(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Expanded(
                          //       child: SizedBox(
                          //         height: 200,
                          //         child: ListView(
                          //           scrollDirection: Axis.vertical,
                          //           shrinkWrap: true,
                          //           children: snapshot.data!.map((teacher) {
                          //             return ListTile(
                          //               title: Text(teacher['lastName']),
                          //               onPressed: () {
                          //                 selectedId = teacher.id;
                          //                 textController.text = teacher['lastName'];
                          //               }
                                  
                          //             );
                          //           }).toList(),
                          //         ),
                          //       ),
                          //     ),
                          //     Expanded(
                          //       child: SizedBox(
                          //         height: 200,
                          //         child: ListView(
                          //           scrollDirection: Axis.vertical,
                          //           shrinkWrap: true,
                          //           children: snapshot.data!.map((teacher) {
                          //             return ListTile(
                          //               title: Text(teacher['firstName']),
                          //               onPressed: () {
                          //                 selectedId = teacher.id;
                          //                 textController.text = teacher['firstName'];
                          //               }
                                  
                          //             );
                          //           }).toList(),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // );
                      }),
                ],
              ),
              SizedBox(
                height: 700,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    material.ElevatedButton(child:
                        const Text('Добавить преподавателя'),
                        onPressed: () async {
                          Navigator.push(context, 
                          material.MaterialPageRoute(builder: (context) => UpdateScreen(teacherCollect: teachersCollect),)
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Фильтры'),
                   
                  ]
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}