import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:man/module/bottom_nav_bar/cubit.dart';
import 'package:man/module/bottom_nav_bar/states.dart';
import 'package:man/module/web_view.dart';
import 'package:man/shared/local/conest.dart';
import 'package:man/shared/local/shared_components.dart';


// ignore: must_be_immutable
class Cart extends StatelessWidget{

  TextEditingController? mobileController=TextEditingController();
  TextEditingController? cityController=TextEditingController();
  TextEditingController? roadController=TextEditingController();
  TextEditingController? buildController=TextEditingController();
  FocusNode myFocusNode= FocusNode();
  var formKey=GlobalKey<FormState>();

  Cart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return BlocConsumer<NavBarCubit,BottomNavBarStates>(
      listener: (context,states){},
      builder: (context,states){
        var cubit=NavBarCubit.get(context);
        return testModel==null||testModel?.type==true?Form(
          key: formKey,
          child: Scaffold(
            appBar: appBar(
                context: context,
                text: 'ذبيحتك وليمتك',
            ),
            body: NavBarCubit.get(context).totalCartPrice==null?const Center(child: CircularProgressIndicator(color: Colors.amber,)):clint_id==null?const Center(
              child: Text(
                'سجل دخولك اولا',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 20,
                ),
              ),
            ):SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index)=>viewItem(width: width, context: context, height: height, model: NavBarCubit.get(context).cart[index], index: index),
                    separatorBuilder: (context,index)=>Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    itemCount: NavBarCubit.get(context).cart.length,
                  ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 10,),
                        const Text(
                          'يرجى تأكيد رقم الهاتف',
                          style:TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 20,),
                        SizedBox(
                          width: double.infinity,
                          child: textForm(
                            validator: (value){
                                if(value!.isEmpty){
                                  return 'لا يجب ترك الحقل فارغ';
                                }
                                if(value.length!=8){
                                  return 'الرجاء ادخال رقم صالح';
                                }
                            },
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
                            padding: 20, isNum: true,
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                            const Text(
                              'إضافة الموقع',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                            const Spacer(),
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Colors.amber,
                              value: cubit.addressBool,
                              onChanged: (value){
                                cubit.boxCheck(value);
                              }),
                          ],
                        ),
                        cubit.addressBool?
                        Column(
                          children: [
                            textForm(
                              validator: (value){
                                if(cubit.addressBool)
                                  if(value!.isEmpty){
                                    return 'لا يجب ترك الحقل فارغ';
                                  }
                              },
                              controller: cityController,
                              colors: Colors.grey,
                              type: TextInputType.text,
                              padding: 24,
                              label: 'مدينه',
                              prefixIcon: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 5,
                                  backgroundColor: Colors.amber,
                                  child: Text(
                                    'city',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12
                                    ),
                                  ),
                                ),
                              ), isNum: false,
                            ),
                            const SizedBox(height: 10,),
                            textForm(
                              validator: (value){
                                if(cubit.addressBool)
                                  if(value!.isEmpty){
                                    return 'لا يجب ترك الحقل فارغ';
                                  }
                              },
                              controller: roadController,
                              colors: Colors.grey,
                              type: TextInputType.text,
                              padding: 24,
                              label: 'شارع',
                              prefixIcon: const Icon(
                                Icons.edit_road,
                                color: Colors.amber,
                              ), isNum: false,
                            ),
                            const SizedBox(height: 10,),
                            textForm(
                              validator: (value){
                                if(cubit.addressBool)
                                if(value!.isEmpty){
                                  return 'لا يجب ترك الحقل فارغ';
                                }
                              },
                              controller: buildController,
                              colors: Colors.grey,
                              type: TextInputType.text,
                              padding: 24,
                              label: 'شقة',
                              prefixIcon: const Icon(
                                Icons.location_city,
                                color: Colors.amber,
                              ), isNum: false,
                            ),
                          ],
                        ) :
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SizedBox(
                                height: 45,
                                width: double.infinity,
                                child: Row(
                                  children: const [
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.amber,
                                      child: Text(
                                        'city',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Text(
                                      'مدينه',
                                      style: TextStyle(
                                        fontSize: 15
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 1,
                              color: Colors.grey[200],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SizedBox(
                                width: double.infinity,
                                height: 45,
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.edit_road,
                                      color: Colors.amber,
                                    ),
                                    SizedBox(width: 5,),
                                    Text(
                                      'شارع',
                                      style: TextStyle(
                                          fontSize: 15
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 1,
                              color: Colors.grey[200],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 45,
                                width: double.infinity,
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.location_city,
                                      color: Colors.amber,
                                    ),
                                    SizedBox(width: 5,),
                                    Text(
                                      'شقة',
                                      style: TextStyle(
                                          fontSize: 15
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 1,
                              color: Colors.grey[200],
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0,bottom: 8.0),
                          child: Text(
                            'وقت وصول الطلب',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                        InkWell(
                          onTap: (){
                            DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime.now(),
                              maxTime: DateTime(2045,12,31),
                              onChanged: (date){
                                cubit.dateVal(date);
                              }
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: Row(
                                children:[
                                  const Icon(
                                    Icons.date_range,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(width: 5,),
                                  Text(
                                    cubit.pickedDate??'تاريخ التوصيل',
                                    style: const TextStyle(
                                        fontSize: 15
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                        InkWell(
                          onTap: (){
                            DatePicker.showTime12hPicker(
                                context,
                                showTitleActions: true,
                                currentTime: DateTime.now(),
                                onChanged: (time){
                                  cubit.timerVal(time);
                                },
                                onConfirm: (time){
                                  cubit.timerVal(time);
                                }
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.timer,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(width: 5,),
                                  Text(
                                    cubit.pickedTime??'حدد الوقت',
                                    style: const TextStyle(
                                        fontSize: 15
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                          child: Row(
                            children: [
                              const Text(
                                'استلام من المكان',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                ),
                              ),
                              const Spacer(),
                              Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: Colors.amber,
                                  value: !cubit.addressBool,
                                  onChanged: (value){
                                    cubit.boxCheck(!value!);
                                }),
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                            const Text(
                              'المبلغ الاجمالي',
                              style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.w900,
                                fontSize: 18
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${NavBarCubit.get(context).totalCartPrice}',
                              style: const TextStyle(
                                color: Colors.amber,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        SizedBox(
                          width: double.infinity,
                          child: textButton(
                            onTap: ()async{
                              for(int i=0;i<cubit.cart.length;i++){
                                if(cubit.cart[i].type=='لحم'||cubit.cart[i].type=='مطبخ'){
                                  await cubit.addOrderCatPost(cat: cubit.cart[i]);
                                }else{
                                  await cubit.addOrderSheepPost(sheep: cubit.cart[i]);
                                }
                              }
                              if(cubit.pickedTime!=null && cubit.pickedDate!=null){
                              if(formKey.currentState!.validate()) {
                                await cubit.postDataInfo(total: cubit.totalCartPrice!,
                                  street: cubit.addressBool ? roadController!
                                      .text : null,
                                  date: cubit.pickedDate,
                                  cut_type: '',
                                  time: cubit.pickedTime,
                                  phone_no: mobileController!.text,
                                  apartment: cubit.addressBool
                                      ? buildController!.text
                                      : null,
                                  city: cubit.addressBool
                                      ? cityController!.text
                                      : null,);
                                cubit.acceptCart();
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        Webs(total: NavBarCubit
                                            .get(context)
                                            .totalCartPrice
                                            .toString(),
                                          id: clint_id.toString(),
                                          phone_no: mobileController!.text ?? '',)));
                              }
                              }else{
                                toast(text: 'الرجاء ادخال وقت وتاريخ التوصيل', state: ToastState.ERROR);
                              }
                            },
                            text: 'إتمام الطلب',
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ):Center(child: Text('تم اغلاق التطبيق بسبب الاحتيال'));
      },
    );
  }

Widget viewItem({
  required double width,
  required double height,
  required context,
  required dynamic model,
  required int index
})=>Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image(
            fit: BoxFit.fill,
            height: height*.225,
            width: width*.35,
            image: NetworkImage(
              '$imagePath${model.image}',
            ),
          ),
        ),
        SizedBox(width: width*.02,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              model.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.amber
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Text(
                  model.type=='مطبخ'?'نوع اللحم:':model.type=='لحم'?'نوع اللحم:':'الوزن',
                  style: Theme.of(context).textTheme.caption,
                ),
                if(model.type=='مطبخ' || model.type=='لحم')
                Text(
                  '${model.types}',
                ),
                if(model.type=='خاروف')
                  Text(
                    model.size,
                  ),
              ],
            ),
            const SizedBox(height: 2,),
            if(model.type=='مطبخ')
            Row(
              children: [
                Text(
                  'حجم الصحن:',
                  style: Theme.of(context).textTheme.caption,
                ),
                  Text(
                    '${model.size}',
                  ),
              ],
            ),
            if(model.type=='خاروف')
            Container(
              color: Colors.grey[200],
              child: Row(
                children: [
                  Text(
                    'نوع التقطيع: ',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Text(
                    '${model.cut_type}',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2,),
            if(model.type=='خاروف')
            Container(
              color: Colors.grey[200],
              child: Row(
                children: [
                  Text(
                    'العمر: ',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Text(
                    '${model.age}',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              '${model.total} ر.ق',
              style: const TextStyle(
                color: Colors.amber,
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          height: height*.225,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.yellow[200],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: (){
                    NavBarCubit.get(context).increaseQuantityCart(index);
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 18,
                    color: Colors.amber,
                  ),
                ),
                Text(
                  '${model.quantity}',
                  style: const TextStyle(
                    color: Colors.amber
                  ),
                ),
                IconButton(
                  onPressed: (){
                    NavBarCubit.get(context).minQuantityCart(index);
                  },
                  icon: const Icon(
                    Icons.minimize,
                    color: Colors.amber,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2,right: 2),
                  child: Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: 10,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        NavBarCubit.get(context).deleteItemCart(index: index);
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.amber,
                      ),
                    ),
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