import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/screen/home/home_screen.dart';
import 'package:mobile/utils/show_snackbar.dart';
import 'package:mobile/api/tikum.dart';

class FormTikumScreenArguments {
  FormTikumScreenArguments();
}

class FormTikumScreen extends StatefulWidget {
  static String routeName = "/form-tikum";

  const FormTikumScreen({Key? key}) : super(key: key);

  @override
  State<FormTikumScreen> createState() => _FormTikumScreenState();
}

class _FormTikumScreenState extends State<FormTikumScreen> {
  final TextEditingController _tujuanController = TextEditingController();
  final TextEditingController _kumpulController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _grupController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  bool isSwitched = false;
  final _formKey = GlobalKey<FormState>();
  String fullName = '';
  bool submitActive = true;
  @override
  void initState() {
    _dateController.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  void secondState() {
    _timeController.text = ""; //set the initial value of text field
    super.initState();
  }

  void submitTikum() async {
    if (_formKey.currentState!.validate()) {
      try {
        showDialog(
            context: context,
            builder: (context) => const Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(),
                  ),
                ));
        await createTikum(
          tujuan: _tujuanController.text,
          kumpul: _kumpulController.text,
          date: _dateController.text,
          time: _timeController.text,
          grup: _grupController.text,
          deskripsi: _deskripsiController.text,
        );
        Navigator.pop(context);
        ShowSnackBar(context, "Tikum berhasil dibuat");
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false);
      } catch (err) {
        Navigator.pop(context);
        ShowSnackBar(context, "$err");
      }
    } else {
      ShowSnackBar(context, "There's some form not filled properly");
    }
  }

  void _handleKembaliButton() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Stack(
              children: [
                Center(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const Text(
                            "Share Your Tikum",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Tempat Tujuan",
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _tujuanController,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "Enter Name",
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Tempat Kumpul",
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _kumpulController,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "Enter",
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Waktu Kumpul",
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 200,
                                child: Flexible(
                                  child: TextFormField(
                                    controller:
                                        _dateController, //editing controller of this TextField
                                    decoration: InputDecoration(
                                      prefixIcon: const Padding(
                                        padding: EdgeInsets.all(0.0),
                                        child: Icon(
                                          Icons.calendar_today,
                                        ), // icon is 48px widget.
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      hintText: "Enter Date",
                                    ),
                                    readOnly:
                                        true, //set it true, so that user will not able to edit text
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(
                                                  2000), //DateTime.now() - not to allow to choose before today.
                                              lastDate: DateTime(2101));

                                      if (pickedDate != null) {
                                        print(
                                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);
                                        print(
                                            formattedDate); //formatted date output using intl package =>  2021-03-16
                                        //you can implement different kind of Date Format here according to your requirement

                                        setState(() {
                                          _dateController.text =
                                              formattedDate; //set output date to TextField value.
                                        });
                                      } else {
                                        print("Date is not selected");
                                      }
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                child: TextField(
                                  controller:
                                      _timeController, //editing controller of this TextField
                                  decoration: InputDecoration(
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.all(0.0),
                                      child: Icon(
                                        Icons.timer,
                                      ), // icon is 48px widget.
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    hintText: "Time",
                                  ),
                                  readOnly:
                                      true, //set it true, so that user will not able to edit text
                                  onTap: () async {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      initialTime: TimeOfDay.now(),
                                      context: context,
                                    );

                                    if (pickedTime != null) {
                                      print(pickedTime
                                          .format(context)); //output 10:51 PM
                                      DateTime parsedTime = DateFormat.jm()
                                          .parse(pickedTime
                                              .format(context)
                                              .toString());
                                      //converting to DateTime so that we can further format on different pattern.
                                      print(
                                          parsedTime); //output 1970-01-01 22:53:00.000
                                      String formattedTime = DateFormat('HH:mm')
                                          .format(parsedTime);
                                      print(formattedTime); //output 14:59:00
                                      //DateFormat() is from intl package, you can format the time on any pattern you need.

                                      setState(() {
                                        _timeController.text =
                                            formattedTime; //set the value of text field.
                                      });
                                    } else {
                                      print("Time is not selected");
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Link Group",
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _grupController,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "Enter",
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Deskripsi",
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 4,
                            controller: _deskripsiController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Tulis deskripsi",
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black)),
                            onPressed: submitTikum,
                            child: const Text('Submit'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.black12),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: _handleKembaliButton,
                  child: const Text(
                    "Kembali",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
