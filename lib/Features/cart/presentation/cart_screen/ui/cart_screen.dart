import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recogenie/Features/cart/presentation/cart_screen/logic/cart_cubit.dart';
import 'package:recogenie/Features/home/data/model/menu_item_model.dart';
import 'package:recogenie/core/Responsive/UiComponents/info_widget.dart';
import 'package:recogenie/core/helper/cherryToast/cherry_toast_msgs.dart';
import '../../../../../core/helper/AssetsHelper/assets_helper.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo) {
      return BlocConsumer<CartCubit, CartState>(
          listener: (context, state){

            if(state is CartClearLoading){
              CherryToastMsgs.showInfoToast(context, 'Cart', 'Uploading Your Cart', deviceInfo);
            }
            if(state is CartError){
              CherryToastMsgs.showErrorToast(context, 'Error', 'Error in Cart', deviceInfo);
            }
          },
          builder: (context, state){
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.transparent,
                scrolledUnderElevation: 0,
                elevation: 0,
                automaticallyImplyLeading: false,
                title: Text("Cart"),
                centerTitle: true,
              ),
              body: state is CartLoading ? const Center(child: CircularProgressIndicator(),) : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  state is CartEmpty ?
                  Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.remove_shopping_cart_outlined,size: deviceInfo.screenWidth * 0.15,),
                            Text('Your Cart is Empty',style: TextStyle(color: Colors.black,fontSize: deviceInfo.screenWidth * 0.05,fontWeight: FontWeight.bold),)]))

                      :Expanded(
                      child: ListView.builder(
                        padding: EdgeInsetsDirectional.only(start: deviceInfo.screenWidth * 0.03,end: deviceInfo.screenWidth * 0.03 ,top: deviceInfo.screenHeight * 0.01,bottom: deviceInfo.screenHeight * 0.01),
                        itemCount: context.watch<CartCubit>().cartItemsDetails.length,
                        itemBuilder: (context, index) {
                          MenuItem cartItem = context.watch<CartCubit>().cartItemsDetails[index];
                          return Card(
                              margin: EdgeInsetsDirectional.only(top: deviceInfo.screenHeight * 0.015),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(deviceInfo.screenWidth * 0.06),side:  BorderSide(color: Colors.black,width: deviceInfo.screenWidth * 0.0004)),
                              elevation: deviceInfo.screenWidth * 0.008,
                              clipBehavior: Clip.antiAlias,
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: deviceInfo.screenWidth * 0.28,
                                      height: deviceInfo.screenHeight * 0.19,
                                      child: Image.network(
                                        cartItem.imageUrl,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return const Icon(Icons.disabled_visible_rounded);
                                        },
                                        loadingBuilder: (context, child, loadingProgress) {
                                          if (loadingProgress == null) return child;

                                          return Center(
                                            child: Image.asset(GifHelper.loadingGif),
                                          );
                                        },
                                      ),



                                    ),

                                    Container(
                                        height: deviceInfo.screenHeight * 0.19,
                                        width: deviceInfo.screenWidth * 0.65,
                                        padding: EdgeInsetsDirectional.only(start: deviceInfo.screenWidth * 0.02,bottom: deviceInfo.screenHeight * 0.01,top: deviceInfo.screenHeight * 0.01),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(cartItem.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                            Text(cartItem.description, overflow: TextOverflow.ellipsis,maxLines: 4,),
                                            Spacer(),

                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [

                                                  Text("Price: \$${cartItem.price}",style: const TextStyle(fontWeight: FontWeight.bold),),

                                                  SizedBox(width: deviceInfo.screenWidth * 0.1),

                                                  IconButton(onPressed: () {
                                                    context.read<CartCubit>().removeQuantity(cartItem.id, cartItem.price);
                                                  }, icon: const Icon(Icons.remove_circle_outline_sharp,color: Colors.red,)),

                                                  Text("${context.watch<CartCubit>().cartItems.firstWhere((e) => e.itemId == cartItem.id).quantity}",style: const TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,),

                                                  IconButton(onPressed: () {
                                                    context.read<CartCubit>().addQuantity(cartItem.id, cartItem.price);
                                                  }, icon: const Icon(Icons.add,color: Colors.green,)),


                                                ]
                                            )
                                          ],)

                                    ),







                                  ]
                              )
                          );
                        },
                      )),

                ],
              ),

              bottomNavigationBar:
              state is CartEmpty ? null : Container(
                margin: EdgeInsetsDirectional.only(start: deviceInfo.screenWidth * 0.03,end: deviceInfo.screenWidth * 0.03 ,top: deviceInfo.screenHeight * 0.01,bottom: deviceInfo.screenHeight * 0.01),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: deviceInfo.screenHeight * 0.05,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total Price: \$${context.watch<CartCubit>().totalPrice.toStringAsFixed(2)}",style: const TextStyle(fontWeight: FontWeight.bold),),
                            Text("Total Items: ${context.watch<CartCubit>().totalItems}",style: const TextStyle(fontWeight: FontWeight.bold),),
                                ])),
                      Spacer(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF009688),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(deviceInfo.screenWidth * 0.06)),
                          ),
                          onPressed: () {

                            if(state is! CartClearLoading){
                              context.read<CartCubit>().clearCart();
                            }

                          }, child: state is CartClearLoading  ? const Text("Uploading Order",style: TextStyle(color: Colors.white)) : const Text("Place Order",style: TextStyle(color: Colors.white),))
                    ]
                ),
              ),
            );
          });
    });
  }
}