import 'package:get/get.dart';
import 'package:seventeeth_assignment/models/note_model.dart';

class HomeController extends GetxController {
  List<NoteModel> notes = [];

  addNote(NoteModel note) {
    notes.add(note);
    update();
  }

  deleteNote(int index) {
    notes.removeAt(index);
    update();
  }

  updateNote(NoteModel note, int index){
    notes[index]=note;
    update();

  }
}
