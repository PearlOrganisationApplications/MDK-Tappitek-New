import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

List<Map> writeData=[
  {'image':'assets/read_nfc.png','title':'Write Data'},
  {'image':'assets/read_nfc.png','title':'Copy Data'},
];
List<Map> data=[
  {'name':'Write a plain text','value': 'Plain/text'},
  {'name':'Map a link','value': 'URL'},
  {'name':'Write SMS','value': 'SMS',},
  {'name':'Write an e-mail','value': 'Email',},
  {'name':'Write a contact','value': 'Contact',},
  {'name':'Write location record','value': 'Location',},
];
List<Map> socialMedia=[
  {'name':'Instagram','value': 'assets/insta.png'},
  {'name':'Facebook','value': 'assets/facebook.png'},
  {'name':'Tiktok','value': 'assets/insta.png',},
  {'name':'LinkedIn','value': 'assets/insta.png',},
  {'name':'Messenger','value': 'assets/insta.png',},
  {'name':'Snapchat','value': 'assets/insta.png',},
  {'name':'Twitter','value': 'assets/insta.png',},
  {'name':'Twitch','value': 'assets/insta.png',},
  {'name':'Youtube','value': 'assets/insta.png',},
  {'name':'VK','value': 'assets/insta.png',},
  {'name':'Clubhouse','value': 'assets/insta.png',},
  {'name':'Qzone','value': 'assets/insta.png',},
];
List<Map> portfolio=[
  {'name':'Babbel','value': 'assets/babbel.png'},
  {'name':'Behance','value': 'assets/babbel.png'},
  {'name':'Dribble','value': 'assets/babbel.png',},
  {'name':'Trovo','value': 'assets/babbel.png',},
  {'name':'What3Words','value': 'assets/babbel.png',},
  {'name':'Kununu','value': 'assets/babbel.png',},
  {'name':'Medium','value': 'assets/babbel.png',},
  {'name':'Pintrest','value': 'assets/babbel.png',},
  {'name':'Quora','value': 'assets/babbel.png',},
  {'name':'Reddit','value': 'assets/babbel.png',},
  {'name':'Tumblr','value': 'assets/babbel.png',},
  {'name':'Vimeo','value': 'assets/babbel.png',},
  {'name':'Freelancer','value': 'assets/babbel.png',},
  {'name':'Fiverr','value': 'assets/babbel.png',},
  {'name':'Upwork','value': 'assets/babbel.png',},
  {'name':'Patreon','value': 'assets/babbel.png',},
  {'name':'Github','value': 'assets/babbel.png',},
  {'name':'Patreon','value': 'assets/babbel.png',},
  {'name':'Xing','value': 'assets/babbel.png',},
  {'name':'Blogger','value': 'assets/babbel.png',},
  {'name':'VSCO','value': 'assets/babbel.png',},
  {'name':'Flickr','value': 'assets/babbel.png',},
];
List<Map> music=[
  {'name':'Mixcloud','value': 'assets/apple_music.png'},
  {'name':'SoundCloud','value': 'assets/apple_music.png'},
  {'name':'Spotify','value': 'assets/apple_music.png',},
  {'name':'Deezer','value': 'assets/apple_music.png',},
  {'name':'Tridal','value': 'assets/apple_music.png',},
  {'name':'Yandex Music','value': 'assets/apple_music.png',},
  {'name':'Apple Music','value': 'assets/apple_music.png',},
];
List<Map> buisness=[
  {'name':'Maps','value': 'assets/tripadvisor.png'},
  {'name':'Tripadvisor','value': 'assets/tripadvisor.png'},
  {'name':'Yelp','value': 'assets/tripadvisor.png',},
  {'name':'Menu','value': 'assets/tripadvisor.png',},
  {'name':'Booking','value': 'assets/tripadvisor.png',},
];
List<Map> more=[
  {'name':'Amazon','value': 'assets/eventbrite.png'},
  {'name':'Calendly','value': 'assets/eventbrite.png'},
  {'name':'Eventbrite','value': 'assets/eventbrite.png',},
  {'name':'Meetup','value': 'assets/eventbrite.png',},
  {'name':'Tinder','value': 'assets/eventbrite.png',},
  {'name':'OnlyFans','value': 'assets/eventbrite.png',},
];
List<Map> appleIphone=[
  {'name':'iPhone 12 Pro Max'},
  {'name':'iPhone 12 Pro'},
  {'name':'iPhone 12 Mini'},
  {'name':'iPhone 12'},
  {'name':'iPhone 11 Pro Max'},
  {'name':'iPhone 11 Pro'},
  {'name':'iPhone 11'},
  {'name':'iPhone XS Max'},
  {'name':'iPhone XS'},
  {'name':'iPhone XR'},
  {'name':'iPhone SE (2020)'},
  {'name':'iPhone 7'},
  {'name':'iPhone 8'},
  {'name':'iPhone X'},

];
List<Map> samsungGalaxy=[
  {'name':'Galaxy S20, S20+, S20 Ultra'},
  {'name':'Galaxy S10, S10, S10e'},
  {'name':'Galaxy S9, S9+'},
  {'name':'Galaxy S8, S8+'},
  {'name':'Galaxy S7, S7 Edge'},
  {'name':'Galaxy S6, S6 Edge'},
  {'name':'Galaxy S5, S6 Edge'},
  {'name':'Galaxy S5, S5 Mini , S5 Neo'},
  {'name':'Galaxy S3, S4'},
];
List<Map> samsungGalaxyNote=[
  {'name':'Note 10, Note 10+'},
  {'name':'Note 9'},
  {'name':'Note 8'},
];
List<Map> HTC=[
  {'name':'U19e, U12+, U12 Life'},
  {'name':'Desire 12, Desire 12s'},
  {'name':'Desire 10 Pro'},
  {'name':'U11, Life, Eyes, +,'},
  {'name':'One M9'},
  {'name':'Exodus 1'},
];
List<Map> Google=[
  {'name':'Pixel 4'},
  {'name':'Pixel 4 XL'},
  {'name':'Pixel 3'},
  {'name':'Pixel 3a'},
  {'name':'Pixel 3a XL'},
  {'name':'Pixel 2'},
  {'name':'Pixel 2 XL'},
  {'name':'Pixel'},
  {'name':'Pixel XL'},
  {'name':'Nexus 5X'},
  {'name':'Nexus 6P'},
  {'name':'Nexus 6'},
];
List<Map> Huawei=[
  {'name':'P30, P30 Pro ,P30 Lite'},
  {'name':'P20 ,P20 Pro ,P20 Lite'},
  {'name':'P10 P10 Plus ,P10 Lite'},
];
List<Map> OnePlus=[
  {'name':'7, 7 Pro'},
  {'name':'6, 6T'},
  {'name':'5 , 5T'},
  {'name':'3, 3T'},
  {'name':'One'},
];
List<Map> samsungGalaxyA=[
  {'name':'2018 models: J4+, J6,J5,J3'},
];
List<Map> LG=[
  {'name':'Q9'},
  {'name':'One'},
  {'name':'G8, G8s ThinQ'},
  {'name':'G3, G4, G5, G6'},
  {'name':'V50, V40'},
  {'name':'V30,V35'},
  {'name':'Q Stylus, Q Stylo 4'},
];
List<Map> Xiaomi=[
  {'name':'Mi Mix'},
  {'name':'Mi Mix2'},
  {'name':'Mi Mix 2s'},
  {'name':'Mi Mix3'},
  {'name':'Mi5, Mi5s, Mi5 Plus'},
  {'name':'Mi6/X, Mi6'},
  {'name':'Mi8, Mi8 Lite ,Mi8 Pro'},
  {'name':'Mi9, Mi9 SE'},
];
List<Map> nokia=[
  {'name':'3, 5, 5.1 6, 6.1'},
  {'name':'7 Plus'},
  {'name':'8, 8.1 8 Sirocco'},
  {'name':'9 PureView'},
];
List<Map> motorola=[
  {'name':'Moto P50'},
  {'name':'Moto X4'},
  {'name':'Moto Z3'},
  {'name':'Moto Z3 Play'},
];
List<Map> sony=[
  {'name':'Xperia XZ1/Compact'},
  {'name':'Xperia 1, 10/Plus'},
  {'name':'Xperia XA1/Ultra/Plus'},
  {'name':'Xperia XZ2/ Compact/Premium'},
  {'name':'Xperia XA2/Ultra/Plus'},
  {'name':'Xperia XZ3'},
];

List<Map> aboutus=[
  {'name':'What is MDK?','value': 'MDK brings to the forefront unprecedented functionality by simplifying social sharing. '
      'MDK effortlessly sticks to your mobile device or comes in the form of a personalized card that helps you share, connect, and '
      'network with other individuals through just a tap! \n\n The other person doesn\'t need an app or a MDK to receive your info 💥 '
      '\n\nMDK on your side, the sky is truly the limit. It can be used by anyone in any industry to share a customized, all-in-one social '
      'profile to people they meet.\n\nIf you don\'t want to share your whole profile, use MDK Direct feature to directly share your Instagram,'
      ' TikTok, Contact card, Snapchat, etc.\n\nMDK can help improve your networking and will leave a lasting impression on everyone you meet.'},
  {'name':'How does this work?','value': 'MDK products contain a smart chip that wirelessly sends your information to the phone. The sharing is'
      ' initiated by a push notification that will appear on the other person\'s phone. If that notification is tapped, your profile will load '
      'in the browser on their phone.\n\nNo app is required for this! Other individual doesn’t need to have an app installed to receive your '
      'information. It’s a win-win situation! MDK boasts compatibility with almost all devices.'},
];
Map<String, IconData> imagemap = {
  "Plain/text": Icons.text_snippet,
  "URL": Icons.web,
  "SMS": Icons.sms,
  "Email": Icons.contact_mail,
  "Contact": Icons.phone_iphone_outlined,
  "Location": Icons.add_location,
};

showsnacbar(BuildContext context, String mesage){
  var snackBar = SnackBar(
    content: Text(mesage),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void launchMap(String address) async {
  String googleUrl = "https://www.google.com/maps/search/?api=1&query=$address";
  String appleUrl = "https://maps.apple.com/?sll=$address";
  if(Platform.isIOS){
    // for iOS phone only
    await launchUrlString(googleUrl);
  }else{
    // android , web
    await launchUrlString(googleUrl);
  }
}

void launchurl(String url) async {
  if(Platform.isIOS){
    // for iOS phone only
    await launchUrlString(url);
  }else{
    // android , web
    await launchUrlString(url);
  }
}

void opengmail(String mail) async {
  var uri = 'mailto:$mail}?subject=""&body=';
  await launchUrlString(uri);
}

void sendtocall(String s) {
  launchUrlString("tel://$s");
}

void sendtosms(String message) async {
  // Android
  var uri = 'sms:""?body=$message';
  if (await canLaunchUrlString(uri)) {
    await launchUrlString(uri);
  } else {
    // iOS
    var uri = 'sms:""?body=$message';
    if (await canLaunchUrlString(uri)) {
      await launchUrlString(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}

