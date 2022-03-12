
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynote/fecture/domain/entities/user_entity.dart';
import 'package:mynote/fecture/presentation/cubit/auth/auth_dart_cubit.dart';
import 'package:mynote/fecture/presentation/cubit/user/user_dart_cubit.dart';
import 'package:mynote/fecture/presentation/widgets/common.dart';

import '../../../app_const.dart';
import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {


  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();



  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKey,
        body: BlocConsumer<UserCubit,UserState>(
          builder: (context,userState){

            if (userState is UserSuccess){
              return BlocBuilder<AuthCubit,AuthState>(builder:(context,authState){

                if (authState is Authenticated){
                  return HomePage(uid: authState.uid,);
                }else{
                  return _bodyWidget();
                }
              });
            }

            return _bodyWidget();
          },
          listener: (context,userState){
            if (userState is UserSuccess){
              BlocProvider.of<AuthCubit>(context).loggedIn();
            }
            if (userState is UserFailure){
              snackBarError(msg: "invalid email",scaffoldState: _globalKey);
            }
          },
        )
    );
  }

  _bodyWidget() {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, PageConst.signInPage, (route) => false);
            },
            child: Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black.withOpacity(.6)),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back_ios),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                  hintText: 'Username', border: InputBorder.none),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                  hintText: 'Enter your email', border: InputBorder.none),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: const InputDecoration(
                  hintText: 'Enter your Password', border: InputBorder.none),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: (){
              submitSignIn();
            },
            child: Container(
              height: 45,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                color: Colors.deepOrange.withOpacity(.8),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: const Text(
                "Create New Account",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  void submitSignIn() {
    if (_usernameController.text.isNotEmpty &&_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      BlocProvider.of<UserCubit>(context).submitSignUp(user: UserEntity(
        email: _emailController.text,
        password: _passwordController.text,
      ));
    }
  }
}