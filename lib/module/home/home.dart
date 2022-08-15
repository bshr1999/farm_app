import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:man/model/product_model.dart';
import 'package:man/module/bottom_nav_bar/cubit.dart';
import 'package:man/module/bottom_nav_bar/states.dart';
import 'package:man/module/grid_view/grid_view.dart';
import 'package:man/module/show_farm/show_farm.dart';
import 'package:man/shared/local/shared_components.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    List<Map>Images=[
      {
        'image':'assets/images/meet.png',
        'name':'الملاحم',
      },
      {
        'image':'assets/images/kitchen.png',
        'name':'المطابخ',
      },
      {
        'image':'assets/images/sheep.png',
        'name':'المزارع',
      },
    ];
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return BlocConsumer<NavBarCubit,BottomNavBarStates>(
      listener: (context,state){},
      builder:(context,state){
        var cubit=NavBarCubit.get(context);
        return Scaffold(
          appBar:appBar(
              context: context,
              text: 'ذبيحتك وليمتك'),
          body: cubit.productModel==null?const Center(child: CircularProgressIndicator(color:Colors.amber,)):SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const Text(
                    'الأقسام',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index)=>viewItem(width: width, height: height, context: context, model: cubit.productModel!.data[index], index: index, data: Images[index]),
                      separatorBuilder: (context,index)=>const SizedBox(height: 20,),
                      itemCount: cubit.productModel!.data.length,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget viewItem({required Map data,required int index,required context,required ProductData model,required double width,required double height})=>InkWell(
    onTap: (){
      NavBarCubit.get(context).productSubModel=null;
      NavBarCubit.get(context).getProductSub(id: model.id!, kit: false);
      NavBarCubit.get(context).getProductSub(id: 2, kit: true);
      if(model.name!='المزارع'){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> GridViewShow(image: data['image'], name: data['name'], kitchenModel: null, isSheepKitchen: false,)));
      }else{
        NavBarCubit.get(context).getShowFarm(id: model.id!);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowFarm(productData: model,)));
      }

    },
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
            image:AssetImage(
              data['image'],
            ),
            fit: BoxFit.fill,
          ),
        ),
        Container(
          height: height*.25,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30,right: 10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              data['name'],
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
  );
}
