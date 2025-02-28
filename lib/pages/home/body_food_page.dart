import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_hub/domain/food.dart';
import 'package:food_hub/pages/reserva/sedes.dart';
import 'package:food_hub/providers/food_provider.dart';
import 'package:food_hub/pages/food/recommended_food_detail.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/utils/dimensions.dart';
import 'package:food_hub/widgets/app_column.dart';
import 'package:food_hub/widgets/big_text.dart';
import 'package:food_hub/widgets/icon_and_text_widget.dart';
import 'package:food_hub/widgets/small_text.dart';
import 'package:provider/provider.dart';

class BodyFoodPage extends StatefulWidget {
  const BodyFoodPage({super.key});

  @override
  _BodyFoodPageState createState() => _BodyFoodPageState();
}

class _BodyFoodPageState extends State<BodyFoodPage> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
    
    _loadFoods();
  }

  Future<void> _loadFoods() async {
    // cargamos los datos de los platillos
    setState(() => _isLoading = true);
    await Provider.of<FoodProvider>(context, listen: false).getFoods();
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final foodProvider = context.watch<FoodProvider>();

    return _isLoading 
    ? Center(child: CircularProgressIndicator(color: AppColors.mainColor)) 
    : Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Dimensions.pageView,
              child: PageView.builder(
                  controller: pageController,
                  itemCount: 3,
                  itemBuilder: (context, position) {
                    // print(position);
                    final Food food = foodProvider.foodList[position];
                    return _buildPageItem(position, food);
                  }),
            ),
            DotsIndicator(
              dotsCount: 3,
              position: _currentPageValue,
              decorator: DotsDecorator(
                activeColor: AppColors.mainColor,
                size: const Size.square(9.0),
                activeSize: const Size(9.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
        
            //Popular text
            SizedBox(height: Dimensions.height30),
            Container(
              margin: EdgeInsets.only(left: Dimensions.width30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SedesPage(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: Dimensions.width20*2,
                            right: Dimensions.width20*2,
                            top: Dimensions.height10,
                            bottom: Dimensions.height10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(Dimensions.radius15),
                              topRight: Radius.circular(Dimensions.radius15),
                              bottomLeft: Radius.circular(Dimensions.radius15),
                              bottomRight: Radius.circular(Dimensions.radius15),
                            )
                          ),
                          child: BigText(text: "Haz una reserva", color: Colors.white,size:Dimensions.font16),
                        ),
                      ],
                    ),
                  ),
                  BigText(text: "Popular"),
                ],
              ),
            ),
        
            //LISTA DE COMIDAS E IMAGENES
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: foodProvider.foodList.length,
              itemBuilder:(context, index) {
                final product = foodProvider.foodList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        allowSnapshotting: false,
                        builder: (context) => RecommendedFoodDetail(product: product,),
                      ),
                    );
                  },
                  child: Container(
                  margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20, bottom: Dimensions.height10),
                  child: Row(
                    children:[
                      //image section
                      Container(
                        width:Dimensions.listViewImgSize,
                        height: Dimensions.listViewImgSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color:Colors.white38,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              product.imageUrl
                            )
                          )
                        ),
        
                      ),
                      Expanded(
                        child: Container(
                          height: Dimensions.listViewTextContSize,
                          decoration: BoxDecoration(
                            borderRadius:BorderRadius.only(
                              topRight:Radius.circular(Dimensions.radius20),
                              bottomRight: Radius.circular(Dimensions.radius20)
                            ),
                            color: Colors.white,
                          ),
        
                          child: Padding(
                            padding: EdgeInsets.only(left:Dimensions.width10, right: Dimensions.width10),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
        
                              children: [
                                BigText(text: product.name),
                                SizedBox(height:Dimensions.height10,),
                                SmallText(text: "Con Ingredientes naturales", color: Colors.black54,),
                                SizedBox(height:Dimensions.height10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconAndTextWidget(
                                      icon: Icons.set_meal,
                                      text: "${product.typeFood[0]}${product.typeFood.substring(1).toLowerCase()}",
                                      iconColor: AppColors.iconColor1,
                                    ),
                                    IconAndTextWidget(
                                      icon: Icons.delivery_dining_sharp,
                                      text: "20 min",
                                      iconColor: AppColors.iconcolor3,
                                    ),
                                    IconAndTextWidget(
                                      icon: Icons.access_time_rounded,
                                      text: product.time,
                                      iconColor: AppColors.mainColor,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                )
              ));
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildPageItem(int index, Food food) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currentScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else {
      var currentScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(
                left: Dimensions.width10, right: Dimensions.width10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven ? Color(0xff69c5df) : Color(0xFF9294cc),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(food.imageUrl))),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Dimensions.pageViewTextContainer,
                margin: EdgeInsets.only(
                    left: Dimensions.width30,
                    right: Dimensions.width30,
                    bottom: Dimensions.height30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(5, 5),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5, 0),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(5, 0),
                      ),
                    ]),
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height15, left: 15, right: 15),
                  child: AppColumn(text: food.name, tipo: food.typeFood,time:food.time)
                ),
              ))
        ],
      ),
    );
  }
}
