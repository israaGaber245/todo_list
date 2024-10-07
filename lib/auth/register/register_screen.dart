import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/auth/login/login_screen.dart';
import 'package:todo/components/custom_text_form_field.dart';
import 'package:todo/dialog_utils.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/home/provider/auth_provider.dart';
import 'package:todo/model/my_user.dart';

import '../../MyTheme.dart';
import '../../home/HomeScreen.dart';
import '../../home/provider/app_config_provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmPasswordController = TextEditingController();

  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Creat Account',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color:
                  provider.isDarkMode() ? MyTheme.primaryDark : MyTheme.white),
        ),
        centerTitle: true,
      ),
      body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                CustomTextFormField(
                  label: 'User Name',
                  controller: nameController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'please enter userName';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                    label: 'Email Address',
                    keyBoardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter Email Address';
                      }
                      bool emailValid=RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(text);
                      if(!emailValid){
                        return 'please enter valid email';
                      }
                      return null;
                    }),
                CustomTextFormField(
                    label: 'Password',
                    keyBoardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter password';
                      }
                      if(text.length <6){
                        return 'password should be getter than six character';
                      }
                      return null;
                    },
                  isPassword: true,
                ),
                CustomTextFormField(
                    label: 'Confirm Password',
                    keyBoardType: TextInputType.visiblePassword,
                    controller: confirmPasswordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter confirm password';
                      }
                      if(text!=passwordController.text){
                        return "password doesn't match";
                      }
                      return null;
                    },
                  isPassword: true,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    style:ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(MyTheme.primaryLight)
                    ),
                      onPressed: (){
                        register();
                      },
                      child:Text('Register',style: TextStyle(color: MyTheme.white),) ),
                ),
                TextButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed(LoginScreen.routeName);
                    },
                    child: Text('Already have an account',style:TextStyle(color: MyTheme.primaryLight),))
              ],
            ),
          )),
    );
  }

  void register() async{
    if(formKey.currentState?.validate()==true){
      DialogUtils.showLoading(context, 'Loading...');
      try{
        var credential=await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser myuser=MyUser(id: credential.user?.uid??'', name:nameController.text, email: emailController.text);
        var authProvider=Provider.of<Authprovider>(context,listen: false);
        authProvider.updateUser(myuser);
        await FirebaseUtils.addUserToFireStore(myuser);
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context, 'Register Successfully',posActionName:'OK',barrierDismissible: false,
            posAction: (){
          Navigator.pushReplacementNamed(context,Homescreen.routeName);
        } );
        print('Register Successfully');
        print(credential.user?.uid??'');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context, 'The password provided is too weak.',posActionName:'OK',title: 'Error',barrierDismissible: false );
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context, 'The account already exists for that email.',posActionName:'OK',title: 'Error',barrierDismissible: false );
          print('The account already exists for that email.');
        }
      } catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context, e.toString(),posActionName:'OK',title: 'Error',barrierDismissible: false );
        print(e);
      }

    }
  }
}
