import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpConcept extends StatefulWidget {
  const SpConcept({super.key});

  @override
  State<SpConcept> createState() => _SpConceptState();
}

class _SpConceptState extends State<SpConcept> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                //add();
                //print(add(2, 6));
                //printMsg();
                SharedPreferences sp = await SharedPreferences.getInstance(); //Initializing shared preferences and get instances of shared preferences.
                sp.setString('name', 'Humna');
                sp.setInt('age', 23);
                sp.setBool('isLogin', false);

                print(sp.getString('name'));
                print(sp.getInt('age'));
                print(sp.getBool('isLogin'));

                sp.remove('name');
                print(sp.getString('name'));

              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.indigo,
                  borderRadius: BorderRadius.circular(5)
                ),
                height: 50,
                width: double.infinity,
                child: const Center(
                  child: Text('Click'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

//Void Function
// void add (){
//   int x = 20, y = 20;
//   print(x+y);
// }

//Function with return type
// int add(int a, int b){
//   return a+b;
// }

//Future Function
// Future<void> printMsg() async {
//   await Future.delayed(Duration(seconds: 3));
//
//   print('delayed');
// }
}
