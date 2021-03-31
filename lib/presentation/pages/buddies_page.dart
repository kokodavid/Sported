import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sported_app/business_logic/blocs/auth/authentication_bloc.dart';
import 'package:sported_app/data/services/authentication_service.dart';
import 'package:sported_app/presentation/shared/authenticate.dart';

class BuddiesPage extends StatefulWidget {
  final scaffoldKey;

  const BuddiesPage({Key key, this.scaffoldKey}) : super(key: key);
  @override
  _BuddiesPageState createState() => _BuddiesPageState();
}

class _BuddiesPageState extends State<BuddiesPage> {
  bool isLoggingOut = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                height: 40.h,
                color: Color(0x1AF44336),
                minWidth: 112.w,
                padding: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Color(0x80F44336),
                    width: 1.5.w,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                elevation: 0.0,
                hoverElevation: 0,
                disabledElevation: 0,
                highlightElevation: 0,
                focusElevation: 0,
                child: isLoggingOut == false
                    ? Text(
                        'Log Out',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                        ),
                      )
                    : Container(
                        width: 24.h,
                        height: 24.h,
                        child: SpinKitRipple(
                          color: Colors.black,
                        ),
                      ),
                onPressed: () async {
                  final logmessage = await context.read<AuthenticationService>().signOut();
                  if (logmessage == "Signed Out Successfully") {
                    BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLogoutRequested());
                    // await showCustomSnackbar("Signing Out...", widget.scaffoldKey);
                    Future.delayed(Duration(seconds: 2), () {
                      // 5s over, navigate
                      Navigator.of(context).pushReplacement(
                        Authenticate.route(),
                      );
                    });
                  } else {
                    // showCustomSnackbar("Signing Out Failed", widget.scaffoldKey);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
