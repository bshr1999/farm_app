import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:man/module/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:man/module/login/login.dart';
import 'package:man/module/login/login_cubit.dart';
import 'package:man/module/login/login_states.dart';
import 'package:man/module/sign_up/cubit.dart';
import 'package:man/module/sign_up/states.dart';
import 'package:man/shared/local/conest.dart';
import 'package:man/shared/local/shared_prefernces.dart';

class SmsScreen extends StatelessWidget {

  String name;
  String mobile;
  String password;
  String fullName;
  SmsScreen({required this.mobile,required this.name,required this.password,required this.fullName,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return BlocConsumer<LoginCubit,LoginStates>(
      listener: (context,state){},
      builder: (context,state){
        return BlocConsumer<SignUpCubit,SignUpStates>(
          listener: (context,state){},
          builder: (context, state){
            log(SignUpCubit.get(context).smsModel!=null?SignUpCubit.get(context).smsModel!.message.toString():'sss');
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60),bottomRight: Radius.circular(60)),
                          ),
                          child: Image(
                            height: height *.45,
                            width: width,
                            fit: BoxFit.fill,
                            image: const AssetImage(
                              'assets/images/appIcon.png',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'ذبيحتك وليمتك',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text(
                          'يرجى ارسال رقم التفعيل',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(width: 20,),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                              '+974 - $password'
                          ),
                        ),
                      ],
                    ),
                    const Text(
                        'تم ارسال رمز التفعيل الى رقم الهاتف'
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: VerificationCode(
                          textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.amber),
                          keyboardType: TextInputType.number,
                          length: 6,
                          cursorColor: Colors.amber,
                          clearAll: const Text(
                            'مسح الكل',
                            style: TextStyle(
                              fontSize: 14.0,
                              decoration: TextDecoration.underline,
                              color: Colors.orange,
                            ),
                          ),
                          onCompleted: (String value){
                            // ignore: unrelated_type_equality_checks
                            if(int.parse(value)==SignUpCubit.get(context).smsModel?.message){
                              log('hello');
                              SignUpCubit.get(context).signUp(name: name,fullName: fullName,phoneNo: password).then((value) {
                                LoginCubit.get(context).login(name: name, phone: int.parse(password)).then((value) {
                                  CacheHelper.setStringData(
                                      key: 'user_id',
                                      value: (LoginCubit.get(context)
                                          .loginModel!
                                          .data![0]
                                          .id)
                                          .toString());
                                  CacheHelper.setStringData(key: 'phone', value: password);
                                  clint_id = LoginCubit.get(context)
                                      .loginModel!
                                      .data![0]
                                      .id;
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));
                                });
                              });
                            }else{
                              log('he');
                              toast(text: 'الرمز المدخل خاطئ', state: ToastState.ERROR);
                            }
                          },
                          onEditing: (bool value){}
                      ),
                    ),
                    // ignore: prefer_const_constructors
                    SizedBox(height: 40,),
                    state is LoadingSignUpState?
                    const CircularProgressIndicator(color: Colors.amber,):
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: (){
                            toast(text: 'الرمز المدخل خاطئ', state: ToastState.ERROR);
                          },
                          child: const Text(
                            'إنشاء حساب',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'لم يصلك الرمز؟',
                        ),
                        state is LoadingGetSmsCodeState?const Center(child: CircularProgressIndicator(color: Colors.amber,)):
                        InkWell(
                          onTap: (){
                            SignUpCubit.get(context).getSms(phone: mobile).then((value) {
                              toast(text: 'تمت اعادة الارسال بنجاح', state: ToastState.SUCCESS);
                            });
                          },
                          child: const Text(
                            'إعادة الإرسال',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}