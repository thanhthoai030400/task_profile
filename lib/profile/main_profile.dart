import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:thoai/color.dart';
import 'package:thoai/map/main_map.dart';
import 'package:thoai/profile/address/city.dart';
import 'package:thoai/profile/address/district.dart';
import 'package:thoai/profile/component/address_screens.dart';
import 'package:thoai/profile/address/ward.dart';

class ProFlie extends StatefulWidget {
  @override
  _ProFlieState createState() => _ProFlieState();
}

class _ProFlieState extends State<ProFlie> {
  final _formKey = GlobalKey<FormState>();
  CityAddress city;
  DistrictAddress district;
  WardAddress ward;
  File _image;
  // Position _position;
  // StreamSubscription _streamSubscription;
  Address addresResult;

  final picker = ImagePicker();
  Future getImage(bool isCamere) async {
    final pickedFile = await picker.getImage(
        source: isCamere ? ImageSource.gallery : ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  String content_district = "";
  String content_city = "";
  String content_ward = "";
  String address2 = "";

  double _lat = 0, _lng = 0;

  void reloadAddress(CityAddress ct, DistrictAddress dt, WardAddress w) {
    if (ct.id != null && dt.id != null && w.id != null) {
      setState(() {
        city = ct;
        district = dt;
        ward = w;
        content_city = city.name;
        content_ward = ward.name;

        content_district = district.name;
      });
    }
  }
//ui camera
  _showbottomsheep() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              color: Colors.transparent,
              height: 170,
              child: Stack(children: <Widget>[
                Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        getImage(false);
                      },
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 13, top: 13),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "CHỤP ẢNH",
                                style: TextStyle(
                                    fontSize: 21, color: Color(0xff00104f)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(height: 1, color: Color(0xffe8e8e8)),
                    InkWell(
                      onTap: () {
                        getImage(true);
                      },
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 13, bottom: 13),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("CHỌN ẢNH TỪ ALBUM",
                                  style: TextStyle(
                                      fontSize: 21, color: Color(0xff00104f)))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: MediaQuery.of(context).viewPadding.bottom,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3)),
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 13, bottom: 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("HỦY",
                                style: TextStyle(
                                    fontSize: 21, color: Color(0xff00104f)))
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    final paddingHorizontal = widthScreen * 0.04;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kTextBackground,
        title: Text("Edit Profile"),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
            onPressed: () {}),
      ),
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //----------------AVATAR------------------//
                  GestureDetector(
                    onTap: () {
                      _showbottomsheep();
                    },
                    child: Stack(
                      overflow: Overflow.visible,
                      alignment: Alignment.center,
                      children: <Widget>[
                        //background
                        Container(
                          height: size.width * 0.23,
                          color: Color(0xff2a42a7),
                        ),

                        //Image Avatar
                        Positioned(
                          bottom: -83,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: 150,
                                height: 150,
                                padding: EdgeInsets.all(11.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: CircleAvatar(
                                    backgroundColor:
                                        Colors.transparent, //màu trong suốt
                                    backgroundImage: _image == null
                                        ? NetworkImage(
                                            "https://i.pravatar.cc/150?u=fake@pravatar.com")
                                        : FileImage(File(_image.path))),
                              ),
                            ],
                          ),
                        ),
                        //icon camera
                        Positioned(
                          bottom: -30,
                          right: 86,
                          child: ImageIcon(
                            AssetImage(
                              "assets/icons/cameraa.png",
                            ),
                            color: Color(0xffbebebe),
                            size: 40,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.11,
                  ),

                  //star
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (int i = 0; i <= 4; i++)
                        Icon(
                          Icons.star,
                          size: 30,
                          color: Colors.yellow,
                        ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Container(
                    height: heightScreen * 0.01,
                    color: Color(0xffe8e8e8),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  //------------------CONTENT PROFILE-----------//
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // TextField Name
                        Padding(
                          padding: EdgeInsets.only(
                              left: widthScreen * 0.045,
                              right: widthScreen * 0.045,
                              top: heightScreen * 0.015),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              RichText(
                                  text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: "Họ và tên  ",
                                    style: TextStyle(color: Color(0xff9C9C9C))),
                                TextSpan(
                                    text: "*",
                                    style: TextStyle(color: Colors.red))
                              ])),
                              TextFormField(
                                //controller: _txtDiaChiController,
                                style: TextStyle(fontSize: size.width * 0.045),
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.7, color: Colors.black),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3, color: Colors.black),
                                  ),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Vui lòng nhập họ tên';
                                  } else
                                    return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        //TextField Phone Number
                        Padding(
                          padding: EdgeInsets.only(
                              left: widthScreen * 0.045,
                              right: widthScreen * 0.045,
                              top: heightScreen * 0.015),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              RichText(
                                  text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: "Điện thoại  ",
                                    style: TextStyle(color: Color(0xff9C9C9C))),
                                TextSpan(
                                    text: "*",
                                    style: TextStyle(color: Colors.red))
                              ])),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                //controller: _txtDiaChiController,
                                style: TextStyle(fontSize: size.width * 0.045),
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.7, color: Colors.black),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3, color: Colors.black),
                                  ),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Vui lòng nhập số điện thoại';
                                  } else
                                    return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        //Text Field Email
                        Padding(
                          padding: EdgeInsets.only(
                              left: widthScreen * 0.045,
                              right: widthScreen * 0.045,
                              top: heightScreen * 0.015),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              RichText(
                                  text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: "Email  ",
                                    style: TextStyle(color: Color(0xff9C9C9C))),
                                TextSpan(
                                    text: "*",
                                    style: TextStyle(color: Colors.red))
                              ])),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                //controller: _txtDiaChiController,
                                style: TextStyle(fontSize: size.width * 0.045),
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.7, color: Colors.black),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3, color: Colors.black),
                                  ),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Vui lòng nhập Email';
                                  } else
                                    return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: widthScreen * 0.045,
                              right: widthScreen * 0.045,
                              top: heightScreen * 0.015),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Tỉnh / Thành phố',
                                  style: TextStyle(color: Color(0xff9C9C9C))),
                            ],
                          ),
                        ),
                        //load city
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                barrierColor: Colors.black54,
                                backgroundColor: Colors.white,
                                builder: (_) {
                                  return AddressScreen(
                                      countryId: 232,
                                      city: city,
                                      district: district,
                                      ward: ward,
                                      choosePage: 0);
                                }).then((q) => {
                                  if (q != null)
                                    {reloadAddress(q[0], q[1], q[2])}
                                });
                          },
                          child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 13.0),
                              width: widthScreen,
                              child: Row(
                                children: [
                                  Flexible(
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              left: paddingHorizontal),
                                          child: Text(
                                            '$content_city',
                                            style: TextStyle(
                                                fontSize: size.width * 0.04),
                                          )),
                                      flex: 9,
                                      fit: FlexFit.tight),
                                  Flexible(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            right: paddingHorizontal),
                                        alignment: Alignment.centerRight,
                                        child: Icon(Icons.navigate_next),
                                      ),
                                      flex: 1,
                                      fit: FlexFit.tight)
                                ],
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: paddingHorizontal),
                          child: Divider(
                            height: 5,
                            color: Colors.black,
                          ),
                          //child: Black45Divider(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: widthScreen * 0.045,
                              right: widthScreen * 0.045,
                              top: heightScreen * 0.015),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Quận/ Huyện',
                                  style: TextStyle(color: Color(0xff9C9C9C))),
                            ],
                          ),
                        ),
                       //load district
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                barrierColor: Colors.black54,
                                backgroundColor: Colors.white,
                                builder: (_) {
                                  return AddressScreen(
                                      countryId: 232,
                                      city: city,
                                      district: district,
                                      ward: ward,
                                      choosePage: 1);
                                }).then((q) => {
                                  if (q != null)
                                    {reloadAddress(q[0], q[1], q[2])}
                                });
                          },
                          child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 13.0),
                              width: widthScreen,
                              child: Row(
                                children: [
                                  Flexible(
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              left: paddingHorizontal),
                                          child: Text(
                                            // 'Quận 11',
                                            '$content_district',
                                            style: TextStyle(
                                                fontSize: size.width * 0.04),
                                          )),
                                      flex: 9,
                                      fit: FlexFit.tight),
                                  Flexible(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            right: paddingHorizontal),
                                        alignment: Alignment.centerRight,
                                        child: Icon(Icons.navigate_next),
                                      ),
                                      flex: 1,
                                      fit: FlexFit.tight)
                                ],
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: paddingHorizontal),
                          child: Divider(
                            height: 5,
                            color: Colors.black,
                          ),
                          //child: Black45Divider(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: widthScreen * 0.045,
                              right: widthScreen * 0.045,
                              top: heightScreen * 0.015),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Phường/ Xã',
                                  style: TextStyle(color: Color(0xff9C9C9C))),
                            ],
                          ),
                        ),
                        //load wward
                        
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                barrierColor: Colors.black54,
                                backgroundColor: Colors.white,
                                builder: (_) {
                                  return AddressScreen(
                                      countryId: 232,
                                      city: city,
                                      district: district,
                                      ward: ward,
                                      choosePage: 2);
                                }).then((q) => {
                                  if (q != null)
                                    {reloadAddress(q[0], q[1], q[2])}
                                });
                          },
                          child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 13.0),
                              width: widthScreen,
                              child: Row(
                                children: [
                                  Flexible(
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              left: paddingHorizontal),
                                          child: Text(
                                            // 'Phường 2',
                                            '$content_ward',
                                            style: TextStyle(
                                                fontSize: size.width * 0.04),
                                          )),
                                      flex: 9,
                                      fit: FlexFit.tight),
                                  Flexible(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            right: paddingHorizontal),
                                        alignment: Alignment.centerRight,
                                        child: Icon(Icons.navigate_next),
                                      ),
                                      flex: 1,
                                      fit: FlexFit.tight)
                                ],
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: paddingHorizontal),
                          child: Divider(
                            height: 5,
                            color: Colors.black,
                          ),
                          // child: Black45Divider(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: widthScreen * 0.045,
                              right: widthScreen * 0.045,
                              top: heightScreen * 0.015),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Địa chỉ cụ thể',
                                  style: TextStyle(color: Color(0xff9C9C9C))),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: paddingHorizontal),
                          child: TextFormField(
                            
                            style: TextStyle(fontSize: size.width * 0.04),
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(width: 0.7, color: Colors.black),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(width: 0.3, color: Colors.black),
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Vui lòng nhập địa chỉ';
                              } else
                                return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              paddingHorizontal,
                              paddingHorizontal,
                              paddingHorizontal * 0.035,
                              10.0),
                        ),

                        Card(
                          child: Container(
                            margin:
                                const EdgeInsets.only(bottom: 3.5, top: 1.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                              leading: Container(
                                height: 35,
                                child: SvgPicture.asset(
                                  "assets/icons/placeholder.svg",
                                  height: 33,
                                  fit: BoxFit.fill,
                                  color: Colors.red[900],
                                ),
                              ),
                              title: Align(
                                alignment: Alignment(-1.7, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: Text(
                                        'Chọn vị trí trên Google Map',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      addresResult != null
                                          ? addresResult.addressLine: 'Hồ Chí Minh , Huyện Cần Giờ , Xã Lý Nhơn',
                                      style: TextStyle(
                                          fontSize: size.width * 0.035),
                                    ),

                                  ],
                                ),
                              ),
                              trailing: Icon(
                                Icons.navigate_next,
                                color: Colors.black,
                              ),
                              onTap: () {
                                  Get.to(MainMap()).then((value) {
                                    if (value != null) {
                                      setState(() {
                                        addresResult = value;
                                      });
                                    }
                                  });
                                },
                              
                            ),
                          ),
                        ),
                        SizedBox(height: heightScreen * 0.1)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).viewPadding.bottom,
              child: Container(
                width: size.width,
                height: 61,
                decoration: BoxDecoration(
                  color: Color(0xff00104F),
                ),
                child: FlatButton(
                  child: Text(
                    "LƯU THÔNG TIN",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
