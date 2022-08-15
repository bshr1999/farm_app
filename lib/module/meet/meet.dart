import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:man/model/categories_cart.dart';
import 'package:man/model/product_details.dart';
import 'package:man/model/product_sub_model.dart';
import 'package:man/module/bottom_nav_bar/cubit.dart';
import 'package:man/module/bottom_nav_bar/states.dart';
import 'package:man/module/login/login.dart';
import 'package:man/shared/local/conest.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/local/shared_components.dart';

class Meet extends StatelessWidget {
  ProductDetailsData? modelDetails;
  ProductSubData ?modelSub;
  Meet({required this.modelSub,required this.modelDetails,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return BlocConsumer<NavBarCubit,BottomNavBarStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit= NavBarCubit.get(context);
        return Scaffold(
          appBar: appBar(text: 'ذبيحتك وليمتك',
            context: context,
          ),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: AlignmentDirectional.topStart,
                          children: [
                            Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image(
                                height: height*.25,
                                width: double.infinity,
                                image:NetworkImage(
                                  '$imagePath${modelSub!.img}',
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 30,right: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    modelSub!.name!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // ignore: prefer_const_constructors
                      SizedBox(height: 10,),
                      const Padding(
                        padding: EdgeInsets.only(right:8.0),
                        child: Text(
                          'تفاصيل الملحمة',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8,),
                      Padding(
                        padding: const EdgeInsets.only(right:8.0),
                        child: Text(
                          modelSub!.desc!,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 25,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 10,),
                            Text(
                                modelSub!.address!
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: InkWell(
                          onTap:()async{
                            await launch('tel:${modelSub!.phoneNo!}');
                          },
                          child: Row(
                            children: [
                              // ignore: prefer_const_constructors
                              Icon(
                                Icons.call,
                                size: 25,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 10,),
                              Text(
                                modelSub!.phoneNo!,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Text(
                          'أصناف اللحوم',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SizedBox(
                          height: 60,
                          child: ListView (
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            children: [
                              Row(
                                children: [
                                  const Text(
                                      'الكمية: '
                                  ),
                                  InkWell(
                                    onTap: (){
                                      cubit.meetBool(one: !cubit.oneMeet, two: false, price: double.parse(modelDetails!.cost!),);

                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: cubit.oneMeet?Colors.amber:Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          width: 2,
                                          color: Colors.amber,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(
                                          'كيلو',
                                          style: TextStyle(
                                            color: cubit.oneMeet?Colors.white:Colors.amber,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20,),
                                  InkWell(
                                    onTap: (){
                                      cubit.meetBool(one: false, two: !cubit.twoMeet, price: double.parse(modelDetails!.cost!));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: cubit.twoMeet?Colors.amber:Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          width: 2,
                                          color: Colors.amber,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(
                                          '2 كيلو',
                                          style: TextStyle(
                                            color: cubit.twoMeet?Colors.white:Colors.amber,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  const Text(
                                      'اكثر: '
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.amber,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon:const Icon(
                                            Icons.add,
                                            color:Colors.amber,
                                          ),
                                          onPressed:(){
                                            cubit.meetBool(one: false, two: false, price: double.parse(modelDetails!.cost!));
                                            NavBarCubit.get(context).countMeetPlus(price: double.parse(modelDetails!.cost!));
                                          },
                                        ),
                                        // ignore: prefer_const_constructors
                                        Text(
                                          '${NavBarCubit.get(context).countMeet}',
                                          // ignore: prefer_const_constructors
                                          style:TextStyle(
                                              color:Colors.amber
                                          ),
                                        ),
                                        IconButton(
                                          icon:const Icon(Icons.minimize_outlined,color: Colors.amber,),
                                          onPressed:(){
                                            cubit.meetBool(one: false, two: false, price: double.parse(modelDetails!.cost!));
                                            NavBarCubit.get(context).countMeetMin(price: double.parse(modelDetails!.cost!));
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        color: Colors.grey,
                        height: 1,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'النوع',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Stack(
                          children: [
                            Container(
                              height: 200,
                              width: 200,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  '$imagePath${modelDetails!.img!}',
                                ),
                              ),
                            ),
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Checkbox(value: true, onChanged: (value){},checkColor: Colors.white,activeColor: Colors.amber),
                                  const SizedBox(height: 100,),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      modelDetails!.name!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white,
                                          fontSize: 20
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 60,),
                    ],
                  ),
                ],
              ),
              Container(
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    children: [
                      Text(
                        'السعر: ${NavBarCubit.get(context).totalMeetPrice}رق ',
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 18,
                          fontWeight: FontWeight.w900
                        ),
                      ),
                      clint_id == null
                          ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                              },
                              child: const Text(
                                'سجل دخولك اولا',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ):
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: (){
                                if(NavBarCubit.get(context).totalMeetPrice!=0) {
                                  NavBarCubit
                                      .get(context)
                                      .cart
                                      .add(CategoriesCart(
                                    price: double.parse(modelDetails!.cost!),
                                    clint_id: clint_id,
                                    nots: null,
                                    name_menu: null,
                                    product_id: modelDetails!.id,
                                    quantity: NavBarCubit
                                        .get(context)
                                        .countMeet,
                                    size: null,
                                    image: modelDetails!.img,
                                    total: NavBarCubit
                                        .get(context)
                                        .totalMeetPrice,
                                    name: modelDetails!.name,
                                    type: 'لحم',
                                    types: modelDetails!.meatType,
                                  ),
                                    );
                                  toast(text: 'تمت الاضافة الى السلة بنجاح',
                                      state: ToastState.SUCCESS);
                                }else{
                                  toast(text: 'الرجاء تحديد الكمية', state: ToastState.ERROR);
                                }
                                },
                              child: const Text(
                                'اضافة الى السلة',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
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
      },
    );
  }
}
