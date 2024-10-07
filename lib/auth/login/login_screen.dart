import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/auth/login/login_screen.dart';
import 'package:todo/auth/register/register_screen.dart';
import 'package:todo/components/custom_text_form_field.dart';
import 'package:todo/home/HomeScreen.dart';
import '../../MyTheme.dart';
import '../../dialog_utils.dart';
import '../../firebase_utils.dart';
import '../../home/provider/app_config_provider.dart';
import 'package:todo/home/provider/auth_provider.dart';
class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    style:ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(MyTheme.primaryLight)
                    ),
                      onPressed: (){
                        login();
                      },
                      child:Text('Login',style: TextStyle(color: MyTheme.white),) ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                    Text("Don't have an account?"),
                    TextButton(onPressed: (){
                      Navigator.of(context).pushNamed(RegisterScreen.routeName);
                    },
                        child:Text('SignUp',style: TextStyle(color: MyTheme.primaryLight),))
                  ],
                )
              ],
            ),
          )),
    );
  }

  void login() async {
    if(formKey.currentState?.validate()==true){
      DialogUtils.showLoading(context, 'Loading...');
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
       var user=await FirebaseUtils.readUserFormFireStore(credential.user?.uid??'');
       if(user==null){
         return;
       }
        var authProvider=Provider.of<Authprovider>(context,listen: false);
       authProvider.updateUser(user);
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context, 'Login Successfully',posActionName:'OK',barrierDismissible: false,
        posAction: (){
          Navigator.pushReplacementNamed(context,Homescreen.routeName);
        });
        print('Login Successfully');
        print(credential.user?.uid??'');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context, 'No user found for that email.',posActionName:'OK',barrierDismissible: false,title: 'Error' );
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context, 'Wrong password provided for that user.',posActionName:'OK',barrierDismissible: false,title: 'Error' );
          print('Wrong password provided for that user.');
        }
      }
      catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context, e.toString(),posActionName:'OK',barrierDismissible: false,title: 'Error' );
        print(e);
      }
    }
  }
}
