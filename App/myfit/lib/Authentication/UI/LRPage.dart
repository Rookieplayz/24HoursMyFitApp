import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:twenty_four_hours/Authentication/Model/Register.dart';
import 'package:twenty_four_hours/Authentication/UI/LoginPage.dart';
import 'package:twenty_four_hours/Authentication/UI/RegisterPage.dart';
import 'package:twenty_four_hours/Widgets-Assets/24HColors.dart';

class LRPage extends StatefulWidget
{
   final VoidCallback onSignedIn;
   LRPage({this.onSignedIn});
  LRPageState createState()=>LRPageState();
}
class LRPageState extends State<LRPage>
{
  String _theme="Dark";
  final VoidCallback onSignedIn;
   LRPageState({this.onSignedIn});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child:Scaffold(
          appBar: AppBar(
            actions:<Widget>[Row(
              children:<Widget>[
                Text(_theme),
              Switch(
              value: false,
              onChanged: (type){if(type){setState(() {
                              _theme="Light";

                            });}},
            )])],
            backgroundColor: HColors.mainscreenDark,
            bottom: TabBar(
              tabs:[
                Tab(icon: Icon(FontAwesomeIcons.signInAlt),text: "LOGIN",),
                Tab(icon: Icon(FontAwesomeIcons.edit),text: "REGISTER",),
                
              ]
            ),
            title: Text("Welcome to 24-Hours"),
          ),
          body: TabBarView(
            children: <Widget>[
               new ListView(children:<Widget>[
                LoginPage(
                        passwordKey: _passwordKey,
                        users: _usernamees,
                        emails: _emails,

                      )]),
              new Card(
                color:HColors.midnight_main,
                child: Column(
                  children: <Widget>[
                    //flare(register),
                   new RegisterPage(
                     countries:[
                        'Afghanistan: 93',
                        'Albania: 355',
                        'Algeria: 213',
                        'Andorra: 376',
                        'Anguila: 1-264',
                        'Antarctica: 672',
                        'Antigua: 1-268',
                        'Barbuda: 1-268',
                        'Argentina: 54',
                        'Armenia: 374',
                        'Aruba: 297',
                        'Australia: 61',
                        'Austria: 43',
                        'Azerbaijan: 994',
                        'Bahamas: 1-242',
                        'Bahrain: 973',
                        'Bangladesh: 880',
                        'Barbados: 1-246',
                        'Barbuda: 1-268',
                        'Belarus: 375',
                        'Belgium: 32',
                        'Belize: 501',
                        'Benin: 229',
                        'Bermuda: 1-441',
                        'Bhutan: 975',
                        'Boliva: 591',
                        'Bosnia: 387',
                        'Botswana: 267',
                        'Brazil: 55',
                        'BIOT: 246',
                        'BVI: 1-284',
                        'Brunei: 673',
                        'Bulgaria: 359',
                        'Burkina: 226',
                        'Burundi: 257',
                        'Columbia: 855',
                        'Cameroon: 237',
                        'Canada: 1',
                        'Cape Verde: 238',
                        'Cayman Islands: 1-348',
                        'Central African Rep: 236',
                        'Chad: 235',
                        'Chile: 56',
                        'China: 86',
                        'Christmas Island: 61',
                        'Cocos Islands: 61',
                        'Colombia: 57',
                        'Comoros: 269',
                        'Cook Islands: 682',
                        'Costa Rica: 506',
                        'Crotia: 385',
                        'Cuba: 53',
                        'Curacao: 599',
                        'Cyprus: 357',
                        'Czech Republic: 420',
                        'Denmark: 45',
                        'Djibouti: 253',
                        'Dominica: 1-767',
                        'Dominican Republic: 1-809',
                        'Dominican Republic: 1-829',
                        'Dominican Republic: 1-849',
                        'East Timor: 670',
                        'Ecuador: 593',
                        'Egypt: 20',
                        'El Salvador: 503',
                        'Equatorial Guinea: 240',
                        'Eritrea: 291',
                        'Ethiopia: 251',
                        'Falkland Islands: 500',
                        'Faroe Islands: 298',
                        'Fiji: 679',
                        'Finland: 358',
                        'France: 33',
                        'French Polynesia: 689',
                        'Gabon: 241',
                        'Gambia: 220',
                        'Georgia: 995',
                        'Germany: 49',
                        'Ghana: 233',
                        'Gibraltar: 350',
                        'Greece: 30',
                        'Greenland: 299',
                        'Grenada: 1-473',
                        'Guam: 1-671',
                        'Guatemala: 502',
                        'Guernsey: 44-1481',
                        'Guinea: 224',
                        'Guinea-Bissau: 245',
                        'Guyana: 592',
                        'Haiti: 509',
                        'Herzegonia: 387',
                        'Honduras: 504',
                        'Hong Kong: 852',
                        'Hungary: 36',
                        'Iceland: 354',
                        'India: 91',
                        'Indonesia: 62',
                        'Iran: 98',
                        'Iraq: 964',
                        'Ireland: 353',
                        'Isle of Man: 44-1624',
                        'Israel: 972',
                        'Italy: 39',
                        'Ivory Coast: 225',
                        'Jamaica: 1-876',
                        'Japan: 81',
                        'Jersey: 44-1534',
                        'Jordan: 962',
                        'Kazakhstan: 7',
                        'Kenya: 254',
                        'Kiribati: 686',
                        'Kosovo: 383',
                        'Kuwait: 965',
                        'Kyrgyzstan: 996',
                        'Laos: 856',
                        'Latvia: 371',
                        'Lebanon: 961',
                        'Lesotho: 266',
                        'Liberia: 231',
                        'Libya: 218',
                        'Liechtenstein: 423',
                        'Lithuania: 370',
                        'Luxembourg: 352',
                        'Macau: 853',
                        'Macedonia: 389',
                        'Madascar: 261',
                        'Malawi: 265',
                        'Malaysia: 60',
                        'Maldives: 960',
                        'Mali: 223',
                        'Malta: 356',
                        'Marshall Islands: 692',
                        'Mauritius: 230',
                        'Mayotte: 262',
                        'Mexico: 52',
                        'Micronesia: 691',
                        'Moldowa: 373',
                        'Monaco: 377',
                        'Mongolia: 976',
                        'Montenegro: 382',
                        'Monsterrat: 1-664',
                        'Morocco: 212',
                        'Mozambique: 258',
                        'Myanmar: 95',
                        'Namibia: 264',
                        'Nauru: 674',
                        'Nepal: 977',
                        'Netherlands: 31',
                        'Netherlands Antilles: 599',
                        'New Caledonia: 687',
                        'New Guinea: 675',
                        'New Zealand: 64',
                        'Nicaragua:505',
                        'Niger: 227',
                        'Nigeria: 234',
                        'Niue: 683',
                        'North Korea: 850',
                        'N Mariana Islands: 1-670',
                        'Norway: 47',
                        'Oman: 968',
                        'Pakistan: 92',
                        'Palau: 680',
                        'Palestine: 970',
                        'Panama: 507',
                        'Paraguay: 595',
                        'Peru: 51',
                        'Philippines: 63',
                        'Pitcairn: 64',
                        'Poland: 48',
                        'Portugal: 351',
                        'Puerto Rico: 1-787',
                        'Puerto Rico: 1-939',
                        'Qatar: 974',
                        'Republic of Congo: 243',
                        'Reunion: 262',
                        'Romania: 40',
                        'Russia: 7',
                        'Rwanda: 250',
                        'Saint Barthelemy: 590',
                        'Saint Helena: 290',
                        'Saint K.N: 1-869',
                        'Saint Lucia: 1-758',
                        'Saint Martin: 590',
                        'Saint P.M: 508',
                        'Saint Vincent: 1-784',
                        'Samoa: 685',
                        'San Marino: 378',
                        'Sao Tome and Principe: 239',
                        'Saudi Arabia: 966',
                        'Senegal: 221',
                        'Serbia: 381',
                        'Seychelles: 248',
                        'Sierra Leone: 232',
                        'Singapore: 65',
                        'Sint Maarten: 1-721',
                        'Slovakia: 421',
                        'Slovenia: 386',
                        'Solomon Islands: 677',
                        'Somalia: 252',
                        'South Africa: 27',
                        'South Korea: 82',
                        'South Sudan: 211',
                        'Spain: 34',
                        'Sri lanka: 94',
                        'Sudan: 249',
                        'Suriname: 579',
                        'Svalbard and Jan Mayen: 47',
                        'Swaziland: 268',
                        'Sweden: 46',
                        'Switzerland: 41',
                        'Syria: 963',
                        'Taiwan: 886',
                        'Tajikistan: 992',
                        'Tanzania: 255',
                        'Thailand: 66',
                        'Togo: 228',
                        'Tokelau: 690',
                        'Tonga: 676',
                        'Trinidad and Tobago: 1-868',
                        'Tunisia: 216',
                        'Turkey: 90',
                        'Turkmenistan: 993',
                        'TCA: 1-649',
                        'Tuvalu: 688',
                        'U.S Virgin Islands: 1-340',
                        'Uganda: 256',
                        'Ukraine: 380',
                        'United Arab Emirates: 971',
                        'UK: 44',
                        'USA: 1',
                        'Uruguay: 598',
                        'Uzbekistan: 998',
                        'Vanuatu: 678',
                        'Vatican: 379',
                        'Venezuela: 58',
                        'Vietnam: 84',
                        'Wallis and Futuna: 681',
                        'Western Sahara: 212',
                        'Yemen: 967',
                        'Zambia: 260',
                        'Zimbabwe: 263'
                        ],
                     Fauth: Fauth,uids: uids,userInfo: userInfo,userInfos:userInfos,UID: UID,reference: reference),
                  ],
                )
              )
            ],
          ),
          backgroundColor: HColors.mainscreenDark,
        )
      )
    );
  }
 List<String> _usernamees = [];
  List<String> _emails = [];
  bool enableButton = false;
  int emptyFields = 2;
  static var ub_color = HColors.midnightAccent;
  static var usernameIcon = new Icon(
    Icons.person_outline,
    color: Colors.white,
  );
  var passwordIcon = new Icon(
    Icons.lock,
    color: Colors.orange,
  );

  var myController;
  static TextEditingController _controller = new TextEditingController();
  TextEditingController _controller2 = new TextEditingController();

  var usernameForm;
  FocusNode _textFocus = new FocusNode();

  bool _obsecureText = true;

  var _passwordKey;

  // Login login=new Login();
  populateLists() {
    print('here');
    for (Register users in userInfos) {
      _usernamees.add(users.username.toLowerCase());
      if(!_emails.contains(users.email))
      _emails.add(users.email.toLowerCase());
      print(_emails);
    }
  }

  FirebaseUser user;
  FirebaseAuth Fauth;
  List<UIDs> uids = [];
  Register userInfo;
  List<Register> userInfos = List();
  String UID = '';
  DatabaseReference reference;

  _onEntryAdded(Event event) {
    setState(() {
      Register r=new Register.fromSnapshot(event.snapshot);
      userInfos.add(r);
       _usernamees.add(r.username.toLowerCase());
        _emails.add(r.email.toLowerCase());     
    });
  }
static int i=0;
  _onEntryAdded2(Event event) {
    setState(() {
      UIDs uid=UIDs.fromSnapshot(event.snapshot);
    //  print(uid.uid);
      uids.add(uid);
     
        reference
            .child("User_Information")
            .child(uid.uid)
            .onChildAdded
            .listen(_onEntryAdded);
            i++;
            print(i);
      
    });
  }

  @override
  void initState() {
    super.initState();
  initializeDateFormatting();
    userInfo = Register("","", "", "", "", "", new DateTime.now(), "", 0, "", []);
    Fauth = FirebaseAuth.instance;

    reference = FirebaseDatabase.instance.reference();

    reference.child("User_Information").onChildAdded.listen(_onEntryAdded2)..onDone((){
       print("done");
       populateLists();
    });
    print(12);

    //_textFocus.addListener(onChange);
  }

  
    @override
    void dispose() {
    
      super.dispose();
    }
    //curve=new CurvedAnimation(parent: null, curve: Curves.bounceIn);


}