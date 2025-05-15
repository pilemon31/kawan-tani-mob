import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/utils/validation_utils.dart';
import 'package:flutter_kawan_tani/presentation/controllers/profile/edit_profile_controller.dart';
import 'package:flutter_kawan_tani/presentation/pages/dashboard/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import "package:get/get.dart";

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  String warningMessage = "";
  bool isMaleClicked = false;
  bool isFemaleClicked = false;
  final EditprofileController controller = Get.put(EditprofileController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final ValidationService _inputValidator = ValidationService();

  @override
  void initState() {
    super.initState();

    _firstNameController.text = controller.firstName.value;
    _lastNameController.text = controller.lastName.value;
    if (controller.birthDate.value.isNotEmpty) {
      final parts = controller.birthDate.value.split('-');
      if (parts.length == 3) {
        _birthDateController.text = "${parts[2]}/${parts[1]}/${parts[0]}";
      } else {
        _birthDateController.text = controller.birthDate.value;
      }
    }
    _emailController.text = controller.emailAddress.value;
    _phoneNumberController.text = controller.phoneNumber.value;
    _genderController.text = controller.gender.value;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthDateController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  void verifyData() {
    if (isFemaleClicked == false && isMaleClicked == false) {
      setState(() {
        warningMessage = "Jenis kelamin harus dipilih!";
      });
    } else {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        Get.to(() => HomeScreen());
      }
    }
  }

  void clickedMale() {
    controller.gender.value = "Laki-Laki";
    setState(() {
      isMaleClicked = true;
      isFemaleClicked = false;
    });
  }

  void clickedFemale() {
    controller.gender.value = "Perempuan";
    setState(() {
      isMaleClicked = false;
      isFemaleClicked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF78D14D),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: [
              // Green top section
              Container(
                height: MediaQuery.of(context).size.height * 0.25 - 20,
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
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 30.0, left: 20.0, right: 20.0, bottom: 54.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: PhosphorIcon(
                          PhosphorIconsBold.arrowLeft,
                          size: 32.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "Pengaturan Akun",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 25.0,
                            fontWeight: bold,
                            color: whiteColor),
                      ),
                    ],
                  ),
                ),
              ),
              // White bottom section
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 38.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // AVATAR HERE
                                    Center(
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: 120,
                                            height: 120,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: blackColor,
                                                    blurRadius: 6)
                                              ],
                                            ),
                                            child: CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  "assets/apple.jpg"),
                                              backgroundColor: Colors.grey[200],
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                shape: BoxShape.circle,
                                              ),
                                              child: IconButton(
                                                icon: Icon(Icons.edit,
                                                    color: Colors.white,
                                                    size: 20),
                                                onPressed: () {},
                                                padding: EdgeInsets.zero,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    // First Name
                                    Text(
                                      "Nama Depan",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15, color: blackColor),
                                    ),
                                    const SizedBox(height: 8.0),
                                    TextFormField(
                                      controller: _firstNameController,
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
                                        controller.firstName.value =
                                            value ?? "";
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                // Last Name
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nama Belakang",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15, color: blackColor),
                                    ),
                                    const SizedBox(height: 8.0),
                                    TextFormField(
                                      controller: _lastNameController,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        hintText: "Doe",
                                        hintStyle: GoogleFonts.poppins(
                                            fontSize: 15.0, fontWeight: light),
                                        prefixIcon: PhosphorIcon(
                                          PhosphorIcons.user(),
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
                                const SizedBox(height: 20),
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
                                          controller.birthDate.value =
                                              formattedDate;
                                        }
                                      },
                                      validator:
                                          _inputValidator.validateBirthDate,
                                      onSaved: (value) {
                                        controller.birthDate.value =
                                            value ?? "";
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                // Email
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Email",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15, color: blackColor),
                                    ),
                                    const SizedBox(height: 8.0),
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
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        fillColor: Color(0xffE7EFF2),
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 15.0),
                                      ),
                                      validator: _inputValidator.validateEmail,
                                      onSaved: (value) {
                                        controller.emailAddress.value =
                                            value ?? "";
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                // Phone Number
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nomor Telepon",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15, color: blackColor),
                                    ),
                                    const SizedBox(height: 8.0),
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
                                const SizedBox(height: 20),
                                // Gender
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
                                const SizedBox(height: 56),
                                // Save Button
                                ElevatedButton(
                                  onPressed: verifyData,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    elevation: 0.0,
                                    shadowColor: Colors.transparent,
                                    minimumSize:
                                        const Size(double.infinity, 48),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    'Ubah Profil',
                                    style: GoogleFonts.poppins(
                                        color: whiteColor,
                                        fontSize: 16,
                                        fontWeight: bold),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                // Cancel Button
                                ElevatedButton(
                                  onPressed: () {
                                    _formKey.currentState?.save();
                                    Get.back();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: whiteColor,
                                      elevation: 0.0,
                                      shadowColor: Colors.transparent,
                                      minimumSize:
                                          const Size(double.infinity, 48),
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
