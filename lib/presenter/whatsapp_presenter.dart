import 'package:flutter/material.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

class WhatsappPresenter {
  static WhatsappPresenter instance = WhatsappPresenter();

  Future<bool> isWhatsappInstalled() async {
    final isWhatsapp = await WhatsappShare.isInstalled(
      package: Package.whatsapp
    );
    final isBuissnessWhatsapp = await WhatsappShare.isInstalled(
      package: Package.businessWhatsapp
    );
    if(isBuissnessWhatsapp == true || isWhatsapp == true){
      print('Whatsapp is installed');
      return true;
    }
     print('whatsapp is not installed');
     return false;
  } 

  Future<void> shareNoteInWhatsapp({required String title,required String description}) async{
    await WhatsappShare.share(
      phone: '654167566',
      text: '''
      $title

      $description
    ''');
  }

}