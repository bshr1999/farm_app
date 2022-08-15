import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:man/module/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:man/module/login/login_cubit.dart';
import 'package:man/module/login/login_states.dart';
import 'package:man/module/sign_up/sign_up.dart';
import 'package:man/shared/local/conest.dart';
import 'package:man/shared/local/shared_components.dart';
import 'package:man/shared/local/shared_prefernces.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  FocusNode myFocusNode = FocusNode();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(60),
                              bottomRight: Radius.circular(60)),
                        ),
                        child: Image(
                          height: height * .45,
                          width: width,
                          fit: BoxFit.fill,
                          image: const AssetImage(
                            'assets/images/min_food.png',
                          ),
                        ),
                      ),
                      Container(
                        height: height * .45,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(60),
                              bottomRight: Radius.circular(60)),
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
                                fontWeight: FontWeight.w900,
                                fontSize: 25,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: width * .80,
                    height: height * .1,
                    child: textForm(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'الرجاء إدخال رقم هاتف صالح';
                        }
                      },
                      focusNode: myFocusNode,
                      label: 'رقم الهاتف',
                      labelStyle: TextStyle(
                          color:
                              myFocusNode.hasFocus ? Colors.black : Colors.grey,
                          fontSize: 15),
                      suffixIcon: myFocusNode.hasFocus
                          ? const Text(
                              '+974',
                              style: TextStyle(color: Colors.black),
                            )
                          : null,
                      prefixIcon: const Icon(
                        Icons.person_outline,
                        color: Colors.amber,
                      ),
                      controller: mobileController,
                      type: TextInputType.number,
                      isNum: true,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: width * .80,
                    height: height * .1,
                    child: textForm(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'الرجاء إدخال اسم صالح';
                        }
                      },
                      label: 'اسم المستخدم',
                      labelStyle: TextStyle(
                          color:
                              myFocusNode.hasFocus ? Colors.black : Colors.grey,
                          fontSize: 15),
                      prefixIcon: const Icon(
                        Icons.sort_by_alpha,
                        color: Colors.amber,
                      ),
                      controller: nameController,
                      type: TextInputType.text,
                      isNum: false,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: width * .80,
                    child: Row(
                      children: [
                        const Text(
                          'اضغط هنا اذا لم تمتلك حساب ؟',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: const Text(
                            'انشاء حساب',
                            style: TextStyle(
                              color: Colors.amber,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  state is LoginLoadingState
                      ? CircularProgressIndicator()
                      : SizedBox(
                          height: 50,
                          width: width * .80,
                          child: textButton(
                            text: 'تسجيل الدخول',
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            onTap: () async {
                              log(nameController.text);
                              if (formKey.currentState!.validate()) {
                                await LoginCubit.get(context).login(
                                    name: nameController.text,
                                    phone: int.parse(mobileController.text));
                                if (LoginCubit.get(context)
                                            .loginModel!
                                            .statos ==
                                        200 &&
                                    LoginCubit.get(context).loginModel!.data !=
                                        null) {
                                  CacheHelper.setStringData(
                                      key: 'user_id',
                                      value: (LoginCubit.get(context)
                                              .loginModel!
                                              .data![0]
                                              .id)
                                          .toString());
                                  CacheHelper.setStringData(key: 'phone', value: mobileController.text);
                                  clint_id = LoginCubit.get(context)
                                      .loginModel!
                                      .data![0]
                                      .id;
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const BottomNavBar()));
                                }
                              }
                            },
                          )),
                  SizedBox(
                    height: height * .02,
                  ),
                  Container(
                    height: 50,
                    width: width * .80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.amber),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BottomNavBar()));
                      },
                      child: const Text(
                        '< التصفح كزائر',
                        style: TextStyle(
                          color: Colors.amber,
                          // fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
