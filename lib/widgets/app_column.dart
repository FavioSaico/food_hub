
import 'package:flutter/material.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/utils/dimensions.dart';
import 'package:food_hub/widgets/big_text.dart';
import 'package:food_hub/widgets/icon_and_text_widget.dart';
import 'package:food_hub/widgets/small_text.dart';

class AppColumn extends StatelessWidget {

  final String text;
  const AppColumn ({ 
    Key? key,
    required this.text
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text, size: Dimensions.font26),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          children: [
            Wrap(children: [
              SmallText(
                text: "Plato tradicional infaltable del verano.",
                color: Colors.black54,
              )
            ])
          ],
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
              icon: Icons.set_meal,
              text: "Fondo",
              iconColor: AppColors.iconColor1,
            ),
            IconAndTextWidget(
              icon: Icons.delivery_dining_sharp,
              text: "20 min",
              iconColor: AppColors.iconcolor3,
            ),
            IconAndTextWidget(
              icon: Icons.access_time_rounded,
              text: "15 min",
              iconColor: AppColors.mainColor,
            ),
          ],
        )
      ],
    );
  }
}


