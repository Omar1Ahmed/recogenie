import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recogenie/Features/cart/data/model/cart_model.dart';
import 'package:recogenie/Features/cart/presentation/cart_screen/logic/cart_cubit.dart';
import 'package:recogenie/Features/home/presentation/home_screen/logic/home_cubit.dart';
import 'package:recogenie/core/Responsive/UiComponents/info_widget.dart';
import 'package:recogenie/core/di/injection.dart';
import 'package:recogenie/core/error/result.dart';
import 'package:recogenie/core/helper/AssetsHelper/assets_helper.dart';
import 'package:recogenie/core/helper/cherryToast/cherry_toast_msgs.dart';
import 'package:recogenie/core/helper/extensions.dart';

import '../../../../../core/routing/routs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();

    return InfoWidget(builder: (context, deviceInfo) {
      return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {

      }, builder: (context, state) {
        final cubit = context.read<HomeCubit>();

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            scrolledUnderElevation: 0,
            elevation: 0,
            leading: Icon(Icons.fastfood_outlined,size: deviceInfo.screenWidth * 0.07,),
            leadingWidth: deviceInfo.screenWidth * 0.15,
            title: Text('Recogenie App', style: TextStyle(color: Colors.black,fontSize: deviceInfo.screenWidth * 0.05,fontWeight: FontWeight.bold),),
            actionsPadding: EdgeInsetsDirectional.only(end: deviceInfo.screenWidth * 0.06),
            actions: [

          InkWell(
                child: ValueListenableBuilder<int>(
                  valueListenable: getIt<CartCubit>().totalItemsNotifier,
                  builder: (context, value, child) {
                    return Badge(
                      label: Text(value.toString(),style: TextStyle(color: Colors.white,fontSize: deviceInfo.screenWidth * 0.03,fontWeight: FontWeight.bold),),
                      child: Icon(Icons.shopping_cart_outlined,size: deviceInfo.screenWidth * 0.07,),
                    );
                  }
                ),
                onTap: () => context.pushNamed(Routes.cartScreen),
              )
            ],
          ),

          body: state is HomeLoading ? const Center(child: CircularProgressIndicator(),) :
          Padding(
            padding: EdgeInsetsGeometry.only(top: deviceInfo.screenHeight * 0.02,left: deviceInfo.screenWidth * 0.03,right: deviceInfo.screenWidth * 0.03),
            child: Column(
              children: [
                SizedBox(
                  width:  deviceInfo.screenWidth * 0.85,
                  child: SearchBar(
                    focusNode: focusNode,
                    leading: Icon(Icons.search),
                    hintText: 'Search...',
                    onChanged: cubit.search,
                    trailing: [
                      IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          cubit.clearSearch();
                          focusNode.unfocus();
                        },
                      ),
                    ],
                  ),),
                SizedBox(height: deviceInfo.screenHeight * 0.01,),


                if (state is HomeError)
                  Center(child: Text(state.message, style: const TextStyle(color: Colors.red)))
                else
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsetsGeometry.only(bottom: deviceInfo.screenHeight * 0.02),
                      itemCount: cubit.filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = cubit.filteredItems[index];

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
                                    height: deviceInfo.screenHeight * 0.13,
                                    child: Image.network(
                                      item.imageUrl,
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
                                      height: deviceInfo.screenHeight * 0.12,
                                      width: deviceInfo.screenWidth * 0.53,
                                      padding: EdgeInsetsDirectional.only(start: deviceInfo.screenWidth * 0.02,bottom: deviceInfo.screenHeight * 0.01,top: deviceInfo.screenHeight * 0.01),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                          Text(item.description, overflow: TextOverflow.ellipsis,maxLines: 2,),
                                          Spacer(),
                                          Text("Price: \$${item.price}",style: const TextStyle(fontWeight: FontWeight.bold),),

                                        ],)

                                  ),


                                  ValueListenableBuilder<List<CartModel>>(
                                      valueListenable: getIt<CartCubit>().cartItemsNotifier,
                                      builder: (context, itemsList, child) {
                                        final isInCart = itemsList.any((element) => element.itemId == item.id);

                                        return IconButton(onPressed: () async {

                                    Result result;
                                    if(isInCart){

                                      result = await getIt<CartCubit>().removeItems(itemId: item.id);


                                       if (result is FailureResult){
                                        CherryToastMsgs.showErrorToast(context, 'Error', 'Error removing item', deviceInfo);

                                      }
                                    }else{

                                    result = await getIt<CartCubit>().addItems(itemId: item.id, quantity: 1);

                                    if (result is FailureResult){
                                        CherryToastMsgs.showErrorToast(context, 'Error', 'Error Adding Item', deviceInfo);

                                      }

                                    }

                                    if(result is Success){

                                      setState(() {
                                      });

                                    }

                                  }, icon: Icon(isInCart ? Icons.remove_shopping_cart_outlined : Icons.add_shopping_cart),);
                                      })



                                ]
                            )
                        );
                      },
                    ),
                  ),


              ],
            ),
          ),
        );

      });
    });
  }
}