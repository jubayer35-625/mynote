
import 'package:flutter/material.dart';

import 'app_const.dart';
import 'fecture/domain/entities/note_entity.dart';
import 'fecture/presentation/pages/add_new_note_page.dart';
import 'fecture/presentation/pages/sign_in_page.dart';
import 'fecture/presentation/pages/sign_up_page.dart';
import 'fecture/presentation/pages/update_note_page.dart';

class OnGenerateRoute{
  static Route<dynamic> route(RouteSettings settings){
    final args=settings.arguments;


    switch(settings.name){
      case PageConst.signInPage:{
        return materialBuilder(widget: const SignInPage());

      }
      case PageConst.signUpPage:{
        return materialBuilder(widget: const SignUpPage());

      }
      case PageConst.addNotePage:{
        if (args is String) {
          return materialBuilder(widget: AddNewNotePage(uid: args,));
        }
        else {
          return materialBuilder(
            widget: const ErrorPage(),
          );
        }

      }
      case PageConst.UpdateNotePage:{
        if (args is NoteEntity) {
          return materialBuilder(widget: UpdateNotePage(noteEntity: args,));
        }
        else {
          return materialBuilder(
            widget: const ErrorPage(),
          );
        }

      }
      default: return materialBuilder(widget: const ErrorPage());
    }

  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("error"),
      ),
      body: const Center(
        child: Text("error"),
      ),
    );
  }
}

MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}