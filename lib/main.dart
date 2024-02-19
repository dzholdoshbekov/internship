import 'package:fluent_ui/fluent_ui.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';



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
    return const FluentApp(
      title: 'Internship App',
      home: InternshipHome(),

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

  Future<List<Document>> getTeachers() async{
    try {
    List<Document> teachers = await teachersCollect.orderBy('lastName').get();
    return teachers;
  } catch (e) {
    return []; // Возвращаем пустой список в случае ошибки
  }  
  } 

  addTeacher(String teachersLastName) async {
    await teachersCollect.add(
      {
        'lastName': teachersLastName,
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0000ff),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder<List<Document>>(
              future: getTeachers(),
              builder: (BuildContext context,
                AsyncSnapshot<List<Document>> snapshot){
                  return snapshot.data!.isNotEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : const Text('Teachers there!');
                }),
          ],
        ),
      ),
    );
  }
}