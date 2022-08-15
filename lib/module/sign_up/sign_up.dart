import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:man/module/sign_up/cubit.dart';
import 'package:man/module/sign_up/states.dart';
import 'package:man/module/sms_screen/sms_screen.dart';
import 'package:man/shared/local/shared_components.dart';

// ignore: must_be_immutable
class SignUp extends StatelessWidget {

  SignUp({Key? key}) : super(key: key);

  FocusNode myFocusNode=FocusNode();
  var nameController=TextEditingController();
  var mobileController=TextEditingController();
  var nameUserController=TextEditingController();

  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return BlocConsumer<SignUpCubit,SignUpStates>(
      listener: (context,state){},
      builder: (context,state){
        return Form(
          key: formKey,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration (
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60),bottomRight: Radius.circular(60)),
                        ),
                        child: Image(
                          height: height *.45,
                          width: width,
                          fit: BoxFit.fill,
                          image: const AssetImage(
                            'assets/images/min_food.png',
                          ),
                        ),
                      ),
                      Container(
                        height: height*.45,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60),bottomRight: Radius.circular(60)),
                        ),
                      ),
                      Container(
                        height: height*.45,
                        width: width,
                        child: Padding(
                          padding: const EdgeInsets.all(100.0),
                          child: Image(
                            image: AssetImage(
                              'assets/images/00.png',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'ذبيحتك وليمتك',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height*.06,),
                  SizedBox(
                    width: width*.80,
                    height: height*.1,
                    child: textForm(
                      validator: (value){
                        if(value!.isEmpty){
                          return 'الحقل فارغ,الرجاء ادخال بيانات صحيحة';
                        }
                      },
                      label: 'الاسم بالكامل',
                      labelStyle: TextStyle(
                          color: myFocusNode.hasFocus? Colors.black:Colors.grey,
                          fontSize: 15
                      ),
                      prefixIcon: const Icon(
                        Icons.sort_by_alpha,
                        color: Colors.amber,
                      ),
                      controller: nameUserController,
                      type: TextInputType.text,
                      isNum: false,
                    ),
                  ),
                  SizedBox(height: 5,),
                  SizedBox(
                    width: width*.80,
                    height: height*.1,
                    child: textForm(
                      validator: (value){
                        if(value!.isEmpty){
                          return 'الحقل فارغ,الرجاء ادخال بيانات صحيحة';
                        }
                      },
                      focusNode: myFocusNode,
                      label: 'رقم الهاتف',
                      labelStyle: TextStyle(
                          color: myFocusNode.hasFocus? Colors.black:Colors.grey,
                          fontSize: 15
                      ),
                      suffixIcon: myFocusNode.hasFocus?const Text(
                        '+974',
                        style: TextStyle(color: Colors.black),
                      ):null,
                      prefixIcon: const Icon(
                        Icons.person_outline,
                        color: Colors.amber,
                      ),
                      controller: mobileController,
                      type: TextInputType.number,
                      isNum: true,
                    ),
                  ),
                  SizedBox(height: 5,),
                  SizedBox(
                    width: width*.80,
                    height: height*.1,
                    child: textForm(
                      validator: (value) {
                        if(value!.isEmpty) {
                          return 'الحقل فارغ,الرجاء ادخال بيانات صحيحة';
                        }
                      },
                      label: 'اسم المستخدم',
                      labelStyle: TextStyle(
                          color: myFocusNode.hasFocus? Colors.black:Colors.grey,
                          fontSize: 15
                      ),
                      prefixIcon: const Icon(
                        Icons.sort_by_alpha,
                        color: Colors.amber,
                      ),
                      controller: nameController,
                      type: TextInputType.text,
                      isNum: false,
                    ),
                  ),

                  state is LoadingGetSmsCodeState?const CircularProgressIndicator(color: Colors.amber,):
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        height: 65,
                        width: width*.80,
                        child: textButton(text: 'ارسال رمز التفعيل', textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        onTap: ()async{
                          if(formKey.currentState!.validate()) {
                            log(mobileController.text);
                            await SignUpCubit.get(context).getSms(phone: mobileController.text).then((value) {
                            Navigator.push((context),MaterialPageRoute(builder: (context)=>SmsScreen(name: nameController.text,fullName: nameUserController.text,password: mobileController.text, mobile: mobileController.text,)));
                          });
                          }
                        },
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}