import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:man/model/test_model.dart';
import 'package:man/module/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:man/module/bottom_nav_bar/cubit.dart';
import 'package:man/module/login/login.dart';
import 'package:man/module/login/login_cubit.dart';
import 'package:man/module/sign_up/cubit.dart';
import 'package:man/module/start_screen/start_screen.dart';
import 'package:man/shared/local/conest.dart';
import 'package:man/shared/local/shared_prefernces.dart';
import 'package:man/shared/network/dio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();
  log(CacheHelper.getStringData(key: 'user_id') ?? 'lk');
  log(DateTime.now().toString());
  if (CacheHelper.getStringData(key: 'user_id') != null) {
    log('hello');

    clint_id = int.parse(CacheHelper.getStringData(key: 'user_id')!);
    phone=CacheHelper.getStringData(key: 'phone');
  } else {
    log('bye');
    clint_id = null;
  }

  isFirst=CacheHelper.getBool(key: 'isFirst')??true;
  DioHelper.getData(
      headers: {
        'apikey':'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlsZHJ5cmJ6a3dra29md3V6Z3ZxIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY1NzY2MDQ5NCwiZXhwIjoxOTczMjM2NDk0fQ.K_GvF7MAi7c4mH6ZJx1YApX8js43k0TMVqwDOqmhgz0',
        'Authorization':'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlsZHJ5cmJ6a3dra29md3V6Z3ZxIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY1NzY2MDQ5NCwiZXhwIjoxOTczMjM2NDk0fQ.K_GvF7MAi7c4mH6ZJx1YApX8js43k0TMVqwDOqmhgz0',
      },
      url: 'https://ildryrbzkwkkofwuzgvq.supabase.co/rest/v1/variab?select=*'
  ).then((value) {
    testModel=TestModel.fromJson(value.data[0]);
    log(testModel!.type.toString());
  }).catchError((error){
    log(error.toString());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  bool isFree=true;

  MyApp({ Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    log('here');
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => NavBarCubit()..getProduct()),
        BlocProvider(create: (BuildContext context) => SignUpCubit()),
        BlocProvider(create: (BuildContext context) => LoginCubit()),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("ar", "AE"), // OR Locale('ar', 'AE') OR Other RTL locales
        ],
        locale: const Locale("ar", "AE"),
        title: 'ذبيحتك وليمتك',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Cairo',
          primarySwatch: Colors.blue,
        ),
        home: isFree? isFirst? const StartScreen():clint_id != null ?BottomNavBar(): Login() : const Text('انتهت الفترة المجانية'),
      ),
    );
  }
}
