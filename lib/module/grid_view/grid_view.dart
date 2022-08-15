import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:man/model/product_model.dart';
import 'package:man/model/product_sub_model.dart';
import 'package:man/module/bottom_nav_bar/cubit.dart';
import 'package:man/module/bottom_nav_bar/states.dart';
import 'package:man/module/item_type_farm/item_type_farm.dart';
import 'package:man/module/item_type_product/item_type_product.dart';
import 'package:man/module/kitchen/kitchen.dart';
import 'package:man/shared/local/conest.dart';
import 'package:man/shared/local/shared_components.dart';


class GridViewShow extends StatelessWidget {
  String? name;
  String? image;
  bool isSheepKitchen=false;
  double? sheepTotalPrice;
  String? sheepImage;
  int? sheepId;
  String? sheepName;
  String? sheepAge;
  ProductSubModel? kitchenModel;
  String? sheepSize;
  String? cutSheep;

  GridViewShow({this.cutSheep,this.sheepSize,this.sheepAge,required this.isSheepKitchen,this.sheepName,this.sheepImage,this.sheepTotalPrice,this.sheepId,required this.kitchenModel,required this.name,required this.image,Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return BlocConsumer<NavBarCubit,BottomNavBarStates>(
      listener: (context,states){},
      builder: (context,state){
        return testModel==null||testModel!.type==true?Scaffold(
          backgroundColor: Colors.white,
          appBar: appBar(
              context: context,
              text: 'ذبيحتك وليمتك'),
          body: NavBarCubit.get(context).productSubModel==null?const Center(child: CircularProgressIndicator(color: Colors.amber,)):SingleChildScrollView(
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
                          image: AssetImage(
                            image!,
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
                            name!,
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
                const SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    children: List.generate(kitchenModel!=null?kitchenModel!.data.length:NavBarCubit.get(context).productSubModel!.data.length, (index) => gridItem(context: context, model: kitchenModel!=null?kitchenModel!.data[index]:NavBarCubit.get(context).productSubModel!.data[index])),
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    childAspectRatio: 1/0.8,
                  ),
                ),
              ],
            ),
          ),
        ):Center(child: Text('تم اغلاق التطبيق بسبب الاحتيال'));
      }
    );
  }

  Widget gridItem({required context,required ProductSubData model})=>InkWell(
    onTap: (){
      NavBarCubit.get(context).productDetailsModel=null;
      NavBarCubit.get(context).getProductDetails(id: model.id!);
      NavBarCubit.get(context).getMenu( );
      if(!isSheepKitchen) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ItemTypeProduct(productSubData: model,showFarmData: null,)));
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Kitchen(cut: cutSheep,sheepKitchens: true,sheepId: sheepId,sheepName: sheepName,sheepImage: sheepImage,sheepTotalPrice: sheepTotalPrice, modelSub: model, modelDetails: null, sheepAge: sheepAge, sheepSize: sheepSize,)));
      }
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
              color: Colors.black38,
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
