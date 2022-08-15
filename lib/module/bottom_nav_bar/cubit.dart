import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:man/model/categories_cart.dart';
import 'package:man/model/goat_buy_model.dart';
import 'package:man/model/goat_img_model.dart';
import 'package:man/model/login_model.dart';
import 'package:man/model/menu_model.dart';
import 'package:man/model/menu_sub_model.dart';
import 'package:man/model/name_menu_model.dart';
import 'package:man/model/product_details.dart';
import 'package:man/model/product_model.dart';
import 'package:man/model/product_sub_model.dart';
import 'package:man/model/sheep_cart.dart';
import 'package:man/model/show_farm.dart';
import 'package:man/model/show_goat.dart';
import 'package:man/model/show_goat_info.dart';
import 'package:man/model/show_goat_sub_order.dart';
import 'package:man/model/show_my_order.dart';
import 'package:man/model/show_product_sub.dart';
import 'package:man/model/sms_code.dart';
import 'package:man/module/bottom_nav_bar/states.dart';
import 'package:man/module/cart/cart.dart';
import 'package:man/module/home/home.dart';
import 'package:man/module/order/order.dart';
import 'package:man/module/profile/profile.dart';
import 'package:man/shared/local/conest.dart';
import 'package:man/shared/network/dio.dart';

class NavBarCubit extends Cubit<BottomNavBarStates>{
  NavBarCubit() : super(BottomNavBarInitialStates());

  static NavBarCubit get(context)=>BlocProvider.of(context);

  List<Widget>screens=[
    const Home(),
    Cart(),
    const Order(),
    Profile(),
  ];

  List<dynamic> drinks=[];
  String stringDrink='';




  List<BottomNavigationBarItem>items=[
    const BottomNavigationBarItem(
      label: 'الرئيسية',
      icon: Icon(
        Icons.home_outlined,
      ),
    ),
    const BottomNavigationBarItem(
      label: 'السلة',
      icon: Icon(
        Icons.shopping_cart_outlined,
      ),
    ),
    const BottomNavigationBarItem(
      label: 'طلباتي',
      icon: Icon(
        Icons.card_travel,
      ),
    ),
    const BottomNavigationBarItem(
      label: 'الملف',
      icon: Icon(
        Icons.person_outline,
      ),
    ),
  ];

  int index=0;
  void changeBarIndex(int index){
    this.index=index;
    emit(BarIndex());
    if(index==2){
      getShowMyOrder();
    }
    if(index==1){
      firstPriceCart();
    }
  }

  String? pickedTime;
  void timerVal(time){
    pickedTime="${time.hour} : ${time.minute}";
    emit(TimePickerStates());
  }

  String? pickedDate;
  void dateVal(date){
    pickedDate="${date.day} : ${date.month} : ${date.year}";
    emit(DatePickerStates());
  }

  bool addressBool=false;
  void boxCheck(value){
    addressBool=value;
    emit(CheckBoxStates());
  }

  bool one=true;
  bool two=false;
  double totalPrice=0;

  void quantityBool({required bool one,required bool two}){
    this.one=one;
    this.two=two;
   if(one){
     count=1;
   }else if(two){
     count=2;
   }
    totalPrice=price*count;
    emit(SumPriceStates());
  }

  double price=0;
  bool oneVol=false;
  bool twoVol=true;
  bool threeVol=false;
  void volumeBool({required bool oneVol,required bool twoVol,required bool threeVol,required double price,required firstC}){
    this.oneVol=oneVol;
    this.twoVol=twoVol;
    this.threeVol=threeVol;
    if(oneVol||twoVol||threeVol){
      this.price=price;
      if(firstC != null){
        totalPrice=price;
      }
      totalPrice=count*price;
      // sum(price: price);
    }else{
    totalPrice=0;
    this.price=0;
    }
    emit(VolumeStates());
  }

  void sum({required double price}){

    totalPrice=price;
    if(two){
      totalPrice=totalPrice*2;
      count=2;
    }else if(one){
      totalPrice=price;
      count=1;
    }
  }

  int count=1;
  void countPlus(){
    count++;
    totalPrice=count*price;
    emit(SumPriceStates());
  }

  void countMin(){
    if(count>1){
      count--;
      totalPrice=count*price;
      emit(CounterState());
    }
  }

  bool oneMeet=true;
  bool twoMeet=false;
  int countMeet=1;
  double priceMeet=0;
  void meetBool({required bool one,required bool two,required double price}){
    oneMeet=one;
    twoMeet=two;
    priceMeet=price;
    if(one){
      countMeet=1;
    }else if(two){
      countMeet=2;
    }
    totalMeetPrice=price*countMeet;
    emit(MeetStates());
  }
  void countMeetPlus({required double price}){
    countMeet++;
    totalMeetPrice=countMeet*price;
    emit(PriceMeetPlusState());
  }

  void countMeetMin({required double price}){
    if(countMeet>3){
      countMeet--;
      totalMeetPrice=countMeet*price;
      emit(PriceMeetMinState());
    }
  }

  int? boolIndex;
  double priceSheep=0;
  void sheepBool({required int index}){
    if(boolIndex==index){
      priceSheep=0;
      boolIndex=null;
    }else {
      boolIndex = index;
      priceSheep=double.parse(showGoatInfoModel!.data[index].price!);
    }
    emit(SheepStates());
  }

  ProductModel? productModel;
  void getProduct()async{
    await DioHelper.getData(
      headers: {},
      url: '${url}show_dept',
    ).then((value){
      productModel=ProductModel.fromJson(value.data);
      log(value.data.toString());
      emit(GetProductStates());
    }).catchError((error){
      log(error.toString());
    });
  }

  ProductSubModel? productSubModel;
  ProductSubModel? kitchenSubModel;
  void getProductSub({required int id,required bool kit})async {
    await DioHelper.getData(
      headers: {},
      url: '${url}show_supdept/$id',
    ).then((value){
      if(kit==false) {
        productSubModel=ProductSubModel.fromJson(value.data);
      }else{
        kitchenSubModel=ProductSubModel.fromJson(value.data);
      }
      log(value.data.toString());
      emit(GetProductSubStates());
    }).catchError((error){
      log(error.toString());
    });
  }

  ShowFarmModel? showFarmModel;
  void getShowFarm({required int id})async {
    log(id.toString());
    await DioHelper.getData(
      headers: {},
      url: '${url}show_farm?id=$id',
    ).then((value){
      showFarmModel=ShowFarmModel.fromJson(value.data);
      log(value.data.toString());
      emit(ShowFarmStates());
    }).catchError((error){
      log(error.toString());
    });
  }

  ShowGoatModel? showGoatModel;
  void getShowGoat({required int id})async {
    log(id.toString());
    await DioHelper.getData(
      headers: {},
      url: '${url}show_goat?id=$id',
    ).then((value){
      showGoatModel=ShowGoatModel.fromJson(value.data);
      log(value.data.toString());
      emit(ShowGoatStates());
    }).catchError((error){
      log(error.toString());
    });
  }

  ShowGoatInfoModel? showGoatInfoModel;
  void getShowGoatInfo({required int id})async {
    log(id.toString());
    await DioHelper.getData(
      headers: {},
      url: '${url}show_info_goat?id=$id',
    ).then((value){
      showGoatInfoModel=ShowGoatInfoModel.fromJson(value.data);
      log(value.data.toString());
      emit(ShowGoatInfoStates());
    }).catchError((error){
      log(error.toString());
    });
  }

  GoatImgModel? goatImgModel;
  void getGoatImg({required int id})async {
    log(id.toString());
    await DioHelper.getData(
      headers: {},
      url: '${url}show_goat_img?id=$id',
    ).then((value){
      goatImgModel=GoatImgModel.fromJson(value.data);
      log(value.data.toString());
      emit(GoatImgStates());
    }).catchError((error){
      log(error.toString());
    });
  }

  GoatBuyDetailsModel? goatBuyDetailsModel;
  void getGoatBuyDet({required int id})async {
    log(id.toString());
    await DioHelper.getData(
      headers: {},
      url: '${url}show_descrption_order?id=$id',
    ).then((value){
      goatBuyDetailsModel=GoatBuyDetailsModel.fromJson(value.data);
      log(value.data.toString());
      emit(GoatBuyStates());
    }).catchError((error){
      log(error.toString());
    });
  }

  int? indexBuyGoat;
  double sheepSum=0;
  void boolChekBuyGoat(int value){
    if(indexBuyGoat==value){
      sheepSum=0;
      indexBuyGoat=null;
    }else{
      indexBuyGoat=value;
      sheepSum=double.parse(goatBuyDetailsModel!.data[value].price!);
    }
    emit(CheckBuyStates());
  }


  ProductDetailsModel? productDetailsModel;
  void getProductDetails({required int id})async {
    log(id.toString());
    await DioHelper.getData(
      headers: {},
      url: '${url}show_product?id=$id',
    ).then((value){
      productDetailsModel=ProductDetailsModel.fromJson(value.data);
      log(value.data.toString());
      emit(ProductDetailsStates());
    }).catchError((error){
      log(error.toString());
    });
  }
  double totalMeetPrice=0;

  List<MenuSubModel> last=[];
  MenuModel? menuModel;
  Future<void> getMenu()async {
    await DioHelper.getData(
      headers: {},
      url: '${url}show_menue',
    ).then((value){
      menuModel=MenuModel.fromJson(value.data);
      log(value.data.toString());
      emit(GetMenuState());
    }).catchError((error){
      log(error.toString());
    });
  }

  ShowMyOrder? showMyOrder;
  Future<void> getShowMyOrder()async {
    await DioHelper.getData(
      headers: {},
      url: '${url}show_my_orders?user_id=$clint_id',
    ).then((value){
      showMyOrder=ShowMyOrder.fromJson(value.data);
      log(value.data.toString());
      emit(GetShowMyOrder());
    }).catchError((error){
      log(error.toString());
    });
  }


  List<Map<String,dynamic>> showOrdersList=[];

  void addList(int id)async{
    showOrdersList=[];
    await showProductSub(id: id);
    for(int i=0;i<showProductSubOrder!.data.length;++i){
      showOrdersList.add(
        {
          'data':showProductSubOrder!.data[i],
          'type':'product'
        }
      );
    }
    log(showOrdersList.toString());
    await showGoatSub(id: id);
    for(int i=0;i<showGoatSubOrder!.data.length;++i){
      showOrdersList.add({
        'data':showGoatSubOrder!.data[i],
        'type':'goat'
      });
    }
    emit(OrderListStates());
  }

  ShowProductSubOrder? showProductSubOrder;
  Future<void> showProductSub({required int id})async {
    await DioHelper.getData(
      headers: {},
      url: '${url}show_myorder_product?id=$id',
    ).then((value){
      showProductSubOrder=ShowProductSubOrder.fromJson(value.data);
      log(value.data.toString());
      emit(ShowProductSubOrderStates());
    }).catchError((error){
      log(error.toString());
    });
  }

  ShowGoatSubOrder? showGoatSubOrder;
  Future<void> showGoatSub({required int id})async {
    await DioHelper.getData(
      headers: {},
      url: '${url}show_myorder_goat?id=$id',
    ).then((value){
      showGoatSubOrder=ShowGoatSubOrder.fromJson(value.data);
      log(value.data.toString());
      emit(ShowGoatSubOrderStates());
    }).catchError((error){
      log(error.toString());
    });
  }



  List<MenuSubModel> data=[];
  List<String>name=[];
  MenuSubModel? menuSubModel;
  NameMenuModel? nameMenuModel;
  List<NameMenuModel>names=[];
  Future<void> getMenuSub({required int id})async {
    await DioHelper.getData(
      headers: {},
      url: '${url}show_sub_menue?id=$id',
    ).then((value){
      menuSubModel=MenuSubModel.fromJson(value.data);
      log(value.data.toString());
      emit(GetMenuSubState());
    }).catchError((error){
      log(error.toString());
    });
  }

  Future<void> postDataInfo({required String phone_no,required String? city,required String? street,required double total,required String? apartment,required date,required time,required String cut_type})async {
    await DioHelper.postData(
      headers: {},
      url: '${url}add_order',
      data: {
        'phone_no':phone_no,
        'city':city,
        'street':street,
        'apartment':apartment,
        'date':date,
        'time':time,
        'total':total,
        'clint_id':clint_id,
        'cut_type':cut_type,
      },
    ).then((value){
      log('ggggggggggggggggggg');
      log(value.data.toString());
      emit(infoState());
    }).catchError((error){
      log(error.toString());
    });
  }

  Future<void> addOrderCatPost({required CategoriesCart cat})async {
    await DioHelper.postData(
      headers: {},
      url: '${url}add_item_order',
      data: {
        'clint_id':clint_id,
        'size':cat.size,
        'price':cat.price,
        'quantity':cat.quantity,
        'nots':cat.nots,
        'name_menu':cat.name_menu,
        'total':cat.total,
        'product_id':cat.product_id
      },
      ).then((value){
      log(value.data.toString());
      emit(AddOrderCatState());
    }).catchError((error){
      log(error.toString());
    });
  }

  Future<void> addOrderSheepPost({required SheepCart sheep})async {
    await DioHelper.postData(
      headers: {},
      url: '${url}add_item_order',
      data: {
        'clint_id':clint_id,
        //'cut_type':sheep.cut_type,
        'info_goat_id':sheep.info_goat_id,
        'goat_id':sheep.goat_id,
        'nots':sheep.nots,
        'desc_id':sheep.desc_id,
        'price':sheep.price,
        'quantity':sheep.quantity,
        'total':sheep.total,
      },
    ).then((value){
      log('sheep');
      log(value.data.toString());
      emit(AddOrderCatState());
    }).catchError((error){
      log(error.response.toString());
    });
  }
  List<dynamic>cart=[];

  void increaseQuantityCart(int index){
    cart[index].quantity++;
    changePriceItem(index);
  }

  void minQuantityCart(int index){
    if(cart[index].quantity>1) {
      cart[index].quantity--;
      changePriceItem(index);
      // emit(CartQuantityState());
    }
  }

  void deleteItemCart({required int index}){
    cart.removeAt(index);
    firstPriceCart();
  }

  double? totalCartPrice;
  void firstPriceCart(){
    totalCartPrice=0;
    for(int i=0;i<cart.length;i++)
    {
      totalCartPrice = totalCartPrice! + cart[i].total;
    }
    emit(FirstPriceCartStates());
  }
  void changePriceItem(int index){
    cart[index].total=cart[index].quantity*cart[index].price;
    totalCartPrice=0;
    for(int i=0;i<cart.length;i++)
    {
      totalCartPrice = totalCartPrice! + cart[i].total;
    }
    emit(CartQuantityState());
  }

  void acceptCart(){
    cart.clear();
    toast(text: 'تم اتمام الطلب بنجاح', state: ToastState.SUCCESS);

    emit(AcceptClearCartState());
  }

  Future<void> getShowSubOrder({required int id})async {
    await DioHelper.getData(
      headers: {},
      url: '${url}show_my_sub_orders?id=$id',
    ).then((value){
      menuSubModel=MenuSubModel.fromJson(value.data);
      log(value.data.toString());
      emit(GetMenuSubState());
    }).catchError((error){
      log(error.toString());
    });
  }
}