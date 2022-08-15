import 'package:flutter/material.dart';
import 'package:man/module/login/login.dart';
import 'package:man/shared/local/conest.dart';
import 'package:man/shared/local/shared_prefernces.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(32),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/food.png'
                ),
                fit:BoxFit.cover,
              )
            ),
            // child:
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black54,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Spacer(),
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:  Image(
                      height: height*.30,
                      width: width*.85,
                      image: AssetImage(
                        'assets/images/00.png',
                      ),
                    ),
                  ),
                  const Text(
                    'ذبيحتك وليمتك',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: Colors.white
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'تطبيق ذبيحتك وليمتك هو أفضل التطبيقات تاذي يقوم في تقديم أفضل الوجبات الشعبية والولائم والذبائح يمكنك طلبها الان وتصلك للمنطقة التي تريد أو يمكنك المجيء للمزرعة وإختيار الذبيحة التي تريدها',
                    style: TextStyle(
                      color:Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding:  const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: (){
                          CacheHelper.setBool(key: 'isFirst', value: false);
                          isFirst=false;
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                        },
                        child: const Text(
                          'الصفحة الرئيسية',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    height: 8,
                    width: 8,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
