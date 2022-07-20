import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_au/cubits/auth/auth_cubit.dart';

import 'home_view.dart';

class VerifyPhoneNumberView extends StatelessWidget {
  VerifyPhoneNumberView({Key? key}) : super(key: key);

  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Phone Number'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: otpController,
                maxLength: 6,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "6-Digit OTP",
                  counterText: "",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthLoggedInState) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacement(context,
                        CupertinoPageRoute(builder: (context) => HomeView()));
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is AuthErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.red,
                      duration: Duration(milliseconds: 2000),
                    ));
                  }

                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CupertinoButton(
                      onPressed: () {
                        BlocProvider.of<AuthCubit>(context)
                            .verifyOTP(otpController.text);
                      },
                      color: Colors.blue,
                      child: Text("Sign In"),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
