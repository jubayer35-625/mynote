import 'package:mynote/fecture/domain/entities/note_entity.dart';
import 'package:mynote/fecture/domain/repositories/firebase_repository.dart';

class GetNotesUseCase {

  final FirebaseRepository repository;

  GetNotesUseCase({required this.repository});

  Stream<List<NoteEntity>> call(String uid){
    return repository.getNotes(uid);
  }
}