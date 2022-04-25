import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskapp/services/notification_services.dart';
import 'package:taskapp/services/theme_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notifyHelper;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          Text("Tema verisi",
            style: TextStyle(
              fontSize: 30,

            ),
          ),
        ],
      ),
    );
  }

  _appBar(){
    return AppBar(
      leading: GestureDetector(
        onTap: (){
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
            title: "Tema Değişti",
            body: Get.isDarkMode?"Açık tema aktif edildi":"Koyu tema aktif edildi"
          );


          notifyHelper.scheduledNotification();


        },
        child: Icon(Icons.nightlight_round,
        size: 20,),
      ),
      actions: [
        Icon(Icons.person,
        size: 20,),
        SizedBox(width: 20,),
      ],
    );
  }

}
