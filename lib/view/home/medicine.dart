import 'dart:io';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/home/Appointments.dart';
import 'package:flutter_application_1/widgets/button_widget.dart';
import 'package:flutter_application_1/widgets/footer_widget.dart';
import 'package:flutter_application_1/widgets/imagepicker_widget.dart';
import 'package:flutter_application_1/widgets/textformfield_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as path;

class Medicine extends StatefulWidget {
  const Medicine({Key? key}) : super(key: key);

  @override
  State<Medicine> createState() => _MedicineState();
}

class _MedicineState extends State<Medicine> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController medicineController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  String selectedFileName = "No file chosen";
  File? _selectedFile;
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF002147),
        actions: [
          IconButton(
            icon: Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 50,
              width: 50,
              child: Icon(Icons.menu, color: Colors.white),
            ),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image(image: AssetImage("assets/images/logo.png")),
        ),
      ),
      drawer: _buildDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  textformfield(
                      'Type Medicine', 'Type Medicine', medicineController),
                  textformfield(
                      'Type Message', 'Type Message', messageController),
                  SizedBox(height: 5),
                  UploadPrescriptionField(
                    onFileSelected: (File? file, String name) {
                      setState(() {
                        _selectedFile = file;
                        selectedFileName = name;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  _buildOrderButton(),
                  SizedBox(height: 10),
                  _buildVoiceMessageButton(),
                  SizedBox(height: 10),
                  _buildCallButton(),
                  SizedBox(height: 20),
                ],
              ),
            ),
            CustomFooter(),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        backgroundColor: Color(0xFF002147),
        color: Colors.blueGrey,
        buttonBackgroundColor: Colors.green,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            if (index == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Appointments()),
              );
            }
          });
        },
        items: [
          Icon(Icons.home, size: 30),
          Icon(Icons.medical_services, size: 30),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.grey),
            child: Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/logo.png'),
                radius: 50,
              ),
            ),
          ),
          _buildDrawerItem('Home', Icons.arrow_forward, () {}),
          _buildDrawerItem('About', Icons.arrow_forward, () {}),
          _buildDrawerItem('Doctors', Icons.arrow_forward, () {}),
          _buildDrawerItem('Departments', Icons.arrow_forward, () {}),
          _buildDrawerItem('Medicines', Icons.arrow_forward, () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Medicine()),
            );
          }),
          _buildDrawerItem('Contact Us', Icons.arrow_forward, () {}),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/hero.png"),
          fit: BoxFit.cover,
        ),
      ),
      height: 200,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Order Medical",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Home >",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                TextSpan(
                  text: "Medicine",
                  style: TextStyle(color: Color(0xFF083db36), fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(String title, IconData icon, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          onTap: onTap,
        ),
        Divider(),
      ],
    );
  }

  Widget _buildOrderButton() {
    return GestureDetector(
      onTap: () async {
        if ( medicineController.text.isEmpty || messageController.text.isEmpty || _selectedFile == null ) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please fill all fields.')),
          );
          return;
        }

        try {
          String? imageUrl =
              await uploadImageToSupabase(_selectedFile!, selectedFileName);

          if (imageUrl != null) {
            var whatsappnumber = '+923345656765';
            String message =
                'Medicine: ${medicineController.text}\nMessage: ${messageController.text}\nPrescription: $imageUrl';

            String encodedMessage = Uri.encodeComponent(message);
            var whatsappUrl =
                'whatsapp://send?phone=$whatsappnumber&text=$encodedMessage';

            await launchUrl(Uri.parse(whatsappUrl));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to upload image.')),
            );
          }
        } catch (e) {
          print(e);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('An error occurred: $e')),
          );
        }
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.blue,
        ),
        child: Center(
          child: Text(
            'ORDER MEDICINE',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildVoiceMessageButton() {
    return mybutton(
      Colors.blue,
      Icons.mic,
      Colors.white,
      'VOICE MESSAGE',
      Colors.white,
      () async {
        try {
          var whatsappnumber = '+923345656765';
          var watsappUrl = 'whatsapp://send?phone="$whatsappnumber"';
          await launchUrl(Uri.parse(watsappUrl));
        } catch (e) {
          print(e);
        }
      },
    );
  }

  Widget _buildCallButton() {
    return mybutton(
      Colors.green,
      Icons.call,
      Colors.black,
      'CALL NOW',
      Colors.black,
      () async {
        final phoneNumber = '+923345656765';
        final Uri uri = Uri.parse('tel:$phoneNumber');
        try {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } catch (e) {
          print('Error making phone call: $e');
        }
      },
    );
  }

  Future<String?> uploadImageToSupabase(File file, String fileName) async {
    try {
      final imagePath = 'images/$fileName';

      await Supabase.instance.client.storage.from('images').upload(
            imagePath,
            file,
            fileOptions: FileOptions(contentType: 'image/jpeg'),
          );

      final imageUrl = Supabase.instance.client.storage
          .from('images')
          .getPublicUrl(imagePath);

      print('Image URL: $imageUrl');
      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}
