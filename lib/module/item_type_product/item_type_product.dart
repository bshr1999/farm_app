import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:man/model/name_menu_model.dart';
import 'package:man/model/product_details.dart';
import 'package:man/model/product_sub_model.dart';
import 'package:man/model/show_farm.dart';
import 'package:man/model/show_goat.dart';
import 'package:man/module/Kitchen/kitchen.dart';
import 'package:man/module/bottom_nav_bar/cubit.dart';
import 'package:man/module/bottom_nav_bar/states.dart';
import 'package:man/module/meet/meet.dart';
import 'package:man/module/sheep/sheep.dart';
import 'package:man/shared/local/conest.dart';
import 'package:man/shared/local/shared_components.dart';

// ignore: must_be_immutable
class ItemTypeProduct extends StatelessWidget {
  ProductSubData? productSubData;
  ShowFarmData? showFarmData;
  ItemTypeProduct({this.productSubData,this.showFarmData,Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return BlocConsumer<NavBarCubit,BottomNavBarStates>(
        listener: (context,states){},
        builder: (context,state){
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: appBar(
                context: context,
                text: 'ذبيحتك وليمتك'),
            body: NavBarCubit.get(context).productDetailsModel==null||NavBarCubit.get(context).menuModel==null?const Center(child: CircularProgressIndicator(color: Colors.amber,)):SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image(
                            height: height*.25,
                            width: double.infinity,
                            image: NetworkImage(
                              productSubData!=null?'$imagePath${productSubData!.img!}':'$imagePath${showFarmData!.img!}',
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
                          padding: const EdgeInsets.only(bottom: 30,right: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              productSubData!.name!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      children: List.generate(NavBarCubit.get(context).productDetailsModel!.data.length, (index) => gridItem(width: width, context: context, model: NavBarCubit.get(context).productDetailsModel!.data[index])),
                      mainAxisSpacing: 1.0,
                      crossAxisSpacing: 1.0,
                      childAspectRatio: 1/1.2,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }


  Widget gridItem({required context,required double width,required ProductDetailsData model})=>InkWell(
    onTap:()async{
      if(productSubData!.type=='kitchen'||productSubData!.type=='meet'){
        NavBarCubit.get(context).count=1;
        NavBarCubit.get(context).totalPrice=0;
        NavBarCubit.get(context).price=0;
        NavBarCubit.get(context).oneVol=false;
        NavBarCubit.get(context).twoVol=true;
        NavBarCubit.get(context).threeVol=false;
        NavBarCubit.get(context).countMeet=0;
        NavBarCubit.get(context).totalMeetPrice=0;
        NavBarCubit.get(context).oneMeet=true;
        NavBarCubit.get(context).twoMeet=false;
        NavBarCubit.get(context).menuModel!.data.forEach((element)async{
          await NavBarCubit.get(context).getMenuSub(id: element.id!);
          List<String>b=[];
          log(element.name!);
          for (var element in NavBarCubit.get(context).menuSubModel!.data) {
            log(element.value!);
            b.add(element.value!);
          }
          NavBarCubit.get(context).names.add(NameMenuModel(names: b));
          log(b.toString());
        });
        NavBarCubit.get(context).volumeBool(firstC: 1, price: double.parse(model.cost!), twoVol: true, threeVol: false, oneVol: false,);
        Navigator.push(context, MaterialPageRoute(builder: (context) => Kitchen(modelDetails: model, modelSub: productSubData,sheepKitchens:false)));
      }else if(productSubData!.type=='epic'){
        NavBarCubit.get(context).countMeet=1;
        NavBarCubit.get(context).totalMeetPrice=double.parse(model.cost!);
        NavBarCubit.get(context).oneMeet=true;
        NavBarCubit.get(context).twoMeet=false;
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Meet(modelSub: productSubData,modelDetails: model,)));
      }
    },
    child: SizedBox(
      child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Center (
              child: Container(
                height: 140,
                width: width*.40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        spreadRadius: 4,
                        blurRadius: 2,
                        color: Colors.black12
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      model.name!,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 80,
              child: Center(
                child: Container(
                  height: 130,
                  width: width*.35,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.orange,
                          spreadRadius: 2,
                          blurRadius: 2
                      ),
                    ],
                  ),
                  child: Image(
                    width: double.infinity,
                    image:NetworkImage(
                      '$imagePath${model.img!}',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ]
      ),
    ),
  );
}
