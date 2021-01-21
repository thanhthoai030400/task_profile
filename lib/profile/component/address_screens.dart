
import 'package:flutter/material.dart';

import 'package:thoai/profile/address/city.dart';
import 'package:thoai/profile/address/district.dart';
import 'package:thoai/profile/address/ward.dart';

class AddressScreen extends StatefulWidget {
  final countryId;
  CityAddress city;
  DistrictAddress district;
  WardAddress ward;
  final choosePage;
  AddressScreen(
      {this.countryId, this.city, this.district, this.ward, this.choosePage});

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  PageController _controller;
  int countryId;
  int choosePage;
  CityAddress city;
  DistrictAddress district;
  WardAddress ward;
  List<CityAddress> listCT = [];
  List<DistrictAddress> listDT = [];
  List<WardAddress> listWard = [];
  @override
  void initState() {
    countryId = widget.countryId;
    choosePage = widget.choosePage;

    city = widget.city;
    district = widget.district;
    ward = widget.ward;

    if (city != null && district != null && ward != null) {
      loadListCity(countryId: countryId.toString());
      loadListDistrict(countryAreaId: city.id.toString());
      loadListWard(countryTerritoryId: district.id.toString());
      _controller = PageController(initialPage: choosePage);
    } else {
      _controller = PageController(initialPage: 0);
      loadListCity(countryId: countryId.toString());
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final heightScreens = MediaQuery.of(context).size.height;
    final widthScreens = MediaQuery.of(context).size.width;
    final horPadding = widthScreens * 0.04;
    return Container(
      height: heightScreens * 0.95,
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          //city
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  padding: EdgeInsets.only(left: horPadding - 10),
                  child: Stack(
                    children: [
                      Column(children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              InkWell(
                                child: Image.asset("assets/icons/ButtonX.png"),
                                onTap: () {
                                  if (city != null &&
                                      district != null &&
                                      ward != null) {
                                    var q = [city, district, ward];
                                    Navigator.pop(context, q);
                                  } else
                                    Navigator.pop(context, null);
                                },
                              ),
                            ]),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Chọn Tỉnh/ Thành Phố",
                                style: TextStyle(
                                    color: Color(0xff00104F),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.015),
                        Stack(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                  hintText: "Từ khóa tìm kiếm",
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(left: 44, bottom: 2.5)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.search_rounded,
                                    color: Color(0xff00104f),
                                    size: 27,
                                  ),
                                  onPressed: () {}),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 44, right: 30, top: 36),
                              child: Container(
                                  height: 2, color: Color(0xffE8E8E8)),
                            ),
                          ],
                        ),
                      ]),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: listCT.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: horPadding + 17),
                          child: Text('${listCT[index].name}',
                              style: TextStyle(
                                fontSize: widthScreens * 0.043,
                              )),
                        ),
                        onTap: () {
                          setState(() {
                            listDT.clear();
                            city = listCT[index];
                            loadListDistrict(countryAreaId: city.id.toString());
                          });
                          _controller.animateToPage(1,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                        trailing: (city != null && city.id == listCT[index].id)
                            ? Padding(
                                padding:
                                    EdgeInsets.only(right: horPadding),
                                child: Icon(
                                  Icons.check,
                                  color: Color(0xff00104F),
                                ),
                              )
                            : null,
                      );
                    },
                    separatorBuilder: (_, index) => Divider(
                      height: 2.0,
                      thickness: 1.0,
                    ),
                  ),
                )
              ],
            ),
          ),
          //---------------------------------------------------
            //district
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  padding: EdgeInsets.only(left: horPadding - 10),
                  child: Stack(
                    children: [
                      Column(children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              InkWell(
                                child: Image.asset("assets/icons/ButtonX.png"),
                                onTap: () {
                                  _controller.animateToPage(0,
                                      duration: Duration(milliseconds:600),
                                      curve: Curves.easeIn);
                                },
                              ),
                            ]),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Chọn Quận/ Huyện",
                                style: TextStyle(
                                    color: Color(0xff00104F),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.015),
                        Stack(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                  hintText: "Từ khóa tìm kiếm",
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(left: 44, bottom: 2.5)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.search_rounded,
                                    color: Color(0xff00104f),
                                    size: 27,
                                  ),
                                  onPressed: () {}),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 44, right: 30, top: 36),
                              child: Container(
                                  height: 1, color: Color(0xffE8E8E8)),
                            ),
                          ],
                        ),
                      ]),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: listDT.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: horPadding + 17),
                          child: Text('${listDT[index].name}',
                              style: TextStyle(
                                fontSize: widthScreens * 0.043,
                              )),
                        ),
                        onTap: () {
                          setState(() {
                            listWard.clear();
                            district = listDT[index];
                            loadListWard(
                                countryTerritoryId: district.id.toString());
                          });
                          _controller.animateToPage(2,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                        trailing: (district != null &&
                                district.id == listDT[index].id)
                            ? Padding(
                                padding:
                                    EdgeInsets.only(right: horPadding),
                                child: Icon(
                                  Icons.check,
                                  color: Color(0xff00104F),
                                ),
                              )
                            : null,
                      );
                    },
                    separatorBuilder: (_, index) => Divider(
                      height: 2.0,
                      thickness: 1.0,
                    ),
                  ),
                )
              ],
            ),
          ),
          //----------------------------------------------
          //ward
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  padding: EdgeInsets.only(left: horPadding - 12),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        padding: EdgeInsets.only(left: horPadding - 10),
                        child: Stack(
                          children: [
                            Column(children: <Widget>[
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    InkWell(
                                      child: Image.asset(
                                          "assets/icons/ButtonX.png"),
                                      onTap: () {
                                        _controller.animateToPage(1,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeIn);
                                        // setState(() {
                                        //   district = null;
                                        // });
                                      },
                                    ),
                                  ]),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Chọn Phường/ Xã",
                                      style: TextStyle(
                                          color: Color(0xff00104F),
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: size.height * 0.015),
                              Stack(
                                children: [
                                  TextField(
                                    decoration: InputDecoration(
                                        hintText: "Từ khóa tìm kiếm",
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: 44, bottom: 2.5)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 6),
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.search_rounded,
                                          color: Color(0xff00104f),
                                          size: 27,
                                        ),
                                        onPressed: () {}),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 44, right: 30, top: 36),
                                    child: Container(
                                        height: 1, color: Color(0xffE8E8E8)),
                                  ),
                                ],
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: listWard.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: horPadding + 17),
                          child: Text('${listWard[index].name}',
                              style: TextStyle(
                                fontSize: widthScreens * 0.043,
                              )),
                        ),
                        onTap: () {
                          setState(() {
                            ward = listWard[index];
                          });

                          var q = [city, district, ward];
                          Navigator.pop(context, q);
                        },
                        trailing: (ward != null &&
                                ward.id == listWard[index].id)
                            ? Padding(
                                padding:
                                    EdgeInsets.only(right: horPadding),
                                child: Icon(
                                  Icons.check,
                                  color: Color(0xff00104F),
                                ),
                              )
                            : null,
                      );
                    },
                    separatorBuilder: (_, index) => Divider(
                      height: 2.0,
                      thickness: 1.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
        controller: _controller,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
    //load city
  void loadListCity({@required String countryId}) async {
    var q = <CityAddress>[];
    q = await CityAddress.getCityAddress(countryId: countryId);
    setState(() {
      listCT = List.of(q);
    });
  }
//load districst
  void loadListDistrict({@required String countryAreaId}) async {
    var result = <DistrictAddress>[];
    result = await DistrictAddress.getDistricAddress(countryAreaId: countryAreaId);
    setState(() {
      listDT = List.of(result);
    });
  }
//load ward
  void loadListWard({@required String countryTerritoryId}) async {
    var result = <WardAddress>[];
    result = await WardAddress.getWardsAddress(countryTerritoryId: countryTerritoryId);
    setState(() {
      listWard = List.of(result);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
