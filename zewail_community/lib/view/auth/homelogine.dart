import 'package:flutter/material.dart';
import 'welcome.dart';
import '../../Core/Function/AlertExit.dart';
import 'component/customcomponent.dart';

class loginhome extends StatelessWidget {
  loginhome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          return showExitConfirmationDialog(context);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            color: const Color.fromARGB(255, 243, 238, 250),
            height: double.infinity,
            width: double.infinity,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "مرحبا بك قم باختيار طريقة الدخول",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Image.asset(
                            "assets/login.png",
                            width: constraints.maxWidth, // Adjust image width
                            height: 350,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          defaultButton(
                            function: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Welcome()));
                            },
                            text: "طالب",
                            width: constraints.maxWidth *
                                0.8, // Adjust button width
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          defaultButton(
                            function: () {
                              Navigator.pushNamed(context, "LoginTeacher");
                            },
                            text: "مدرس",
                            width: constraints.maxWidth *
                                0.8, // Adjust button width
                          ),

                          Spacer(), // Push everything to the top
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
