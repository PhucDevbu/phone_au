import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_au/cubits/auth/auth_cubit.dart';
import 'package:phone_au/view/verify_phone_number_view.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in with Phone'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: phoneController,
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Phone Number",
                  counterText: "",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthCodeSentState) {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => VerifyPhoneNumberView()));
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CupertinoButton(
                      onPressed: () {
                        String phoneNumber = "+84" + phoneController.text;
                        BlocProvider.of<AuthCubit>(context)
                            .sendOTP(phoneNumber);
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
