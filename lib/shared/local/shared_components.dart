
import 'package:flutter/material.dart';
import 'package:man/module/login/login.dart';
import 'package:man/shared/local/conest.dart';
import 'package:man/shared/local/shared_prefernces.dart';

Widget textForm({
  required bool isNum,
  FormFieldValidator<String>? validator,
  TextEditingController? controller,
  required TextInputType type,
  double? padding,
  Widget? suffixIcon,
  Widget? prefixIcon,
  required String label,
  FocusNode? focusNode,
  TextStyle? labelStyle,
  Color? colors,
})=>TextFormField(
  maxLength: isNum? 8:null,
  validator: validator,
  focusNode: focusNode,
  controller: controller,
  keyboardType: type,
  decoration: InputDecoration(
    contentPadding: EdgeInsetsDirectional.all(padding??0),
    enabledBorder:  OutlineInputBorder(
      borderSide: BorderSide(
        color: colors ?? Colors.black,
        width: 1.0,
      ),
    ),
    labelStyle: labelStyle,
    labelText: label,
    suffixIcon: suffixIcon,
    prefixIcon: prefixIcon,
    border: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.amber
      ),
    ),
  ),
);


Widget textButton ({
  required String text,
  required TextStyle textStyle,
  required VoidCallback onTap,
})=>Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.amber,
  ),
  child:TextButton(
    onPressed: onTap,
    child: Text(
      text,
      style: textStyle
    ),
  ),
);


PreferredSizeWidget appBar({
  required BuildContext context,
  required String text,
})=>AppBar(
  leading: const Image(
    image: AssetImage(
      'assets/images/00.png'
    ),
  ),
  actions: [
        PopupMenuButton(
          // ignore: prefer_const_constructors
          icon: Icon( Icons.help, color: Colors.white,),
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            PopupMenuItem(
              child: ListTile(
                onTap: () {},
                // leading: Icon(Icons.search_rounded),
                title: InkWell(
                    onTap: () async {
                      clint_id=null;
                      phone=null;
                      CacheHelper.removeData(key: 'phone');
                      CacheHelper.removeData(key: 'user_id');
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(clint_id == null?'تسجيل الدخول':"تسجيل الخروج ", style: TextStyle(
                            color: Colors.black
                        )
                        ),
                        const Icon(Icons.logout,),
                      ],
                    )
                ),
              ),
            ),
          ],
        )
  ],
  backgroundColor: Colors.amber,
  title: Text(
    text,
    style: const TextStyle(
      color: Colors.white,
    ),
  ),
);