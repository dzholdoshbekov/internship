
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';


class UpdateScreen extends StatefulWidget {
  final CollectionReference teacherCollect;
  final String? selectedId;
  final Document? data;
  
  const UpdateScreen({super.key, required this.teacherCollect, this.selectedId, this.data});

  
  
  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {

  final lastNameTextController = TextEditingController();
  final firstNameTextController = TextEditingController();
  final middleNameTextController = TextEditingController();
  final subjectTextController = TextEditingController();
  final ageTextController = TextEditingController();
  final genderTextController = TextEditingController();
  final locationTextContoller = TextEditingController();


   updateTeacher(String lastName, String firstName, String middleName, String subject, String age, String gender, String location) async {
    await widget.teacherCollect.document(widget.selectedId!).update({
      'lastName': lastName,
        'firstName': firstName,
        'middleName': middleName,
        'subject': subject,
        'age': age,
        'gender': gender,
        'location': location
    });
  }

  addTeacher(String lastName, String firstName, String middleName, String subject, String age, String gender, String location) async {
    await widget.teacherCollect.add(
      {
        'lastName': lastName,
        'firstName': firstName,
        'middleName': middleName,
        'subject': subject,
        'age': age,
        'gender': gender,
        'location': location
      }
    );
  }

  @override
  void initState() {
    if(widget.data != null){
      lastNameTextController.text = widget.data!['lastName'];
      firstNameTextController.text = widget.data!['firstName'];
      middleNameTextController.text = widget.data!['middleName'];
      subjectTextController.text = widget.data!['subject'];
      ageTextController.text = widget.data!['age'];
      locationTextContoller.text = widget.data!['location'];
      genderTextController.text = widget.data!['gender'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Center(
          child: SizedBox(
            width: 700,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    
                    const SizedBox(height: 3),
                    TextField(
                      controller: lastNameTextController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Фамилия',
                        
                      ),
                    ),
                    
                    const SizedBox(height: 3),
                    TextField(
                      controller: firstNameTextController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Имя',
                        
                      ),
                    ),
                    
                    const SizedBox(height: 3),
                    TextField(
                      controller: middleNameTextController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Отчество',
                        
                      ),
                    ),
                    
                    const SizedBox(height: 3),
                    TextField(
                      controller: subjectTextController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Предмет',
                        
                      ),
                    ),
                  
                    const SizedBox(height: 3),
                    TextField(
                      controller: ageTextController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Возраст',
                        
                      ),
                    ),
                    
                    const SizedBox(height: 3),
                    TextField(
                      controller: genderTextController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Пол',
                        
                      ),
                    ),
                    
                    const SizedBox(height: 3),
                    TextField(
                      controller: locationTextContoller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Локация',
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
                      children: [
                        ElevatedButton(onPressed: (){Navigator.of(context).pushNamed('/');}, child: const Text("Назад")),
                        Row(
                          children: [
                            widget.data != null
                            ? ElevatedButton(onPressed: () async {
                               
                              await widget.teacherCollect.document(widget.selectedId!).delete();
                              Navigator.of(context).pushNamed('/');
  
                            }, child: const Text("Удалить запись"),)
                            : const SizedBox(),
                            const SizedBox(width: 3,),
                            ElevatedButton(onPressed: () async {
                              
                              if(widget.data != null){
                                updateTeacher(lastNameTextController.text,
                              firstNameTextController.text,
                              middleNameTextController.text,
                              subjectTextController.text,
                              ageTextController.text,
                              genderTextController.text,
                              locationTextContoller.text);
                              } else {
                                addTeacher(lastNameTextController.text,
                              firstNameTextController.text,
                              middleNameTextController.text,
                              subjectTextController.text,
                              ageTextController.text,
                              genderTextController.text,
                              locationTextContoller.text);
                              }
                              
                              Navigator.of(context).pushNamed('/');
                              
                            }, child: Text(widget.data != null
                            ? 'Изменить'
                            : 'Добавить')),
                            
                          ],
                        ),
                        
                      ],
                    )
                    ],
                    
                  )
                  
                  
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     const Text("firstName"),
                  //     TextBox(
                  //       controller: firstNameTextController,
                  //       placeholder: 'lastName',
                  //     )
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     const Text("middleName"),
                  //     TextBox(
                  //       controller: middleNameTextController,
                  //       placeholder: 'middleName',
                  //     )
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     const Text("sudject"),
                  //     TextBox(
                  //       controller: subjectTextController,
                  //       placeholder: 'subject',
                  //     )
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     const Text("age"),
                  //     TextBox(
                  //       controller: ageTextController,
                  //       placeholder: 'age',
                  //     )
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     const Text("gender"),
                  //     TextBox(
                  //       controller: genderTextController,
                  //       placeholder: 'gender',
                  //     )
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     const Text("location"),
                  //     TextBox(
                  //       controller: locationTextContoller,
                  //       placeholder: 'location',
                  //     )
                  //   ],
                  // ),
                ,
              ),
          ),
        ),
        ),
      );
  }
}