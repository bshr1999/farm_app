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
class Profile extends StatelessWidget {

  Profile({Key? key}) : super(key: key);
  var mobileController=TextEditingController();
  var nameController=TextEditingController();
  FocusNode myFocusNode=FocusNode();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return BlocConsumer<LoginCubit,LoginStates>(
      listener: (context,state){},
      builder: (context,state){
        return Form(
          key: formKey,
          child: Scaffold(
            appBar: appBar(
                context: context,
                text: 'ذبيحتك وليمتك'),
            body: SingleChildScrollView(
              // ignore: sized_box_for_whitespace
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: height*.03,),
                    SizedBox(
                      width: width*.80,
                      height: height*.1,
                      child: textForm(
                        validator: (value){
                          if(value!.isEmpty){
                            return 'الرجاء إدخال رقم صالح';
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
                        padding: 24, isNum: true,
                      ),
                    ),
                    SizedBox(height: height*.04,),
                    SizedBox(
                      width: width*.80,
                      height: height*.1,
                      child: textForm(
                        validator: (value){
                          if(value!.isEmpty){
                            return 'الرجاء إدخال اسم صالح';
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
                        padding: 18, isNum: false,
                      ),
                    ),
                    SizedBox(height: height*.01,),
                    SizedBox(
                      width: width*.80,
                      child: Row(
                        children: [
                          const Text(
                            'اضغط هنا اذا لم تمتلك حساب ؟',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUp()));
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
                    SizedBox(height: height*.03,),
                    state is LoginLoadingState ? CircularProgressIndicator(color: Colors.amber,):
                    SizedBox(
                        height: 65,
                        width: width*.80,
                        child: textButton(text: 'تحقق وتفعيل', textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ), onTap: ()async{
                          if(clint_id==null){
                          if(formKey.currentState!.validate()){
                            await LoginCubit.get(context).login(name: nameController.text, phone: int.parse(mobileController.text));
                            if(LoginCubit.get(context).loginModel!.statos==200 && LoginCubit.get(context).loginModel!.data!=null)
                            {
                              CacheHelper.setStringData(key: 'phone', value: mobileController.text);
                              CacheHelper.setStringData(key: 'user_id', value: (LoginCubit.get(context).loginModel!.data![0].id).toString());
                              clint_id=LoginCubit.get(context).loginModel!.data![0].id;
                            }
                          }
                         }else{
                            toast(text: 'لديك بالفعل حساب في التطبيق', state: ToastState.WARNING);
                          }
                       },
                     )
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
