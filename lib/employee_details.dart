import 'package:console_bit/constants/assets_path.dart';
import 'package:console_bit/constants/color.dart';
import 'package:console_bit/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:telephony/telephony.dart';
import 'package:url_launcher/url_launcher.dart';

class Detail extends StatefulWidget {
  final dynamic details;
  const Detail({Key? key, required this.details}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  TextEditingController notesController = TextEditingController();
  final Telephony telephony = Telephony.instance;

  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: primary,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: SvgPicture.asset(
                  back,
                  width: 25,
                  height: 31,
                )),
          ),
          backgroundColor: primary,
          body: Column(children: [
            getVerticalSpace(15),
            Text(
              widget.details['first_name'].toString().toUpperCase(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w300),
            ),
            getVerticalSpace(20),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () => {
                          telephony.dialPhoneNumber(widget.details['phone'])
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Container(
                            color: white,
                            width: 40,
                            height: 40,
                            child: const Icon(
                              Icons.call,
                              color: Color(0xff0F5FC2),
                            ),
                            // child: Image.asset(call,
                            //     width: 18, height: 18, color: Color(0xff0F5FC2)),
                          ),
                        ),
                      ),
                      getVerticalSpace(10),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () => {
                          telephony.sendSmsByDefaultApp(
                              to: widget.details['phone'], message: "Hi")
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Container(
                            width: 40,
                            height: 40,
                            color: white,
                            child: const Icon(Icons.message,
                                color: Color(0xffFFCB3D)),
                            // child: Image.asset(sms,
                            //     width: 18, height: 40, color: Color(0xffFFCB3D)),
                          ),
                        ),
                      ),
                      getVerticalSpace(10),
                    ],
                  ),
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Container(
                          width: 40,
                          height: 40,
                          color: white,
                          child: IconButton(
                            onPressed: () async => await launchUrl(
                                Uri.parse(
                                  "https://wa.me/+91${widget.details['phone']}?text=Hello",
                                ),
                                mode: LaunchMode.externalApplication),
                            icon: SvgPicture.asset(whatsapp,
                                width: 30,
                                height: 30,
                                color: const Color(0xff92E3A9)),
                          ),
                        ),
                      ),
                      getVerticalSpace(10),
                    ],
                  ),
                ],
              ),
            ),
            getVerticalSpace(40),
            Expanded(
                child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ]),
                    child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: ListView(children: [
                          // getVerticalSpace(25),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 20),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Employee Details',
                                          style: TextStyle(
                                            color: black,
                                            fontSize: 22,
                                            fontFamily: 'Roboto',
                                          ),
                                        ),
                                        getVerticalSpace(20),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Date of Birth',
                                                    style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                  getVerticalSpace(10),
                                                  const Text(
                                                    'Address',
                                                    style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                  getVerticalSpace(10),
                                                  const Text(
                                                    'City',
                                                    style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                  getVerticalSpace(10),
                                                  const Text(
                                                    'Pincode',
                                                    style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                  getVerticalSpace(10),
                                                  const Text(
                                                    'Country',
                                                    style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                  getVerticalSpace(10),
                                                  const Text(
                                                    'Designation',
                                                    style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                  getVerticalSpace(10),
                                                  const Text(
                                                    'Organization',
                                                    style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                  getVerticalSpace(10),
                                                  const Text(
                                                    'Sallary',
                                                    style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${widget.details['dob']}',
                                                    style: const TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                  getVerticalSpace(10),
                                                  Text(
                                                    '${widget.details['address']}',
                                                    style: const TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                  getVerticalSpace(10),
                                                  Text(
                                                    '${widget.details['city']}',
                                                    style: const TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                  getVerticalSpace(10),
                                                  Text(
                                                    '${widget.details['zip_code']}',
                                                    style: const TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                  getVerticalSpace(10),
                                                  Text(
                                                    '${widget.details['country']}',
                                                    style: const TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                  getVerticalSpace(10),
                                                  Text(
                                                    '${widget.details['designation']}',
                                                    style: const TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                  getVerticalSpace(10),
                                                  Text(
                                                    '${widget.details['organization_name']}',
                                                    style: const TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                  getVerticalSpace(10),
                                                  Text(
                                                    '${widget.details['salary']}',
                                                    style: const TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontFamily: 'Roboto',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),

                                  // getHorizontalSpace(20
                                )
                              ],
                            ),
                          ),
                        ]))))
          ])),
    );
  }
}
