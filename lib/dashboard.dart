import 'package:cached_network_image/cached_network_image.dart';
import 'package:console_bit/constants/assets_path.dart';
import 'package:console_bit/constants/color.dart';
import 'package:console_bit/constants/size.dart';
import 'package:console_bit/controller/auth_controller.dart';
import 'package:console_bit/controller/remote_data_controller.dart';
import 'package:console_bit/employee_details.dart';
import 'package:console_bit/image_zoom.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({
    Key? key,
  }) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  RemoteDataController remoteDataController = Get.find<RemoteDataController>();
  AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    remoteDataController.initRemote();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: primary,
          title: const Text(
            'Dashboard',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
          actions: [
            IconButton(
              icon: SvgPicture.asset(
                filter,
                height: 25,
                width: 25,
                color: Colors.white,
              ),
              onPressed: () {
                showModalBottomSheet(
                    elevation: 10,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    context: context,
                    builder: (context) => const SizedBox(child: Filter()));
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                authController.logout();
              },
            )
          ],
        ),
      ),
      body: Obx(() {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: remoteDataController.isDetailsLoading.value
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: LinearProgressIndicator(
                      minHeight: 5,
                      color: primary,
                      backgroundColor: Color.fromARGB(255, 207, 226, 230),
                    ),
                  ),
                )
              : remoteDataController.employeeDetails.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "No Employee Data",
                            style:
                                TextStyle(fontSize: 20, fontFamily: "Roboto"),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemCount: remoteDataController.employeeDetails.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => Detail(
                                    details: remoteDataController
                                        .employeeDetails[index]));
                              },
                              child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 1.0),
                                        blurRadius: 0.1,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.dialog(DetailScreen(
                                              imageUrl: remoteDataController
                                                  .employeeDetails[index]
                                                      ['photo']
                                                  .toString()));
                                        },
                                        child: SizedBox(
                                          width: getScreeWidth(100),
                                          height: getScreeWidth(100),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Hero(
                                              tag: 'hero',
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                memCacheHeight: 900,
                                                memCacheWidth: 900,
                                                imageUrl: remoteDataController
                                                    .employeeDetails[index]
                                                        ['photo']
                                                    .toString(),
                                                placeholder: (context, url) =>
                                                    Shimmer.fromColors(
                                                  baseColor: Colors.grey[200]!,
                                                  highlightColor:
                                                      Colors.grey[100]!,
                                                  child: Container(
                                                    width: getScreeWidth(100),
                                                    height: getScreeWidth(100),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                ),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.asset(
                                                        'assets/images/image_placeholder.jpg',
                                                        fit: BoxFit.cover),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      getHorizontalSpace(15),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Text(
                                                "${remoteDataController.employeeDetails[index]['first_name'].toString().capitalize}",
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 18,
                                                    fontFamily: 'Poppins',
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                            getVerticalSpace(5),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                getHorizontalSpace(10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    remoteDataController
                                                                    .employeeDetails[
                                                                index]['email'] ==
                                                            null
                                                        ? const SizedBox()
                                                        : const Text(
                                                            "Email",
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          ),
                                                    remoteDataController.employeeDetails[
                                                                    index]
                                                                ['address'] ==
                                                            null
                                                        ? const SizedBox()
                                                        : const Text(
                                                            "Address",
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          ),
                                                    remoteDataController
                                                                    .employeeDetails[
                                                                index]['city'] ==
                                                            null
                                                        ? const SizedBox()
                                                        : const Text(
                                                            "City",
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          ),
                                                    remoteDataController.employeeDetails[
                                                                    index]
                                                                ['country'] ==
                                                            null
                                                        ? const SizedBox()
                                                        : const Text(
                                                            "Country",
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                                getHorizontalSpace(40),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    remoteDataController
                                                                    .employeeDetails[
                                                                index]['email'] ==
                                                            null
                                                        ? const SizedBox()
                                                        : Text(
                                                            remoteDataController
                                                                            .employeeDetails[
                                                                        index]
                                                                    ['email'] ??
                                                                '',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          ),
                                                    remoteDataController.employeeDetails[
                                                                    index]
                                                                ['address'] ==
                                                            null
                                                        ? const SizedBox()
                                                        : Text(
                                                            remoteDataController
                                                                            .employeeDetails[
                                                                        index][
                                                                    'address'] ??
                                                                '',
                                                            style:
                                                                const TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          ),
                                                    remoteDataController
                                                                    .employeeDetails[
                                                                index]['city'] ==
                                                            null
                                                        ? const SizedBox()
                                                        : Text(
                                                            remoteDataController
                                                                            .employeeDetails[
                                                                        index]
                                                                    ['city'] ??
                                                                '',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          ),
                                                    remoteDataController.employeeDetails[
                                                                    index]
                                                                ['country'] ==
                                                            null
                                                        ? const SizedBox()
                                                        : Text(
                                                            remoteDataController
                                                                            .employeeDetails[
                                                                        index][
                                                                    'country'] ??
                                                                '',
                                                            style:
                                                                const TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          );
                        },
                      )),
        );
      }),
    );
  }
}

class Filter extends StatefulWidget {
  const Filter({
    Key? key,
  }) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  void initState() {
    super.initState();
  }

  String? designation;
  String? salary;
  RemoteDataController remoteDataController = Get.find<RemoteDataController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: SizedBox(
        height: getScreenHeight(250),
        child: ListView(
          children: [
            getVerticalSpace(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        remoteDataController.initRemote();
                        Get.back();
                      },
                      child: const Icon(
                        Icons.restart_alt_sharp,
                        color: Color(0xff8F9BB3),
                      )),
                  const Text(
                    "Filters",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        color: Color(0xff030102)),
                  ),
                  GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.close,
                        color: Color(0xff8F9BB3),
                      )),
                ],
              ),
            ),
            const Divider(color: Colors.black54),
            getVerticalSpace(5),
            Row(
              children: [
                getHorizontalSpace(10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: const Text(
                    "Salary",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        color: Color(0xff030102)),
                  ),
                ),
                getHorizontalSpace(10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: DropdownSearch(
                      scrollbarProps: const ScrollbarProps(
                        radius: Radius.circular(20),
                      ),
                      dropdownSearchDecoration: InputDecoration(
                          hintText: 'Select salary',
                          hintStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: txtBorderColor)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: txtBorderColor)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: txtBorderColor))),
                      onChanged: (newValue) {
                        setState(() {
                          salary = newValue.toString();

                          remoteDataController.fetchFilterForSalary(
                              salary.toString().split('-')[0],
                              salary.toString().split('-')[1]);
                        });
                      },
                      searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                              hintText: 'Search for salary',
                              hintStyle: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontStyle: FontStyle.normal),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: txtBorderColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: txtBorderColor)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: txtBorderColor))),
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontStyle: FontStyle.normal,
                              fontSize: 16)),
                      showSearchBox: true,
                      mode: Mode.BOTTOM_SHEET,
                      maxHeight: 300,
                      selectedItem: salary,
                      items: const [
                        '0-50000',
                        '50000-100000',
                        '400000-500000',
                      ]),
                ),
              ],
            ),
            getVerticalSpace(10),
            Row(
              children: [
                getHorizontalSpace(10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: const Text(
                    "Designation",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        color: Color(0xff030102)),
                  ),
                ),
                getHorizontalSpace(10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: DropdownSearch(
                      scrollbarProps: const ScrollbarProps(
                        radius: Radius.circular(20),
                      ),
                      dropdownSearchDecoration: InputDecoration(
                          hintText: 'Select Source',
                          hintStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: txtBorderColor)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: txtBorderColor)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: txtBorderColor))),
                      onChanged: (newValue) {
                        setState(() {
                          designation = newValue.toString();
                          remoteDataController.fetchFilterForDesignation(
                              designation.toString());
                        });
                      },
                      searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                              hintText: 'Search for designation',
                              hintStyle: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontStyle: FontStyle.normal),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: txtBorderColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: txtBorderColor)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: txtBorderColor))),
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontStyle: FontStyle.normal,
                              fontSize: 16)),
                      showSearchBox: true,
                      mode: Mode.BOTTOM_SHEET,
                      maxHeight: 300,
                      selectedItem: designation,
                      items: const [
                        'Manager',
                        'technical officer',
                      ]),
                ),
              ],
            ),
            getVerticalSpace(20),
          ],
        ),
      ),
    );
  }
}
