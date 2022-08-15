import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:man/model/login_model.dart';
import 'package:man/module/login/login_states.dart';
import 'package:man/shared/network/dio.dart';

import '../../shared/local/conest.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialStates());


  static LoginCubit get(context)=>BlocProvider.of(context);

  LoginModel? loginModel;
  Future<void> login({required String name,required int phone})async {
    emit(LoginLoadingState());
    await DioHelper.getData(
      headers: {},
      url: '${url}login?name=$name&phone_no=${phone.toString()}',
    ).then((value){
      loginModel=LoginModel.fromJson(value.data);
      log(value.data.toString());
      toast(text: loginModel?.statos!=200?'خطأ في الإيميل أو كلمة السر':'تم تسجيل الدخول بنجاح', state: loginModel?.statos!=200?ToastState.ERROR:ToastState.SUCCESS);
      emit(LoginSuccessState());
    }).catchError((error){
      toast(text: 'الرجاء التحقق من البيانات المدخلة', state: ToastState.ERROR);
      emit(LoginErrorState());
      log(error.toString());
    });
  }
}