import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_au/cubits/auth/auth_cubit.dart';
import 'package:phone_au/view/sign_in_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLoggedOutState) {
                  Navigator.popUntil(context, (route) => route.isFirst);

                  Navigator.pushReplacement(context,
                      CupertinoPageRoute(builder: (context) => SignInScreen()));
                }
              },
              builder: (context, state) {
                return CupertinoButton(
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context).logOut();
                  },
                  child: Text('Logout'),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
