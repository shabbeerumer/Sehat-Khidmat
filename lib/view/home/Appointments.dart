import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/home/medicine.dart';
import 'package:flutter_application_1/widgets/button_widget.dart';
import 'package:flutter_application_1/widgets/footer_widget.dart';
import 'package:flutter_application_1/widgets/textformfield_widget.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // TextEditingController citycontroller = TextEditingController();
  TextEditingController specialistcontroller = TextEditingController();
  TextEditingController doctorcontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  int _selectedIndex = 0;

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
      drawer: Drawer(
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // textformfield(
                  //     'enter your city', 'select city', citycontroller),
                  textformfield('enter specialist', 'enter specialist',
                      specialistcontroller),
                  textformfield(
                      'enter doctor', 'enter doctor', doctorcontroller),
                  SizedBox(height: 5),
                  _buildDatePicker(),
                  SizedBox(height: 10),
                  _buildAppointmentButton(),
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
            if (index == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Medicine()),
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
            "Appointments",
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
                  text: "Appointments",
                  style: TextStyle(color: Color(0xFF083db36), fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker() {
    return TextFormField(
      controller: datecontroller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
        hintText: 'enter your date',
        label: Text('select date'),
      ),
      onTap: () async {
        DateTime? pickerDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickerDate != null) {
          setState(() {
            datecontroller.text = DateFormat('yyyy-MM-dd').format(pickerDate);
          });
        }
      },
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

  Widget _buildAppointmentButton() {
    return GestureDetector(
      onTap: () async {
        try {
            if (specialistcontroller.text.isEmpty || doctorcontroller.text.isEmpty || datecontroller.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please enter all fields.')),
              );
              return;
            }

          var whatsappnumber = '+923345656765';
          // Create message with form field data
          String message = '''
Specialist: ${specialistcontroller.text}
Doctor: ${doctorcontroller.text}
Date: ${datecontroller.text}''';

          // Encode the message for URL
          String encodedMessage = Uri.encodeComponent(message);
          var whatsappUrl =
              'whatsapp://send?phone=$whatsappnumber&text=$encodedMessage';
          await launchUrl(Uri.parse(whatsappUrl));
        } catch (e) {
          print(e);
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
            'BOOK AN APPOINTMENT',
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
}
