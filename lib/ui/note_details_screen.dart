import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:seventeeth_assignment/utils/all_colors.dart';
import 'package:seventeeth_assignment/utils/all_styles.dart';
import 'package:share_plus/share_plus.dart';

class NoteDetailsScreen extends StatelessWidget {
  const NoteDetailsScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final note =Get.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AllColors.brownColor,
        title: Text("Note Details page",style: AllStyles.titleStyle.copyWith(color: AllColors.whitColor),),
        leading: InkWell(
          onTap: ()=>Get.back(),
          child: Icon(Icons.arrow_back,color: AllColors.whitColor,),
        ),
        actions: [
          SizedBox(width: 10,),
          GestureDetector(
            onTap: (){
             Clipboard.setData(ClipboardData(text: note['description']),);
             Fluttertoast.showToast(msg: "Copied to clipboard");
            },
            child: Icon(Icons.copy,color: AllColors.whitColor,),),
          SizedBox(width: 10,),
          GestureDetector(
            onTap: ()async{
              await Share.share(note["description"]);
            },
            child: Icon(Icons.share,color: AllColors.whitColor,),),
          SizedBox(width: 20,),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(note["title"],style: AllStyles.headingStyle,),
              Text(note["date"],style: AllStyles.subTitle.copyWith(color: AllColors.blckColor.withOpacity(0.6),),),
              SizedBox(height: 10,),
              Text(note["description"],style: AllStyles.titleStyle.copyWith(color: AllColors.blckColor.withOpacity(0.8),),)
            ],
          ),
        ),
      ),
    );
  }
}
