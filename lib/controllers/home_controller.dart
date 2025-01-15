import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:seventeeth_assignment/models/note_model.dart';

class HomeController extends GetxController {
  // List<NoteModel> notes = [];

  final Box box = Hive.box('notes');

  addNote(NoteModel note) {
    box.add(note);
    update();
  }

  deleteNote(int index) {
    // notes.removeAt(index);
    box.deleteAt(index);
    update();
  }

  updateNote(NoteModel note, int index) {
    // notes[index] = note;
    box.putAt(index, note);
    update();
  }
}
