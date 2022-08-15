import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:man/module/bottom_nav_bar/cubit.dart';
import 'package:man/module/bottom_nav_bar/states.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavBarCubit,BottomNavBarStates>(
      listener: (context,states){},
      builder: (context,states){
        var cubit=NavBarCubit.get(context);
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.amber,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: cubit.items,
            currentIndex: cubit.index,
            onTap: (int value){
              cubit.changeBarIndex(value);
            },
          ),
          body: cubit.screens[cubit.index],
        );
      },
    );
  }
}
