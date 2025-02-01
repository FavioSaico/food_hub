import 'package:flutter/material.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:food_hub/utils/dimensions.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({super.key, required this.text});

  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
  
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {

  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;

  double textHeight = Dimensions.screenHeight/7.53;

  @override
  void initState() {
    super.initState();
    if(widget.text.length > textHeight){
      firstHalf = widget.text.substring(0,textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt()+1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override 
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hiddenText ? "$firstHalf..." : (firstHalf + secondHalf),
          style: TextStyle(fontSize: Dimensions.font16, height: 1.3, color: Colors.grey[800]),
        ),
        if (secondHalf.isNotEmpty)
          InkWell(
            onTap: () {
              setState(() {
                hiddenText = !hiddenText;
              });
            },
            child: Row(
              children: [
                Text(
                  hiddenText ? "Mostrar más" : "Mostrar menos",
                  style: TextStyle(color: AppColors.mainColor, fontSize: Dimensions.font16),
                ),
                Icon(
                  hiddenText ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                  color: AppColors.mainColor,
                ),
              ],
            ),
          ),
      ],
    );
    
    // Container(
    //   child: secondHalf.isEmpty?SmallText(size: Dimensions.font16, text: firstHalf):Column(
    //     children: [
    //       SmallText(height: 1.8, color: AppColors.paraColor ,size: Dimensions.font16,text: hiddenText?("$firstHalf..."):(firstHalf + secondHalf+"452")),
    //       if (secondHalf.isNotEmpty)
    //         InkWell(
    //           onTap: (){
    //             setState(() {
    //               hiddenText = !hiddenText;
    //             });
    //           },
    //           child: Row(
    //             children: [
    //               SmallText(text: hiddenText?"Mostrar más":"Mostrar menos", color: AppColors.mainColor,),
    //               Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up, color: AppColors.mainColor,)
    //             ],
    //           ),
    //         )
    //     ],
    //   ),
    // );
  }
}

