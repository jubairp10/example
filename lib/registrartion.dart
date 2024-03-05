import 'package:email_validator/email_validator.dart';
import 'package:example/databse/database.dart';
import 'package:example/login.dart';


import 'package:example/model/usermodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class registration extends StatelessWidget {
  TextEditingController password= TextEditingController();
  TextEditingController cpassword = TextEditingController();
  TextEditingController username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('login'),),
      body: ListView(
        children: [
          Text('Login'),
          TextField(
            decoration: InputDecoration(hintText: 'Login',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
           ),
          TextField(
            decoration: InputDecoration(hintText: 'Password',
                prefixIcon: Icon(Icons.password),
                suffixIcon: Icon(Icons.visibility_off),

                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
            controller: password,
            obscuringCharacter: '#',
            obscureText: true,

          ),
          TextField(
            decoration: InputDecoration(hintText: 'Confirm Password',
                prefixIcon: Icon(Icons.password),
                suffixIcon: Icon(Icons.visibility_off),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
            controller: cpassword,
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))
            ), controller: username,
          ),
          MaterialButton(onPressed: () {
            Get.offAll(()=>login());
          },
            color: Colors.pink,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text('Register'),),
          TextButton(onPressed: () {
            validateSignup();
          }, child: Text('are you user?login!!!'))
        ],
      ),
    );
  }

  void validateSignup() async{
    final email = username.text.trim();
    final pass=password.text.trim();
    final cpass=cpassword.text.trim();
    final emailvalidatorresult=EmailValidator.validate(email);
    if(email!=''&&password!=''&&cpassword!='') {
      if(emailvalidatorresult==true) {
        final passValidationResult = checkPassword(pass, cpass);
        if (passValidationResult == true) {
          final user = User(email: email, password: pass);
          await DBFuction.instance.userSignup(user);
          Get.back();
          Get.snackbar('success','account createed');
        }
      }else{
        Get.snackbar('Error','Provide a valid E-mail');
      }
    }else{
      Get.snackbar('Error','field is canot be empty');
    }
  }

  bool checkPassword(String password, String cpassword) {
    if (password==cpassword){
      if(password.length<6) {
        Get.snackbar('error','password length should be >6');
        return false;
      } else{
        return true;
      }

    }else{
      Get.snackbar('error','password mismatch');
      return false;
    }
}
}