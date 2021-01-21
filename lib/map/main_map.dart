import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoder/geocoder.dart';
import 'package:thoai/map/component/key_map.dart';
import 'package:thoai/map/component/picker_map.dart';
import 'package:thoai/map/component/search_map.dart';




class MainMap extends StatefulWidget {
  @override
  _MainMapState createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  KeyMap _pickerMapBloc;
  Address _address;

  @override
  void initState() {
    super.initState();
    _pickerMapBloc = KeyMap.getInstance();
    _pickerMapBloc.addressController.stream.listen((Address address) {
      _address = address;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    double padding = _size.width * 0.035;

    return GestureDetector(
      
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        
        body: Column(
          children: [
            Container(
              width: _size.width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SearchBox(_pickerMapBloc),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  PickerMap(_pickerMapBloc),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 90,
                      width: double.infinity,
                      color: Colors.blue[50],
                      child: FractionallySizedBox(
                        widthFactor: 0.7,
                        heightFactor: 0.5,
                        child: RaisedButton(
                          color: Color(0xff00104F),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          onPressed: () {
                            if (_address != null) {
                              Get.back(result: _address);
                            } else {
                              Get.back();
                            }
                          },
                          
                          child: Text(
                            "Chọn",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    _pickerMapBloc.dispose();
  }

}
