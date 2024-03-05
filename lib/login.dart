
import 'package:example/homepage.dart';
import 'package:example/model/usermodel.dart';
import 'package:example/registrartion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'databse/database.dart';
void main()async{
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.openBox<User>('user');
  runApp(GetMaterialApp(home: login(),));
}
class login extends StatelessWidget {
  TextEditingController uname = TextEditingController();
  TextEditingController pass = TextEditingController();

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
              controller:uname),
          TextField(
            decoration: InputDecoration(hintText: 'Password',
                prefixIcon: Icon(Icons.password),
                suffixIcon: Icon(Icons.visibility_off),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
              controller: pass,
          ),
          MaterialButton(onPressed: () async {
            final userList = await DBFuction.instance.getUser();
            findUser(userList);
          },
            color: Colors.pink,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text('LOGIN'),),
          TextButton(
              onPressed: () {
                Get.offAll(()=>registration());
              }, child: Text('Not a User? Register Here!!!'))
        ],
      ),
    );
  }

  Future<void> findUser(List<User> userlist) async {
    final email = uname.text.trim();
    final password = pass.text.trim();
    bool UserFound = false;
    final validate = await validateLogin(email, password);
    if (validate ==true){
      await Future.forEach(userlist, (user) {
        if (user.email==email&&user.password==password){
          UserFound=true;

        }else{
          UserFound=false;
        }
      });
      if(UserFound==true){
        Get.offAll(()=>Homee(email:email));
        Get.snackbar('Sucsses', 'Login Sucsses',backgroundColor: Colors.green);

      }else{
        Get.snackbar('Error', 'Incorret password/email');
      }
    }

}

 Future<bool>validateLogin(String email, String password) async {
   if (email != '' && password != '') {
     return true;
   } else {
     Get.snackbar(
         'error', 'Field is can\'t be empty', backgroundColor: Colors.green);
     return false;
   }
 }
  }

