import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:man/model/product_sub_model.dart';
import 'package:man/model/show_farm.dart';
import 'package:man/model/show_goat.dart';
import 'package:man/module/bottom_nav_bar/cubit.dart';
import 'package:man/module/bottom_nav_bar/states.dart';
import 'package:man/module/kitchen/kitchen.dart';
import 'package:man/module/meet/meet.dart';
import 'package:man/module/sheep/sheep.dart';
import 'package:man/shared/local/conest.dart';
import 'package:man/shared/local/shared_components.dart';

// ignore: must_be_immutable
class ItemTypeFarm extends StatelessWidget {
  ProductSubData? productSubData;
  ShowFarmData? showFarmData;
  ItemTypeFarm({this.productSubData,this.showFarmData,Key? key}) : super(key: key);
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
            body: NavBarCubit.get(context).showGoatModel==null?const Center(child: CircularProgressIndicator(color: Colors.amber,)):SingleChildScrollView(
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
                        const Padding(
                          padding: EdgeInsets.only(bottom: 30,right: 10),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'المزارع',
                              style: TextStyle(
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
                  if(showFarmData!=null)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'الأغنام/ الخرفان المتوافرة',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
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
                      children: List.generate(NavBarCubit.get(context).showGoatModel!.data.length, (index) => gridItem(width: width, context: context, model: NavBarCubit.get(context).showGoatModel!.data[index])),
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


  Widget gridItem({required context,required double width,required ShowGoatData model})=>InkWell(
    onTap:(){
      NavBarCubit.get(context).showGoatInfoModel=null;
      NavBarCubit.get(context).getShowGoatInfo(id: model.id!);
      NavBarCubit.get(context).goatImgModel=null;
      NavBarCubit.get(context).getGoatImg(id: model.id!);
      NavBarCubit.get(context).goatBuyDetailsModel=null;
      NavBarCubit.get(context).getGoatBuyDet(id: model.id!);
      NavBarCubit.get(context).indexBuyGoat=null;
      NavBarCubit.get(context).boolIndex=null;
      NavBarCubit.get(context).priceSheep=0;
      NavBarCubit.get(context).sheepSum=0;
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Sheep(showGoatData: model, name: model.type,)));
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'النوع: ',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          model.type!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
