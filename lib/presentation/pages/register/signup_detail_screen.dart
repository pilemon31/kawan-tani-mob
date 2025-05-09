import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/controllers/auth/registration_controller.dart';
import 'package:flutter_kawan_tani/utils/validation_utils.dart';
import 'package:flutter_kawan_tani/presentation/pages/register/profile_upload_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import "package:get/get.dart";
import 'package:intl/intl.dart';

class SignUpDetailScreen extends StatefulWidget {
  const SignUpDetailScreen({super.key});

  @override
  State<SignUpDetailScreen> createState() => _SignUpScreenDetailState();
}

class _SignUpScreenDetailState extends State<SignUpDetailScreen> {
  bool isMaleClicked = false;
  bool isFemaleClicked = false;
  String warningMessage = "";
  final RegistrationController controller = Get.put(RegistrationController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final ValidationService _inputValidator = ValidationService();

  @override
  void initState() {
    super.initState();
    _firstNameController.text = controller.firstName.value;
    _lastNameController.text = controller.lastName.value;
    _emailController.text = controller.email.value;
    _phoneNumberController.text = controller.phoneNumber.value;
    _birthDateController.text = controller.dateOfBirth.value;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
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

  void verifyData() {
    if (isFemaleClicked == false && isMaleClicked == false) {
      setState(() {
        warningMessage = "Jenis kelamin harus dipilih!";
      });
    } else {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        Get.to(() => ProfileUpload());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF78D14D),
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF78D14D),
                Color(0xFF349107),
              ],
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30.0) +
                    EdgeInsets.symmetric(horizontal: 16.0) +
                    EdgeInsets.symmetric(vertical: 54.0),
                child: Column(
                  children: [
                    Text(
                      "KawanTani",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 36.0, fontWeight: bold, color: whiteColor),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "Teman Bertani Anda",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 18.0, fontWeight: light, color: whiteColor),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 38.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Lengkapi Daftar Diri",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                  fontSize: 28.0,
                                  color: blackColor,
                                  fontWeight: semiBold),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.77,
                              child: Text(
                                "Lengkapi daftar diri anda!",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                    fontSize: 15.0,
                                    color: blackColor,
                                    fontWeight: light),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // Nama Depan
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nama Depan",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15, color: blackColor),
                                    ),
                                    SizedBox(height: 8.0),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 15.0),
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                              color: Color(0xffE7EFF2),
                                              width: 2.0)),
                                      child: Row(
                                        children: [
                                          PhosphorIcon(
                                            PhosphorIconsRegular.user,
                                            size: 19.0,
                                            color: Color(0xff8594AC),
                                          ),
                                          SizedBox(width: 12),
                                          Expanded(
                                              child: Obx(
                                            () => Text(
                                              controller.firstName.value,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15.0,
                                                  fontWeight: light),
                                            ),
                                          )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                // Nama Belakang
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nama Belakang",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15, color: blackColor),
                                    ),
                                    SizedBox(height: 8.0),
                                    TextFormField(
                                      controller: _lastNameController,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        hintText: "Doe",
                                        hintStyle: GoogleFonts.poppins(
                                            fontSize: 15.0, fontWeight: light),
                                        prefixIcon: PhosphorIcon(
                                          PhosphorIconsRegular.user,
                                          size: 19.0,
                                          color: Color(0xff8594AC),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        fillColor: Color(0xffE7EFF2),
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 15.0),
                                      ),
                                      validator: _inputValidator.validateName,
                                      onSaved: (value) {
                                        controller.lastName.value = value ?? "";
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
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 15.0),
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                              color: Color(0xffE7EFF2),
                                              width: 2.0)),
                                      child: Row(
                                        children: [
                                          PhosphorIcon(
                                            PhosphorIconsRegular.envelope,
                                            size: 19.0,
                                            color: Color(0xff8594AC),
                                          ),
                                          SizedBox(width: 12),
                                          Expanded(
                                              child: Obx(
                                            () => Text(
                                              controller.email.value,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15.0,
                                                  fontWeight: light),
                                            ),
                                          )),
                                        ],
                                      ),
                                    )
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
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        hintText: "+62812345678",
                                        hintStyle: GoogleFonts.poppins(
                                            fontSize: 15.0, fontWeight: light),
                                        prefixIcon: PhosphorIcon(
                                          PhosphorIconsRegular.phone,
                                          size: 19.0,
                                          color: Color(0xff8594AC),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        fillColor: Color(0xffE7EFF2),
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 15.0),
                                      ),
                                      validator:
                                          _inputValidator.validatePhoneNumber,
                                      onSaved: (value) {
                                        controller.phoneNumber.value =
                                            value ?? "";
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
                                      readOnly:
                                          true, // Biar gak bisa diketik manual
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
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        fillColor: Color(0xffE7EFF2),
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 15.0),
                                      ),
                                      onTap: () async {
                                        FocusScope.of(context).requestFocus(
                                            FocusNode()); // close keyboard
                                        final DateTime? pickedDate =
                                            await showDatePicker(
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
                                                textButtonTheme:
                                                    TextButtonThemeData(
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
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedDate);
                                          _birthDateController.text =
                                              formattedDate;
                                          controller.dateOfBirth.value =
                                              formattedDate;
                                        }
                                      },
                                      validator:
                                          _inputValidator.validateBirthDate,
                                      onSaved: (value) {
                                        controller.dateOfBirth.value =
                                            value ?? "";
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              side: isMaleClicked
                                                  ? BorderSide(
                                                      color: Color(0xffE7EFF2))
                                                  : BorderSide.none,
                                            ),
                                            child: Text(
                                              "Laki-Laki",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  color: Color(0xff4993F8)),
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
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                side: isFemaleClicked
                                                    ? BorderSide(
                                                        color:
                                                            Color(0xffE7EFF2))
                                                    : BorderSide.none,
                                              ),
                                            ),
                                            child: Text(
                                              "Perempuan",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  color: Color(0xffF99D9D)),
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
                                SizedBox(height: 56),
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
                                    'Selanjutnya',
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
                                    'Kembali',
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
              ),
            ],
          ),
        ));
  }
}
