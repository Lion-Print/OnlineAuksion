import 'package:flutter/material.dart';

import '../resources/colors.dart';
class InfoUsers extends StatefulWidget {
  const InfoUsers({super.key});

  @override
  State<InfoUsers> createState() => _CamPageState();
}

class _CamPageState extends State<InfoUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Row(
        children: [
          Text("Lion",style: TextStyle(color: MyColors.Myorange,
              fontWeight: FontWeight.bold
          ),),
          Text("Print",style: TextStyle(color: MyColors.Mywhite,
              fontWeight: FontWeight.bold
          ),),
        ],
      ),
        backgroundColor: MyColors.Myblue12,),
      body: Container(
        color: MyColors.Mymain1,
        child: Center(
          child: Text("InfoUsers"),
        ),
      ),
    );

  }
}
