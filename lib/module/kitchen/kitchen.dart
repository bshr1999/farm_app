import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:man/model/categories_cart.dart';
import 'package:man/model/menu_model.dart';
import 'package:man/model/product_details.dart';
import 'package:man/model/product_sub_model.dart';
import 'package:man/model/sheep_cart.dart';
import 'package:man/module/bottom_nav_bar/cubit.dart';
import 'package:man/module/bottom_nav_bar/states.dart';
import 'package:man/module/login/login.dart';
import 'package:man/shared/local/conest.dart';
import 'package:man/shared/local/shared_components.dart';
import 'package:url_launcher/url_launcher.dart';

class Kitchen extends StatelessWidget {
  ProductDetailsData? modelDetails;
  ProductSubData? modelSub;
  bool sheepKitchens = false;
  double? sheepTotalPrice;
  String? sheepImage;
  int? sheepId;
  String? sheepName;
  String? sheepAge;
  String? sheepSize;
  String? cut;

  TextEditingController noteController = TextEditingController();

  Kitchen(
      {
        this.cut,
      this.sheepSize,
      this.sheepAge,
      required this.sheepKitchens,
      this.sheepName,
      this.sheepTotalPrice,
      this.sheepImage,
      this.sheepId,
      required this.modelSub,
      required this.modelDetails,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<NavBarCubit, BottomNavBarStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NavBarCubit.get(context);
        return Scaffold(
          appBar: appBar(
            text: 'ذبيحتك وليمتك',
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
                                height: height * .25,
                                width: double.infinity,
                                image: NetworkImage(
                                  '$imagePath${modelSub!.img!}',
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              height: height*.25,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black38,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 30, right: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  modelSub!.name!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Text(
                          'تفاصيل المطبخ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
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
                            const SizedBox(
                              width: 10,
                            ),
                            Text(modelSub!.address!),
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
                              const Icon(
                                Icons.call,
                                size: 25,
                                color: Colors.amber,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                modelSub!.phoneNo!,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (sheepKitchens)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
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
                                    '$imagePath$sheepImage',
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
                                    Checkbox(
                                        value: true,
                                        onChanged: (value) {},
                                        checkColor: Colors.white,
                                        activeColor: Colors.amber),
                                    const SizedBox(
                                      height: 100,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Text(
                                        sheepName ?? '',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (!sheepKitchens)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: SizedBox(
                                height: 60,
                                child: ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  children: [
                                    Row(
                                      children: [
                                        const Text('الكمية: '),
                                        InkWell(
                                          onTap: () {
                                            cubit.quantityBool(
                                              one: !cubit.one,
                                              two: false,
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: cubit.one
                                                  ? Colors.amber
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.amber,
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 12.0, bottom: 12.0,left: 18.0,right: 18.0),
                                              child: Text(
                                                'صحن',
                                                style: TextStyle(
                                                  color: cubit.one
                                                      ? Colors.white
                                                      : Colors.amber,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            cubit.quantityBool(
                                                one: false, two: !cubit.two);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: cubit.two
                                                  ? Colors.amber
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.amber,
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 12.0, bottom: 12.0,left: 18.0,right: 18.0),
                                              child: Text(
                                                'صحنين',
                                                style: TextStyle(
                                                  color: cubit.two
                                                      ? Colors.white
                                                      : Colors.amber,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text('اكثر: '),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(
                                              width: 1,
                                              color: Colors.amber,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.add,
                                                  color: Colors.amber,
                                                ),
                                                onPressed: () {
                                                  cubit.quantityBool(
                                                      one: false, two: false);
                                                  cubit.countPlus();
                                                },
                                              ),
                                              // ignore: prefer_const_constructors
                                              Text(
                                                '${cubit.count}',
                                                // ignore: prefer_const_constructors
                                                style: TextStyle(
                                                    color: Colors.amber),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.minimize_outlined,
                                                  color: Colors.amber,
                                                ),
                                                onPressed: () {
                                                  cubit.quantityBool(
                                                      one: false, two: false);
                                                  cubit.countMin();
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
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: SizedBox(
                                height: 40,
                                child: ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'الحجم: ',
                                        ),
                                        InkWell(
                                          onTap: () {
                                            cubit.volumeBool(
                                                oneVol: !cubit.oneVol,
                                                twoVol: false,
                                                threeVol: false,
                                                price: double.parse(
                                                    modelDetails!.costSmall!), firstC: null);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: cubit.oneVol
                                                  ? Colors.amber
                                                  : Colors.white,
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.amber,
                                              ),
                                            ),
                                            // ignore: prefer_const_constructors
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top:6,bottom: 6,right: 25.0, left: 25),
                                              child: Text(
                                                'صغير',
                                                style: TextStyle(
                                                  color: cubit.oneVol
                                                      ? Colors.white
                                                      : Colors.amber,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            cubit.volumeBool(
                                                oneVol: false,
                                                twoVol: !cubit.twoVol,
                                                threeVol: false,
                                                price: double.parse(
                                                    modelDetails!.cost!), firstC: null);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: cubit.twoVol
                                                  ? Colors.amber
                                                  : Colors.white,
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.amber,
                                              ),
                                            ),
                                            // ignore: prefer_const_constructors
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top:6,bottom: 6,right: 25.0, left: 25),
                                              child: Text(
                                                'متوسط',
                                                style: TextStyle(
                                                  color: cubit.twoVol
                                                      ? Colors.white
                                                      : Colors.amber,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            cubit.volumeBool(
                                                oneVol: false,
                                                twoVol: false,
                                                threeVol: !cubit.threeVol,
                                                price: double.parse(
                                                    modelDetails!.costBig!), firstC: null);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: cubit.threeVol
                                                  ? Colors.amber
                                                  : Colors.white,
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.amber,
                                              ),
                                            ),
                                            // ignore: prefer_const_constructors
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top:6,bottom: 6,right: 25.0, left: 25),
                                              child: Text(
                                                'كبير',
                                                style: TextStyle(
                                                  color: cubit.threeVol
                                                      ? Colors.white
                                                      : Colors.amber,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Colors.grey,
                              height: 1,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 16,right: 25.0),
                              child: Text(
                                'ملاحظة',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 18.0,left: 18),
                                child: textForm(
                                  padding: 20,
                                  type: TextInputType.text,
                                  label: 'ملاحظة',
                                  controller: noteController,
                                  prefixIcon: const Icon(
                                    Icons.speaker_notes,
                                    color: Colors.amber,
                                  ), isNum: false,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Colors.grey,
                              height: 1,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                children: [
                                  const Text(
                                      'هل تريد اضافة المزيد من التفاصيل؟ '),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: TextButton(
                                      onPressed: () async {
                                        showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) => Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Center(
                                                child: Text(
                                                  'منيو الطبخ',
                                                  style: TextStyle(
                                                    color: Colors.amber,
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                              cubit.menuModel == null
                                                  ? const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                      color: Colors.amber,
                                                    ))
                                                  : Column(
                                                      children: List.generate(
                                                          NavBarCubit.get(
                                                                  context)
                                                              .menuModel!
                                                              .data
                                                              .length,
                                                          (index) => sheetMenu(
                                                              model: NavBarCubit
                                                                      .get(
                                                                          context)
                                                                  .menuModel!
                                                                  .data[index],
                                                              context: context,
                                                              index: index)),
                                                    ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  color: Colors.amber,
                                                  width: double.infinity,
                                                  child: TextButton(
                                                      onPressed: () {
                                                        for(int i=0;i<cubit.drinks.length;i++){
                                                          cubit.stringDrink='${cubit.stringDrink} + ${cubit.drinks[i]}';
                                                        }
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        'حفظ',
                                                        style: TextStyle(
                                                            color: Colors.white),
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'تفاصيل اكثر',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Colors.grey,
                              height: 1,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'نوع الطبخ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 18),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Checkbox(
                                            value: true,
                                            onChanged: (value) {},
                                            checkColor: Colors.white,
                                            activeColor: Colors.amber),
                                        const SizedBox(
                                          height: 100,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: Text(
                                            modelDetails!.name!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
              Container(
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        sheepKitchens
                            ? 'السعر: $sheepTotalPriceرق '
                            : 'السعر: ${NavBarCubit.get(context).totalPrice}رق ',
                        style: const TextStyle(fontWeight: FontWeight.w900,color: Colors.amber, fontSize: 18),
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
                          )
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    if (!sheepKitchens){
                                      if(cubit.totalPrice==0){
                                        toast(text: 'الرجاء اختيار منتج', state: ToastState.ERROR);
                                      }else{
                                      NavBarCubit.get(context).cart.add(
                                          CategoriesCart(
                                              total: cubit.totalPrice,
                                              image: modelDetails!.img,
                                              size: cubit.oneVol
                                                  ? 'صغير'
                                                  : cubit.twoVol
                                                      ? 'وسط'
                                                      : 'كبير',
                                              clint_id: clint_id,
                                              price: cubit.oneVol
                                                  ? double.parse(
                                                      modelDetails!.costSmall!)
                                                  : cubit.twoVol
                                                      ? double.parse(
                                                          modelDetails!.cost!)
                                                      : double.parse(modelDetails!.costBig!),
                                              name_menu: cubit.stringDrink,
                                              nots: noteController.text,
                                              product_id: modelDetails!.id,
                                              quantity: cubit.count,
                                              name: modelDetails!.name,
                                              type: 'مطبخ',
                                              types: modelDetails!.meatType)
                                        );
                                      toast(text: 'تمت الاضافة الى السلة بنجاح', state: ToastState.SUCCESS);
                                      }
                                    }else {
                                      cubit.cart.add(SheepCart(
                                          image: sheepImage,
                                          nots: modelSub!.name,
                                          price: double.parse(
                                              NavBarCubit.get(context)
                                                  .showGoatInfoModel!
                                                  .data[cubit.boolIndex!]
                                                  .price!),
                                          id: clint_id,
                                          total: sheepTotalPrice,
                                          cut_type: cut,
                                          desc_id: cubit.goatBuyDetailsModel!
                                              .data[cubit.indexBuyGoat!].id,
                                          goat_id: sheepId,
                                          info_goat_id: cubit.showGoatInfoModel!
                                              .data[cubit.boolIndex!].id,
                                          name: sheepName,
                                          type: 'خاروف',
                                          age: sheepAge,
                                          size: sheepSize,
                                          quantity: 1));
                                      toast(text: 'تمت الاضافة الى السلة بنجاح', state: ToastState.SUCCESS);
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
            ],
          ),
        );
      },
    );
  }

  Widget sheetMenu(
          {required context, required int index, required MenuData model}) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              model.name!,
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButtonFormField(
              validator: (value) {},
              hint: Text(model.name!),
              onTap: () {},
              items: NavBarCubit.get(context)
                  .names[index]
                  .names
                  .map<DropdownMenuItem<String>>((String _value) {
                return DropdownMenuItem<String>(
                    onTap: () {
                      log(NavBarCubit.get(context).drinks.toString());
                      NavBarCubit.get(context).drinks.add(_value);
                    },
                    value: _value,
                    // add this property an pass the _value to it
                    child: Text(
                      _value,
                      style: const TextStyle(color: Colors.black),
                    ));
              }).toList(),
              onChanged: (dynamic value) {},
            ),
          ],
        ),
      );
}
