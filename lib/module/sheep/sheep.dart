import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:man/model/goat_buy_model.dart';
import 'package:man/model/sheep_cart.dart';
import 'package:man/model/show_goat.dart';
import 'package:man/module/bottom_nav_bar/cubit.dart';
import 'package:man/module/bottom_nav_bar/states.dart';
import 'package:man/module/grid_view/grid_view.dart';
import 'package:man/module/login/login.dart';
import 'package:man/shared/local/conest.dart';
import 'package:man/shared/local/shared_components.dart';

class Sheep extends StatelessWidget {
  ShowGoatData showGoatData;

  // ignore: non_constant_identifier_names
  String? cut_values;
  String? name;

  Sheep({required this.name,required this.showGoatData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavBarCubit, BottomNavBarStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NavBarCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: appBar(
              context: context,
              text: 'ذبيحتك وليمتك'),
          body: NavBarCubit.get(context).showGoatInfoModel == null
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.amber,
                ))
              : Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ListView(
                      children: [
                        NavBarCubit.get(context).goatImgModel == null
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: Colors.amber,
                              ))
                            : CarouselSlider(
                                items: List.generate(
                                    NavBarCubit.get(context)
                                        .goatImgModel!
                                        .data
                                        .length,
                                    (index) => Image(
                                          width: double.infinity,
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                            '$imagePath${NavBarCubit.get(context).goatImgModel!.data[index].img!}',
                                          ),
                                        )),
                                options: CarouselOptions(
                                  height: 200,
                                  viewportFraction: 1.0,
                                  enlargeCenterPage: false,
                                  initialPage: 0,
                                  enableInfiniteScroll: true,
                                  reverse: false,
                                  autoPlay: true,
                                  // ignore: prefer_const_constructors
                                  autoPlayInterval: const Duration(seconds: 3),
                                  autoPlayAnimationDuration:
                                      const Duration(seconds: 1),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                        const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'معلومات الخاروف',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            children: [
                              Container(
                                color: Colors.amber[400],
                                child: Table(
                                  border: TableBorder.all(),
                                  children: [
                                    buildRow([
                                      const Text(''),
                                      const Text(
                                        'الحجم',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900),
                                      ),
                                      const Text(
                                        'العمر',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900),
                                      ),
                                      const Text(
                                        'السعر',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ]),
                                  ],
                                ),
                              ),
                              Table(
                                  border: TableBorder.all(),
                                  children: List.generate(
                                      cubit.showGoatInfoModel!.data.length,
                                      (index) => buildRow([
                                            Checkbox(
                                                checkColor: Colors.white,
                                                activeColor: Colors.amber,
                                                value: NavBarCubit.get(context)
                                                        .boolIndex == index,
                                                onChanged: (val) {
                                                  cubit.sheepBool(index: index);
                                                }),
                                            Text(
                                              NavBarCubit.get(context)
                                                  .showGoatInfoModel!
                                                  .data[index]
                                                  .size!,
                                            ),
                                            Text(NavBarCubit.get(context)
                                                .showGoatInfoModel!
                                                .data[index]
                                                .age!),
                                            Text(
                                                '${NavBarCubit.get(context).showGoatInfoModel!.data[index].price!} رق'),
                                          ]
                                      )
                                  )
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Text(
                            'تفاصيل الشراء',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        NavBarCubit.get(context).goatBuyDetailsModel == null
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: Colors.amber,
                              ))
                            : Column(
                                children: List.generate(
                                    NavBarCubit.get(context)
                                        .goatBuyDetailsModel!
                                        .data
                                        .length,
                                    (index) => buyDetails(
                                        model: NavBarCubit.get(context)
                                            .goatBuyDetailsModel!
                                            .data[index],
                                        index: index,
                                        context: context)),
                              ),
                        const SizedBox(
                          height: 200,
                        ),
                      ],
                    ),
                    Container(
                      height: 100,
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              'السعر: ${NavBarCubit.get(context).priceSheep + NavBarCubit.get(context).sheepSum}رق ',
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                  color: Colors.amber, fontSize: 18),
                            ),
                          ),
                          clint_id == null
                              ? Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 50, left: 50),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Login(),
                                              ));
                                        },
                                        child: const Text(
                                          'سجل دخولك اولا',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextButton(
                                      onPressed: (){
                                        if(NavBarCubit.get(context).priceSheep==0){
                                          toast(text: 'الرجاء اختيار الخاروف', state: ToastState.ERROR);
                                        }else{
                                          if (cubit.indexBuyGoat == 3) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        GridViewShow(
                                                          cutSheep: cut_values,
                                                          sheepSize: cubit
                                                              .showGoatInfoModel!
                                                              .data[cubit
                                                              .boolIndex!]
                                                              .size,
                                                          sheepAge: cubit
                                                              .showGoatInfoModel!
                                                              .data[cubit
                                                              .boolIndex!].age,
                                                          name: 'مطبخ',
                                                          image:
                                                          'assets/images/kitchen.png',
                                                          sheepName:
                                                          showGoatData.type,
                                                          sheepId:
                                                          showGoatData.id,
                                                          kitchenModel:
                                                          NavBarCubit
                                                              .get(
                                                              context)
                                                              .kitchenSubModel,
                                                          sheepImage:
                                                          '${showGoatData.img}',
                                                          sheepTotalPrice:
                                                          NavBarCubit
                                                              .get(
                                                              context)
                                                              .priceSheep +
                                                              NavBarCubit
                                                                  .get(
                                                                  context)
                                                                  .sheepSum,
                                                          isSheepKitchen: true,
                                                        )));
                                          } else {
                                            cubit.cart.add(SheepCart(
                                                image: showGoatData.img,
                                                nots: null,
                                                price: double.parse(
                                                    NavBarCubit
                                                        .get(context)
                                                        .showGoatInfoModel!
                                                        .data[cubit.boolIndex!]
                                                        .price!),
                                                id: clint_id,
                                                total: cubit.priceSheep +
                                                    cubit.sheepSum,
                                                cut_type: cut_values,
                                                desc_id: cubit
                                                    .goatBuyDetailsModel!
                                                    .data[cubit.indexBuyGoat!]
                                                    .id,
                                                goat_id: showGoatData.id,
                                                info_goat_id: cubit
                                                    .showGoatInfoModel!
                                                    .data[cubit.boolIndex!]
                                                    .id,
                                                type: 'خاروف',
                                                name:name,
                                                age: cubit.showGoatInfoModel!
                                                    .data[cubit.boolIndex!].age,
                                                size: cubit.showGoatInfoModel!
                                                    .data[cubit.boolIndex!]
                                                    .size,
                                                quantity: 1));
                                            toast(
                                                text:
                                                'تمت الاضافة الى السلة بنجاح',
                                                state: ToastState.SUCCESS);
                                          }
                                        }
                                      },
                                      child: Text(
                                        cubit.indexBuyGoat == 3
                                            ? 'انتقل الى المطبخ'
                                            : 'اضافة الى السلة',
                                        style: const TextStyle(
                                          color: Colors.white,
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

  TableRow buildRow(List<Widget> cells) =>
      TableRow(children: cells.map((cell) => Center(child: cell)).toList());

  Widget buyDetails(
          {required GoatBuyData model, required index, required context}) =>
      Row(
        children: [
          Checkbox(
              checkColor: Colors.white,
              activeColor: Colors.amber,
              value: NavBarCubit.get(context).indexBuyGoat == index,
              onChanged: (val) {
                NavBarCubit.get(context).boolChekBuyGoat(index);
                if (val! && index !=0) {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(children: [
                              DropdownButtonFormField(
                                validator: (value) {},
                                hint: const Text('نوع التقطيع'),
                                onTap: () {},
                                items: ['تقطيع صغير', 'تقطيع وسط', 'تقطيع كبير']
                                    .map<DropdownMenuItem<String>>(
                                        (String _value) {
                                  return DropdownMenuItem<String>(
                                      onTap: () {
                                        cut_values = _value;
                                      },
                                      value: _value,
                                      // add this property an pass the _value to it
                                      child: Text(
                                        _value,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ));
                                }).toList(),
                                onChanged: (dynamic value) {},
                              ),
                            ]),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.amber,
                                width: double.infinity,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'حفظ',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                }
              }),
          const SizedBox(
            width: 10,
          ),
          Text(
            model.name!,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 30,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: Colors.amber,
                ),
              ),
              child: Center(
                child: Text('${model.price} رق'),
              ),
            ),
          ),
        ],
      );
}
