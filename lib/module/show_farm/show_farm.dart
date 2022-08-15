import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:man/model/product_model.dart';
import 'package:man/model/product_sub_model.dart';
import 'package:man/model/show_farm.dart';
import 'package:man/module/bottom_nav_bar/cubit.dart';
import 'package:man/module/bottom_nav_bar/states.dart';
import 'package:man/module/item_type_farm/item_type_farm.dart';
import 'package:man/shared/local/conest.dart';
import 'package:man/shared/local/shared_components.dart';


// ignore: must_be_immutable
class ShowFarm extends StatelessWidget {
  ProductData productData;
  ShowFarm({required this.productData,Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return BlocConsumer<NavBarCubit,BottomNavBarStates>(
        listener: (context,states){},
        builder: (context,state){
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: appBar
              (
                context: context,
                text: 'ذبيحتك وليمتك'),
            body: NavBarCubit.get(context).showFarmModel==null?const Center(child: CircularProgressIndicator(color: Colors.amber,)):SingleChildScrollView(
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
                            image: const AssetImage(
                              'assets/images/sheep.png',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          height: height*.25,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black26,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30,right: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              productData.name!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
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
                      children: List.generate(NavBarCubit.get(context).showFarmModel!.data.length, (index) => gridItem(context: context, model: NavBarCubit.get(context).showFarmModel!.data[index])),
                      mainAxisSpacing: 1.0,
                      crossAxisSpacing: 1.0,
                      childAspectRatio: 1/0.8,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  Widget gridItem({required context,required ShowFarmData model})=>InkWell(
    onTap: (){
      log(model.id.toString());
      NavBarCubit.get(context).showGoatModel=null;
      NavBarCubit.get(context).getShowGoat(id: model.id!);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> ItemTypeFarm(showFarmData: model,productSubData: null,)));
    },
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Container(
              height: 200,
              width: 200,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image(
                width: double.infinity,
                image:NetworkImage(
                  '$imagePath${model.img!}',
                ),
                fit: BoxFit.fill,
              ),
            ),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black26,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 6,right: 6),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  model.name!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ]),
    ),
  );
}
