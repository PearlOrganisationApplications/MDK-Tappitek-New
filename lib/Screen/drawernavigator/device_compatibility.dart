import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:responsive_flutter/responsive_flutter.dart';

import '../../../utils/configuration.dart';
class DeviceCompatibility extends StatefulWidget {
  const DeviceCompatibility({Key? key}) : super(key: key);

  @override
  State<DeviceCompatibility> createState() => _DeviceCompatibilityState();
}

class _DeviceCompatibilityState extends State<DeviceCompatibility> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints)
      {
        return Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: AlwaysScrollableScrollPhysics(),
            // physics: ScrollPhysics(),
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: constraints.maxHeight*0.02),
                    width: constraints.maxWidth,
                    child: Text('DEVICES COMPATIBILITY\n LIST',style: GoogleFonts.montserrat(fontSize:25),textAlign: TextAlign.center,)),

                Container(
                  margin: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.03),
                  width: constraints.maxWidth,
                  height: constraints.maxHeight*0.005,
                  decoration: BoxDecoration(
                      color: Colors.blue
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: constraints.maxHeight*0.02),
                    width: constraints.maxWidth,
                    child: Text('Tapitek uses technology that is compatible with most newer iPhone and Android devices.',style: GoogleFonts.montserrat(fontSize:32),textAlign: TextAlign.center,)),

                Container(
                    margin: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.03),

                    width: constraints.maxWidth,
                    child: Text('Some Android phones might have NFC turned off. If your Tapitek is not working on android devices , search for NFC and make sure it is turned on',style: GoogleFonts.montserrat(fontSize:20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),

                getText('Apple (iPhone)',constraints),
                const SizedBox(height: 20,),
                getList(appleIphone,constraints),
                getText('Samsung Galaxy S',constraints),
                const SizedBox(height: 20,),
                getList(samsungGalaxy,constraints),
                getText('Samsung Galaxy Note',constraints),
                const SizedBox(height: 20,),
                getList(samsungGalaxyNote,constraints),
                getText('HTC',constraints),
                const SizedBox(height: 20,),
                getList(HTC,constraints),
                getText('Google',constraints),
                const SizedBox(height: 20,),
                getList(Huawei,constraints),
                getText('One Plus',constraints),
                const SizedBox(height: 20,),
                getList(OnePlus,constraints),
                getText('Samsung Galaxy A',constraints),
                const SizedBox(height: 20,),
                getList(samsungGalaxyA,constraints),
                getText('LG',constraints),
                const SizedBox(height: 20,),
                getList(LG,constraints),
                getText('Xiaomi',constraints),
                const SizedBox(height: 20,),
                getList(Xiaomi,constraints),
                getText('Nokia',constraints),
                const SizedBox(height: 20,),
                getList(nokia,constraints),
                getText('Motorola',constraints),
                const SizedBox(height: 20,),
                getList(motorola,constraints),
                getText('Sony',constraints),
                const SizedBox(height: 20,),
                getList(sony,constraints),
                Container(
                  margin: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.03,bottom: constraints.maxHeight*0.15),
                  width: constraints.maxWidth,
                  height: constraints.maxHeight*0.005,
                  decoration: BoxDecoration(
                      color: Colors.blue
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget getText(String s,BoxConstraints constraints)
  {
    return Container(
        margin: EdgeInsets.only(left: constraints.maxWidth*0.05,right: constraints.maxWidth*0.05,top: constraints.maxHeight*0.03),

        width: constraints.maxWidth,
        child: Text(s,style: GoogleFonts.montserrat(fontSize:26,fontWeight: FontWeight.bold),textAlign: TextAlign.center,));
  }

  Widget getList(List<Map> appleIphone, BoxConstraints constraints)
  {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: appleIphone.length,
        itemBuilder: (context,index)
        {
          return Container(
              width: constraints.maxWidth,
              child: Column(
                children: [
                  Text(appleIphone[index]['name'].toString(),textAlign: TextAlign.center,),
                  SizedBox(height: 10,),
                ],
              ));
        });
  }
}
