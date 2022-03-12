

import 'package:mynote/fecture/domain/entities/user_entity.dart';
import 'package:mynote/fecture/domain/repositories/firebase_repository.dart';

class GetCreateCurrentUserUsecase {

  final FirebaseRepository repository;

  GetCreateCurrentUserUsecase({required this.repository});

  Future<void> call(UserEntity user)async{
    return repository.getCreateCurrentUser(user);
  }
}