import 'package:man/module/sign_up/sign_up.dart';

abstract class SignUpStates{}

class SignUpInitialStates extends SignUpStates{}

class GetSmsCodeState extends SignUpStates{}

class LoadingGetSmsCodeState extends SignUpStates{}

class LoadingSignUpState extends SignUpStates{}

class SuccessSignUpState extends SignUpStates{}

class ErrorSignUpState extends SignUpStates{}
