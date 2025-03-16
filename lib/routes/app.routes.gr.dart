// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i17;
import 'package:fixitbhaiivendor/views/analytics/analyticsScreen.dart' as _i4;
import 'package:fixitbhaiivendor/views/dashboardScreen.dart' as _i15;
import 'package:fixitbhaiivendor/views/earningScreen.dart' as _i6;
import 'package:fixitbhaiivendor/views/order/orderDetailScreen.dart' as _i10;
import 'package:fixitbhaiivendor/views/order/orderManagementScreen.dart' as _i11;
import 'package:fixitbhaiivendor/views/refurbishedItem/addRefurbishedItemScreen.dart'
    as _i1;
import 'package:fixitbhaiivendor/views/refurbishedItem/editRefurbishedItemScreen.dart'
    as _i7;
import 'package:fixitbhaiivendor/views/refurbishedItem/refurbishedItemManagement.dart'
    as _i12;
import 'package:fixitbhaiivendor/views/reviewScreen.dart' as _i5;
import 'package:fixitbhaiivendor/views/service/addServiceScreen.dart' as _i2;
import 'package:fixitbhaiivendor/views/service/editServiceScreen.dart' as _i8;
import 'package:fixitbhaiivendor/views/service/serviceManagementScreen.dart'
    as _i13;
import 'package:fixitbhaiivendor/views/technician/addTechniciansScreen.dart'
    as _i3;
import 'package:fixitbhaiivendor/views/technician/editTechnicianScreen.dart'
    as _i9;
import 'package:fixitbhaiivendor/views/technician/technicianManagementScreen.dart'
    as _i14;
import 'package:fixitbhaiivendor/views/profile/vendorProfileScreen.dart' as _i16;
import 'package:flutter/material.dart' as _i18;

/// generated route for
/// [_i1.AddEditRefurbishedItemScreen]
class AddEditRefurbishedItemRoute
    extends _i17.PageRouteInfo<AddEditRefurbishedItemRouteArgs> {
  AddEditRefurbishedItemRoute({
    Map<String, dynamic>? existingItem,
    _i18.Key? key,
    List<_i17.PageRouteInfo>? children,
  }) : super(
         AddEditRefurbishedItemRoute.name,
         args: AddEditRefurbishedItemRouteArgs(
           existingItem: existingItem,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'AddEditRefurbishedItemRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddEditRefurbishedItemRouteArgs>(
        orElse: () => const AddEditRefurbishedItemRouteArgs(),
      );
      return _i1.AddEditRefurbishedItemScreen(
        existingItem: args.existingItem,
        key: args.key,
      );
    },
  );
}

class AddEditRefurbishedItemRouteArgs {
  const AddEditRefurbishedItemRouteArgs({this.existingItem, this.key});

  final Map<String, dynamic>? existingItem;

  final _i18.Key? key;

  @override
  String toString() {
    return 'AddEditRefurbishedItemRouteArgs{existingItem: $existingItem, key: $key}';
  }
}

/// generated route for
/// [_i2.AddEditServiceScreen]
class AddEditServiceRoute extends _i17.PageRouteInfo<AddEditServiceRouteArgs> {
  AddEditServiceRoute({
    Map<String, dynamic>? existingService,
    List<_i17.PageRouteInfo>? children,
  }) : super(
         AddEditServiceRoute.name,
         args: AddEditServiceRouteArgs(existingService: existingService),
         initialChildren: children,
       );

  static const String name = 'AddEditServiceRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddEditServiceRouteArgs>(
        orElse: () => const AddEditServiceRouteArgs(),
      );
      return _i2.AddEditServiceScreen(existingService: args.existingService);
    },
  );
}

class AddEditServiceRouteArgs {
  const AddEditServiceRouteArgs({this.existingService});

  final Map<String, dynamic>? existingService;

  @override
  String toString() {
    return 'AddEditServiceRouteArgs{existingService: $existingService}';
  }
}

/// generated route for
/// [_i3.AddEditTechnicianScreen]
class AddEditTechnicianRoute
    extends _i17.PageRouteInfo<AddEditTechnicianRouteArgs> {
  AddEditTechnicianRoute({
    _i18.Key? key,
    Map<String, dynamic>? existingTechnician,
    List<_i17.PageRouteInfo>? children,
  }) : super(
         AddEditTechnicianRoute.name,
         args: AddEditTechnicianRouteArgs(
           key: key,
           existingTechnician: existingTechnician,
         ),
         initialChildren: children,
       );

  static const String name = 'AddEditTechnicianRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddEditTechnicianRouteArgs>(
        orElse: () => const AddEditTechnicianRouteArgs(),
      );
      return _i3.AddEditTechnicianScreen(
        key: args.key,
        existingTechnician: args.existingTechnician,
      );
    },
  );
}

class AddEditTechnicianRouteArgs {
  const AddEditTechnicianRouteArgs({this.key, this.existingTechnician});

  final _i18.Key? key;

  final Map<String, dynamic>? existingTechnician;

  @override
  String toString() {
    return 'AddEditTechnicianRouteArgs{key: $key, existingTechnician: $existingTechnician}';
  }
}

/// generated route for
/// [_i4.AnalyticsScreen]
class AnalyticsRoute extends _i17.PageRouteInfo<void> {
  const AnalyticsRoute({List<_i17.PageRouteInfo>? children})
    : super(AnalyticsRoute.name, initialChildren: children);

  static const String name = 'AnalyticsRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i4.AnalyticsScreen();
    },
  );
}

/// generated route for
/// [_i5.CustomerReviewsScreen]
class CustomerReviewsRoute extends _i17.PageRouteInfo<void> {
  const CustomerReviewsRoute({List<_i17.PageRouteInfo>? children})
    : super(CustomerReviewsRoute.name, initialChildren: children);

  static const String name = 'CustomerReviewsRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i5.CustomerReviewsScreen();
    },
  );
}

/// generated route for
/// [_i6.EarningsScreen]
class EarningsRoute extends _i17.PageRouteInfo<void> {
  const EarningsRoute({List<_i17.PageRouteInfo>? children})
    : super(EarningsRoute.name, initialChildren: children);

  static const String name = 'EarningsRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return _i6.EarningsScreen();
    },
  );
}

/// generated route for
/// [_i7.EditRefurbishedItemScreen]
class EditRefurbishedItemRoute
    extends _i17.PageRouteInfo<EditRefurbishedItemRouteArgs> {
  EditRefurbishedItemRoute({
    _i18.Key? key,
    required Map<String, dynamic> itemData,
    List<_i17.PageRouteInfo>? children,
  }) : super(
         EditRefurbishedItemRoute.name,
         args: EditRefurbishedItemRouteArgs(key: key, itemData: itemData),
         initialChildren: children,
       );

  static const String name = 'EditRefurbishedItemRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditRefurbishedItemRouteArgs>();
      return _i7.EditRefurbishedItemScreen(
        key: args.key,
        itemData: args.itemData,
      );
    },
  );
}

class EditRefurbishedItemRouteArgs {
  const EditRefurbishedItemRouteArgs({this.key, required this.itemData});

  final _i18.Key? key;

  final Map<String, dynamic> itemData;

  @override
  String toString() {
    return 'EditRefurbishedItemRouteArgs{key: $key, itemData: $itemData}';
  }
}

/// generated route for
/// [_i8.EditServiceScreen]
class EditServiceRoute extends _i17.PageRouteInfo<EditServiceRouteArgs> {
  EditServiceRoute({
    required Map<String, dynamic> serviceData,
    List<_i17.PageRouteInfo>? children,
  }) : super(
         EditServiceRoute.name,
         args: EditServiceRouteArgs(serviceData: serviceData),
         initialChildren: children,
       );

  static const String name = 'EditServiceRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditServiceRouteArgs>();
      return _i8.EditServiceScreen(serviceData: args.serviceData);
    },
  );
}

class EditServiceRouteArgs {
  const EditServiceRouteArgs({required this.serviceData});

  final Map<String, dynamic> serviceData;

  @override
  String toString() {
    return 'EditServiceRouteArgs{serviceData: $serviceData}';
  }
}

/// generated route for
/// [_i9.EditTechnicianScreen]
class EditTechnicianRoute extends _i17.PageRouteInfo<EditTechnicianRouteArgs> {
  EditTechnicianRoute({
    _i18.Key? key,
    required Map<String, dynamic> technicianData,
    List<_i17.PageRouteInfo>? children,
  }) : super(
         EditTechnicianRoute.name,
         args: EditTechnicianRouteArgs(
           key: key,
           technicianData: technicianData,
         ),
         initialChildren: children,
       );

  static const String name = 'EditTechnicianRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditTechnicianRouteArgs>();
      return _i9.EditTechnicianScreen(
        key: args.key,
        technicianData: args.technicianData,
      );
    },
  );
}

class EditTechnicianRouteArgs {
  const EditTechnicianRouteArgs({this.key, required this.technicianData});

  final _i18.Key? key;

  final Map<String, dynamic> technicianData;

  @override
  String toString() {
    return 'EditTechnicianRouteArgs{key: $key, technicianData: $technicianData}';
  }
}

/// generated route for
/// [_i10.OrderDetailsScreen]
class OrderDetailsRoute extends _i17.PageRouteInfo<OrderDetailsRouteArgs> {
  OrderDetailsRoute({
    _i18.Key? key,
    required Map<String, dynamic> order,
    List<_i17.PageRouteInfo>? children,
  }) : super(
         OrderDetailsRoute.name,
         args: OrderDetailsRouteArgs(key: key, order: order),
         initialChildren: children,
       );

  static const String name = 'OrderDetailsRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OrderDetailsRouteArgs>();
      return _i10.OrderDetailsScreen(key: args.key, order: args.order);
    },
  );
}

class OrderDetailsRouteArgs {
  const OrderDetailsRouteArgs({this.key, required this.order});

  final _i18.Key? key;

  final Map<String, dynamic> order;

  @override
  String toString() {
    return 'OrderDetailsRouteArgs{key: $key, order: $order}';
  }
}

/// generated route for
/// [_i11.OrderManagementScreen]
class OrderManagementRoute extends _i17.PageRouteInfo<void> {
  const OrderManagementRoute({List<_i17.PageRouteInfo>? children})
    : super(OrderManagementRoute.name, initialChildren: children);

  static const String name = 'OrderManagementRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i11.OrderManagementScreen();
    },
  );
}

/// generated route for
/// [_i12.RefurbishedItemsManagementScreen]
class RefurbishedItemsManagementRoute extends _i17.PageRouteInfo<void> {
  const RefurbishedItemsManagementRoute({List<_i17.PageRouteInfo>? children})
    : super(RefurbishedItemsManagementRoute.name, initialChildren: children);

  static const String name = 'RefurbishedItemsManagementRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i12.RefurbishedItemsManagementScreen();
    },
  );
}

/// generated route for
/// [_i13.ServiceManagementScreen]
class ServiceManagementRoute extends _i17.PageRouteInfo<void> {
  const ServiceManagementRoute({List<_i17.PageRouteInfo>? children})
    : super(ServiceManagementRoute.name, initialChildren: children);

  static const String name = 'ServiceManagementRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return _i13.ServiceManagementScreen();
    },
  );
}

/// generated route for
/// [_i14.TechnicianManagementScreen]
class TechnicianManagementRoute extends _i17.PageRouteInfo<void> {
  const TechnicianManagementRoute({List<_i17.PageRouteInfo>? children})
    : super(TechnicianManagementRoute.name, initialChildren: children);

  static const String name = 'TechnicianManagementRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return _i14.TechnicianManagementScreen();
    },
  );
}

/// generated route for
/// [_i15.VendorDashboardScreen]
class VendorDashboardRoute extends _i17.PageRouteInfo<void> {
  const VendorDashboardRoute({List<_i17.PageRouteInfo>? children})
    : super(VendorDashboardRoute.name, initialChildren: children);

  static const String name = 'VendorDashboardRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i15.VendorDashboardScreen();
    },
  );
}

/// generated route for
/// [_i16.VendorProfileScreen]
class VendorProfileRoute extends _i17.PageRouteInfo<void> {
  const VendorProfileRoute({List<_i17.PageRouteInfo>? children})
    : super(VendorProfileRoute.name, initialChildren: children);

  static const String name = 'VendorProfileRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i16.VendorProfileScreen();
    },
  );
}
