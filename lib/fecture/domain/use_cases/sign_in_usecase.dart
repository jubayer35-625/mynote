
import 'package:mynote/fecture/domain/entities/user_entity.dart';
import 'package:mynote/fecture/domain/repositories/firebase_repository.dart';

class SignInUseCase {

  final FirebaseRepository repository;

  SignInUseCase({required this.repository});

  Future<void> call(UserEntity user)async{
    return repository.signIn(user);
  }
}