import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:man/model/sign_model.dart';
import 'package:man/model/sms_code.dart';
import 'package:man/module/sign_up/states.dart';
import 'package:man/shared/local/conest.dart';
import 'package:man/shared/network/dio.dart';

class SignUpCubit extends Cubit<SignUpStates>{
  SignUpCubit() : super(SignUpInitialStates());

  static SignUpCubit get(context)=>BlocProvider.of(context);

  SmsModel? smsModel;
  Future<void> getSms({required String phone})async{
    emit(LoadingGetSmsCodeState());
    await DioHelper.getData(
      headers: {

      },
      url: '${url}send_sms?phone_no=$phone',
    ).then((value){
      smsModel=SmsModel.fromJson(value.data);
      log(value.data.toString());
      emit(GetSmsCodeState());
    }).catchError((error){
      log(error.toString());
    });
  }

  SignModel? signModel;
  Future<void> signUp({required String fullName,required String phoneNo,required String name})async{
    emit(LoadingSignUpState());
    await DioHelper.postData(
      headers: {},
      url: '${url}sing_in?name=$name&phone_no=$phoneNo&full_name=$fullName',
      data: {},
    ).then((value){
      signModel=SignModel.fromJson(value.data);
      log(value.data.toString());
      toast(text: 'تم تسجيل الدخول بنجاح', state: ToastState.SUCCESS);
      emit(SuccessSignUpState());
    }).catchError((error){
      log(error.toString());
      toast(text: 'تعذر تسجيل حساب', state: ToastState.ERROR);
      emit(ErrorSignUpState());
    });
  }
}