import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:stack_overflow/module/phone_auth/controller/phone_auth_bloc.dart';
import 'package:stack_overflow/module/phone_auth/controller/phone_auth_event.dart';
import 'package:stack_overflow/module/phone_auth/controller/phone_auth_state.dart';

class PhoneAuthView extends StatefulWidget {
  const PhoneAuthView({super.key});

  @override
  State<PhoneAuthView> createState() => _PhoneAuthViewState();
}

class _PhoneAuthViewState extends State<PhoneAuthView> {
  final TextEditingController textEditingController = TextEditingController();
  final OtpFieldController otpFieldController = OtpFieldController();
  final GlobalKey key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneAuthBloc(),
      child: BlocBuilder<PhoneAuthBloc, PhoneAuthState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              appBar: AppBar(title: Text("Login"), centerTitle: true),
              body: Container(
                child: Column(
                  children: [
                    SizedBox(height: 60),
                    Text("Start Your Journey"),
                    SizedBox(height: 20),
                    state.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Visibility(
                              visible: !state.isOtpGenerated,
                              child: SizedBox(
                                height: 50,
                                child: TextFormField(
                                  key: key,
                                  controller: textEditingController,
                                  cursorHeight: 19,
                                  maxLength: 10,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(16),
                                      ),
                                    ),
                                    hintText: "Mobile Number",
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                  onChanged: (val) {
                                    context.read<PhoneAuthBloc>().add(
                                          ChangePhoneNumber(phoneNumber: val),
                                        );
                                  },
                                  style: TextStyle(fontSize: 16, height: 1.2),
                                ),
                              ),
                              replacement: OTPTextField(
                                controller: otpFieldController,
                                length: 6,
                                width: MediaQuery.of(context).size.width,
                                style: TextStyle(fontSize: 17),
                                textFieldAlignment:
                                    MainAxisAlignment.spaceAround,
                                onChanged: (value) {
                                  context
                                      .read<PhoneAuthBloc>()
                                      .add(ChangeOTP(value: value));
                                },
                              ),
                            ),
                          ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 0.5),
                      onPressed: () {
                        if (state.isOtpGenerated) {
                          context.read<PhoneAuthBloc>().add(
                                VerifyOTP(
                                  context: context,
                                ),
                              );
                          // if (state.signInSuccessfull == "Success") {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => HomeScreen(),
                          //   ),
                          // );
                          // }
                        } else {
                          context.read<PhoneAuthBloc>().add(VerifyPhoneEvent());
                        }
                      },
                      child: Text(state.isOtpGenerated ? "Verify" : "Login"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
