import 'package:auto_route/auto_route.dart';
import 'package:fixitbhaiivendor/routes/app.routes.gr.dart';
import 'package:fixitbhaiivendor/views/service/serviceManagementScreen.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.custom();

  @override
  List<CustomRoute> get routes => [
        CustomRoute(
          initial: true,
          page: VendorDashboardRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300, // Increased duration
        ),
        CustomRoute(
          page: OrderDetailsRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300, // Increased duration
        ),
        CustomRoute(
          page: EarningsRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300, // Increased duration
        ),
        CustomRoute(
          page: OrderManagementRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300, // Increased duration
        ),

        CustomRoute(
          page: VendorProfileRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300, // Increased duration
        ),
        CustomRoute(
          page: AddEditRefurbishedItemRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300, // Increased duration
        ),
        CustomRoute(
          page: CustomerReviewsRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300, // Increased duration
        ),

        CustomRoute(
          page: AnalyticsRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300, // Increased duration
        ),
        //REFURBISHED........
        CustomRoute(
          page: RefurbishedItemsManagementRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300, // Increased duration
        ),
        CustomRoute(
          page: EditRefurbishedItemRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300, // Increased duration
        ),
        CustomRoute(
          page: AddEditRefurbishedItemRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300, // Increased duration
        ),
        //TECHNICIANS........
        CustomRoute(
          page: TechnicianManagementRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300, // Increased duration
        ),
        CustomRoute(
          page: AddEditTechnicianRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300, // Increased duration
        ),
        CustomRoute(
          page: EditTechnicianRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300, // Increased duration
        ),
        //SERVICES........
        CustomRoute(
          page: AddEditServiceRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300, // Increased duration
        ),
        CustomRoute(
          page: ServiceManagementRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300, // Increased duration
        ),
        CustomRoute(
          page: EditServiceRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300, // Increased duration
        ),
      ];
}
