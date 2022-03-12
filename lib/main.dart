
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'fecture/presentation/cubit/auth/auth_dart_cubit.dart';
import 'fecture/presentation/cubit/note/note_dart_cubit.dart';
import 'fecture/presentation/cubit/user/user_dart_cubit.dart';
import 'fecture/presentation/pages/home_page.dart';
import 'fecture/presentation/pages/sign_in_page.dart';
import 'on_generate_route.dart';
import 'injection_container.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => di.sl<AuthCubit>()..appStarted()),
        BlocProvider<UserCubit>(create: (_) => di.sl<UserCubit>()),
        BlocProvider<NoteCubit>(create: (_) => di.sl<NoteCubit>()),
      ],
      child: MaterialApp(
        title: 'My Notes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
              primaryColor: Colors.cyanAccent
        ),

        initialRoute: '/',
        onGenerateRoute:OnGenerateRoute.route,
        routes: {
          "/": (context){
            return BlocBuilder<AuthCubit,AuthState>(builder:(context,authState){

              if (authState is Authenticated){
                return HomePage(uid: authState.uid,);
              }
              if (authState is UnAuthenticated){
                return const SignInPage();
              }

              return const Center(child: CircularProgressIndicator());
            });
          }
        },
      ),
    );
  }
}