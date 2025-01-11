import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:seventeeth_assignment/models/note_model.dart';
import 'package:seventeeth_assignment/ui/note_details_screen.dart';
import 'package:seventeeth_assignment/utils/all_styles.dart';
import '../controllers/home_controller.dart';
import '../utils/all_colors.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  HomeController homeController = Get.put(HomeController());
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AllColors.brownColor,
        title: Text(
          "NotePad with Getx",
          style: AllStyles.titleStyle.copyWith(color: AllColors.whitColor),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<HomeController>(builder: (_) {
        return homeController.notes.isEmpty
            ? Center(child: Text("Empty Note!!"))
            : ListView.builder(
                itemCount: homeController.notes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(homeController.notes[index].title),
                    subtitle: Text(homeController.notes[index].description),
                    trailing: SizedBox(
                      width: 60.0,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: (){
                              _showUpdateAlert(context,index);
                            },
                            child: Icon(
                              Icons.edit,
                              color: AllColors.blckColor.withOpacity(0.7),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () => homeController.deleteNote(index),
                            child: Icon(
                              Icons.delete,
                              color: AllColors.redColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: (){
                      Get.to(NoteDetailsScreen(), arguments: {
                        "title": homeController.notes[index].title,
                        "description":homeController.notes[index].description,
                        "date":homeController.notes[index].date
                      });
                    }
                  );
                });
      }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AllColors.brownColor,
          child: const Icon(
            Icons.add,
            color: AllColors.whitColor,
          ),
          onPressed: () {
            _showAlert(context);
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return Center(
            child: SingleChildScrollView(
              child: AlertDialog(
                content: Column(
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'Title',
                      ),
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Description',
                      ),
                    )
                  ],
                ),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: AllColors.redColor),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: AllColors.whitColor,
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: AllColors.brownColor),
                    onPressed: () {
                      if (titleController.text.isEmpty &&
                          descriptionController.text.isEmpty) {
                        print('Please fill up the form');
                      } else {
                        DateTime now= DateTime.now();
                        String formattedDate = DateFormat('dd-MM-yyyy').format(now);
                        homeController.addNote(
                          NoteModel(
                            titleController.text,
                            descriptionController.text,
                            formattedDate,
                          ),
                        );
                      }
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: AllColors.whitColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
  _showUpdateAlert(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (_) {
          return Center(
            child: SingleChildScrollView(
              child: AlertDialog(
                content: Column(
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'Title',
                      ),
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Description',
                      ),
                    )
                  ],
                ),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: AllColors.redColor),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: AllColors.whitColor,
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: AllColors.brownColor),
                    onPressed: () {
                      if (titleController.text.isEmpty &&
                          descriptionController.text.isEmpty) {
                        print('Please fill up the form');
                      } else {
                        DateTime now= DateTime.now();
                        String formattedDate = DateFormat('dd-MM-yyyy').format(now);
                        homeController.updateNote(
                          NoteModel(
                            titleController.text,
                            descriptionController.text,
                            formattedDate,
                          ),index
                        );
                      }
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(
                        color: AllColors.whitColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
