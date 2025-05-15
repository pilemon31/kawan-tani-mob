import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/controllers/workshop/register_workshop_controller.dart';
import 'package:flutter_kawan_tani/presentation/pages/workshops/register_workshop_payment.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:flutter_kawan_tani/utils/validation_utils.dart';
import "package:get/get.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:intl/intl.dart';

class RegisterWorkshop extends StatefulWidget {
  const RegisterWorkshop({super.key});

  @override
  State<RegisterWorkshop> createState() => _RegisterWorkshopState();
}

class _RegisterWorkshopState extends State<RegisterWorkshop> {
  bool isMaleClicked = false;
  bool isFemaleClicked = false;
  String warningMessage = "";
  final RegisterWorkshopController controller =
      Get.put(RegisterWorkshopController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _attendeesNameController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final ValidationService _inputValidator = ValidationService();

  @override
  void initState() {
    super.initState();

    _attendeesNameController.text = controller.attendeesName.value;
    _emailController.text = controller.emailAddress.value;
    _phoneNumberController.text = controller.phoneNumber.value;
    _birthDateController.text = controller.birthDate.value;
  }

  @override
  void dispose() {
    _attendeesNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _birthDateController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  void verifyData() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Get.to(() => RegisterWorkshopPayment());
    }
  }

  void clickedMale() {
    controller.gender.value = 0;
    setState(() {
      isMaleClicked = true;
      isFemaleClicked = false;
    });
  }

  void clickedFemale() {
    controller.gender.value = 1;
    setState(() {
      isMaleClicked = false;
      isFemaleClicked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27),
          child: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 80.0,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: PhosphorIcon(
                PhosphorIconsBold.arrowLeft,
                size: 32.0,
              ),
            ),
            title: Text(
              'Daftar Workshop',
              style: GoogleFonts.poppins(
                fontSize: 20,
                color: blackColor,
                fontWeight: bold,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: ListView(
          children: [
            Text(
              'Detail Pendaftaran',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: blackColor,
                fontWeight: bold,
              ),
            ),
            Text(
              'Detail kontak ini akan digunakan untuk pengisian data diri dan pengiriman e-tiket workshop',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: greyColor,
                fontWeight: medium,
              ),
            ),
            SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Nama Depan
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nama Peserta",
                            style: GoogleFonts.poppins(
                                fontSize: 15, color: blackColor),
                          ),
                          SizedBox(height: 8.0),
                          TextFormField(
                            controller: _attendeesNameController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              hintText: "John",
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 15.0, fontWeight: light),
                              prefixIcon: PhosphorIcon(
                                PhosphorIcons.user(),
                                size: 19.0,
                                color: Color(0xff8594AC),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              fillColor: Color(0xffE7EFF2),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 15.0),
                            ),
                            validator: _inputValidator.validateName,
                            onSaved: (value) {
                              controller.attendeesName.value = value ?? "";
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      // Email
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email",
                            style: GoogleFonts.poppins(
                                fontSize: 15, color: blackColor),
                          ),
                          SizedBox(height: 8.0),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              hintText: "johndoe@examplemail.com",
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 15.0, fontWeight: light),
                              prefixIcon: PhosphorIcon(
                                PhosphorIcons.envelope(),
                                size: 19.0,
                                color: Color(0xff8594AC),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              fillColor: Color(0xffE7EFF2),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 15.0),
                            ),
                            validator: _inputValidator.validateEmail,
                            onSaved: (value) {
                              controller.emailAddress.value = value ?? "";
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      // Tanggal Lahir
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tanggal Lahir",
                            style: GoogleFonts.poppins(
                                fontSize: 15, color: blackColor),
                          ),
                          SizedBox(height: 8.0),
                          TextFormField(
                            controller: _birthDateController,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: "08/08/2008",
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 15.0,
                                fontWeight: light,
                              ),
                              prefixIcon: PhosphorIcon(
                                PhosphorIcons.calendar(),
                                size: 19.0,
                                color: Color(0xff8594AC),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              fillColor: Color(0xffE7EFF2),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 15.0),
                            ),
                            onTap: () async {
                              FocusScope.of(context)
                                  .requestFocus(FocusNode()); // close keyboard
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary:
                                            blackColor, // warna utama date picker
                                        onPrimary: Colors.white,
                                        onSurface: Colors.black,
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          foregroundColor: blackColor,
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );

                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                _birthDateController.text = formattedDate;
                                controller.birthDate.value = formattedDate;
                              }
                            },
                            validator: _inputValidator.validateBirthDate,
                            onSaved: (value) {
                              controller.birthDate.value = value ?? "";
                            },
                          ),
                        ],
                      ),

                      SizedBox(height: 20),
                      // Nomor Telepon
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nomor Telepon",
                            style: GoogleFonts.poppins(
                                fontSize: 15, color: blackColor),
                          ),
                          SizedBox(height: 8.0),
                          TextFormField(
                            controller: _phoneNumberController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              hintText: "+628234569",
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 15.0, fontWeight: light),
                              prefixIcon: PhosphorIcon(
                                PhosphorIcons.phone(),
                                size: 19.0,
                                color: Color(0xff8594AC),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              fillColor: Color(0xffE7EFF2),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 15.0),
                            ),
                            validator: _inputValidator.validatePhoneNumber,
                            onSaved: (value) {
                              controller.phoneNumber.value = value ?? "";
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Jenis Kelamin

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Jenis Kelamin",
                            style: GoogleFonts.poppins(
                                fontSize: 15, color: blackColor),
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: clickedMale,
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0.0,
                                    backgroundColor: isMaleClicked
                                        ? Color(0x00ffffff)
                                        : Color(
                                            0xffE7EFF2), // Button color based on selection
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    side: isMaleClicked
                                        ? BorderSide(color: Color(0xffE7EFF2))
                                        : BorderSide.none,
                                  ),
                                  child: Text(
                                    "Laki-Laki",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15, color: Color(0xff4993F8)),
                                  ),
                                ),
                              ),
                              SizedBox(width: 18),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: clickedFemale,
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0.0,
                                    backgroundColor: isFemaleClicked
                                        ? Color(0x00ffffff)
                                        : Color(
                                            0xffE7EFF2), // Change this to handle the female button selection
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: isFemaleClicked
                                          ? BorderSide(color: Color(0xffE7EFF2))
                                          : BorderSide.none,
                                    ),
                                  ),
                                  child: Text(
                                    "Perempuan",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15, color: Color(0xffF99D9D)),
                                  ),
                                ),
                              )
                            ],
                          ),
                          if (warningMessage.isNotEmpty)
                            Container(
                              padding: EdgeInsets.only(left: 16),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  warningMessage,
                                  style: GoogleFonts.poppins(
                                      fontSize: 11.5,
                                      color: const Color.fromARGB(
                                          255, 187, 53, 43)),
                                ),
                              ),
                            )
                        ],
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (warningMessage.isNotEmpty)
                            Container(
                              padding: EdgeInsets.only(left: 16),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  warningMessage,
                                  style: GoogleFonts.poppins(
                                      fontSize: 11.5,
                                      color: const Color.fromARGB(
                                          255, 187, 53, 43)),
                                ),
                              ),
                            )
                        ],
                      ),
                      SizedBox(height: 28),
                      // Button Selanjutnya
                      ElevatedButton(
                        onPressed: verifyData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          elevation: 0.0,
                          shadowColor: Colors.transparent,
                          minimumSize: Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Lanjutkan',
                          style: GoogleFonts.poppins(
                              color: whiteColor,
                              fontSize: 16,
                              fontWeight: bold),
                        ),
                      ),
                      SizedBox(height: 18),
                      // Button Kembali
                      ElevatedButton(
                        onPressed: () {
                          _formKey.currentState?.save();
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: whiteColor,
                            elevation: 0.0,
                            shadowColor: Colors.transparent,
                            minimumSize: Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: BorderSide(color: primaryColor)),
                        child: Text(
                          'Keluar',
                          style: GoogleFonts.poppins(
                              color: primaryColor,
                              fontSize: 16,
                              fontWeight: bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
