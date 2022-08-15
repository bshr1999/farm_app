import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:man/module/bottom_nav_bar/cubit.dart';
import 'package:man/module/bottom_nav_bar/states.dart';
import 'package:man/shared/local/shared_components.dart';

class SubOrder extends StatelessWidget {
  const SubOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavBarCubit,BottomNavBarStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: appBar(
              context: context,
              text: 'ذبيحتك وليمتك'),
          body: NavBarCubit.get(context).showOrdersList.isEmpty?const Center(child: CircularProgressIndicator(color: Colors.amber,)):SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => itemSub(model: NavBarCubit.get(context).showOrdersList[index]),
                    separatorBuilder: (context, index)=> const SizedBox(
                          height: 5,
                        ),
                    itemCount: NavBarCubit.get(context).showOrdersList.length
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget itemSub({required var model})=> Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(model['type']=='product')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(model['data'].name!=null)
                    Text(
                      model['data'].name!,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.amber,
                      ),
                    ),
                  if(model['data'].name!=null)
                    const SizedBox(
                      height: 5,
                    ),
                  if(model['data'].meatType!=null)
                    Row(
                      children: [
                        const Text(
                          'نوع اللحم: ',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          model['data'].meatType!,
                          style: const TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  if(model['data'].meatType!=null)
                    const SizedBox(height: 5.0,),
                  if(model['data'].size!=null)
                    Container(
                      color: Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text(
                              'نوع الطبق: ',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              model['data'].size!,
                              style: const TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if(model['data'].nots!=null)
                    Container(
                      color: Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text(
                              'ملاحظة: ',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              model['data'].nots!,
                              style: const TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if(model['data'].nameMenu!=null)
                    Row(
                      children: [
                        const Text(
                          'قائمة الطبخ: ',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          model['data'].nameMenu!,
                          style: const TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  if(model['data'].nameMenu!=null)
                    const SizedBox(height: 5.0,),
                  if(model['data'].total!=null)
                    Text(
                      'الاجمالي: ${model['data'].total}ر.ق',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.amber,
                      ),
                    ),
                ],
              ),
              if(model['type']=='goat')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(model['data'].type!=null)
                      Text(
                        model['data'].type!,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.amber,
                        ),
                      ),
                    if(model['data'].type!=null)
                      const SizedBox(
                        height: 5,
                      ),
                    if(model['data'].cutType!=null)
                      Row(
                        children: [
                          const Text(
                            'نوع التقطيع: ',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            model['data'].cutType!,
                            style: const TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    if(model['data'].cutType!=null)
                      const SizedBox(height: 5.0,),
                    if(model['data'].size!=null)
                      Container(
                        color: Colors.grey[200],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text(
                                'الحجم: ',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                model['data'].size!,
                                style: const TextStyle(fontSize: 14, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if(model['data'].nots!=null)
                      Container(
                        color: Colors.grey[200],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text(
                                'ملاحظة: ',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                model['data'].nots!,
                                style: const TextStyle(fontSize: 14, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if(model['data'].heavy!=null)
                      Row(
                        children: [
                          const Text(
                            'الوزن: ',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            model['data'].heavy!,
                            style: const TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    if(model['data'].heavy!=null)
                      const SizedBox(height: 5.0,),
                    if(model['data'].total!=null)
                      Text(
                        'الاجمالي: ${model['data'].total}ر.ق',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.amber,
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      );
}
