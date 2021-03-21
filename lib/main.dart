import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';
import 'package:provider/provider.dart';
import 'package:sported_app/business_logic/cubits/filter_chips_cubit/filter_chips_cubit.dart';
import 'package:sported_app/data/repositories/booking_history_repository.dart';
import 'package:sported_app/data/repositories/venue_data_provider.dart';
import 'package:sported_app/data/repositories/venue_repository.dart';
import 'package:sported_app/helper/authenticate.dart';
import 'package:sported_app/locator.dart';
import 'package:sported_app/presentation/screens/payment_screen.dart';
import 'package:sported_app/services/authentication_service.dart';
import 'package:sported_app/simple_bloc_observer.dart';

import 'business_logic/blocs/filter_bloc/filter_bloc.dart';
import 'business_logic/cubits/booking_history_cubit/booking_history_cubit.dart';
import 'constants/constants.dart';
import 'data/repositories/booking_history_data_provider.dart';
import 'data/repositories/venue_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  MpesaFlutterPlugin.setConsumerKey(kConsumerKey);
  MpesaFlutterPlugin.setConsumerSecret(kConsumerSecret);
  setupServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final VenueRepository venueRepository = VenueRepository(venueDataProvider: VenueDataProvider());
    final BookingHistoryRepository bookingHistoryRepository =
        BookingHistoryRepository(bookingHistoryDataProvider: BookingHistoryDataProvider());
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(),
        ),
        StreamProvider(create: (context) => context.read<AuthenticationService>().authStateChanges),
      ],
      child: ScreenUtilInit(
        designSize: Size(414, 736),
        allowFontScaling: false,
        builder: () => MultiBlocProvider(
          providers: [
            BlocProvider<FilterBloc>(
              create: (_) => FilterBloc(venueRepository: venueRepository)..add(LoadFootball()),
            ),
            BlocProvider<FilterChipsCubit>(
              create: (_) => FilterChipsCubit(),
            ),
            BlocProvider<BookingHistoryCubit>(
                create: (_) =>
                    BookingHistoryCubit(bookingHistoryRepository: bookingHistoryRepository)
                      ..loadBookingHistory()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              canvasColor: Color(0xff31323B),
              appBarTheme: AppBarTheme(
                color: Color(0xff18181A),
                actionsIconTheme: IconThemeData(
                  color: Color(0xffBABABB),
                ),
                iconTheme: IconThemeData(
                  color: Color(0xffBABABB),
                ),
                elevation: 0.0,
                brightness: Brightness.dark,
                centerTitle: true,
              ),
              accentColor: Color(0xff2F4826),
              splashColor: Colors.transparent,
              highlightColor: Color(0x1a2f4826),
              scaffoldBackgroundColor: Color(0xff18181A),
            ),
            home: Authenticate(),
          ),
        ),
      ),
    );
  }
}
