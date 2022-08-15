import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:man/model/show_my_order.dart';
import 'package:man/module/bottom_nav_bar/cubit.dart';
import 'package:man/module/bottom_nav_bar/states.dart';
import 'package:man/module/sub_order/sub_order.dart';
import 'package:man/shared/local/conest.dart';

import '../../shared/local/shared_components.dart';

class Order extends StatelessWidget {
  const Order({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return BlocConsumer<NavBarCubit,BottomNavBarStates>(
      listener: (context,states){},
      builder:(context,states){
        var cubit=NavBarCubit.get(context);
        return Scaffold(
          appBar: appBar(
              context: context,
              text: 'ذبيحتك وليمتك'),
          body: clint_id==null?const Center(
            child: Text(
              'سجل دخولك اولا',
              style: TextStyle(
                  color: Colors.amber,
                  fontSize: 20
              ),
            ),
          ):cubit.showMyOrder==null?const Center(child: CircularProgressIndicator(color: Colors.amber,)):SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index)=>viewItems(context: context, height: height, width: width, order: cubit.showMyOrder!.data[index]),
                  separatorBuilder: (context,index)=>Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                  itemCount: cubit.showMyOrder!.data.length,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ignore: sized_box_for_whitespace
  Widget viewItems({required context,required ShowMyOrderData order,required double height,required double width})=>InkWell(
    onTap:(){
      NavBarCubit.get(context).addList(order.id!);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const SubOrder()));
    },
    child: SizedBox(
      height: height*.30,
      width: width,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              height: height*.30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'رقم الطلب:',
                    style: Theme.of(context).textTheme.caption
                  ),
                  Text(
                    '${order.id}',
                    style: const TextStyle(
                      color: Colors.amber,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'تاريخ توصيل الطلب:',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              Text(
                                '${order.payState}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            children: [
                              Text(
                                'الوقت:',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              Text(
                                '${order.time}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            children: [
                              Text(
                                'العنوان:',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              Text(
                                '${order.city} / ${order.state} / ${order.street}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'الاجمالي ${order.total} ر.ق',
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 16
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}