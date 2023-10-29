import 'package:big_fun_app/screens/view_all_events.dart';
import 'package:big_fun_app/screens/view_events_with_detail.dart';
import 'package:big_fun_app/screens/view_payment_successful.dart';
import 'package:big_fun_app/screens/view_purchase_tickets.dart';
import 'package:big_fun_app/views/payment_method_view.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/attendants/events',
  routes: [
    GoRoute(
      path: '/attendants/events',
      name: ViewAllEvents.name,
      builder: (context, state) => const ViewAllEvents(),
    ),
    GoRoute(
      path: '/attendants/events/:id',
      name: ViewEventsWithDetail.name,
      builder: (context, state) {
        final eventId = state.pathParameters['id'] ?? '';
        return ViewEventsWithDetail(eventId: eventId);
      },
    ),
    GoRoute(
      path: '/attendants/purchase-tickets/:id',
      name: ViewPurchaseTickets.name,
      builder: (context, state) {
        final eventId = state.pathParameters['id'] ?? '';
        return ViewPurchaseTickets(eventId: eventId);
      },
    ),
    GoRoute(
      path: '/payment-method-view',
      builder: (context, state) => const PaymentMethodView(),
    ),
    GoRoute(
      path: '/attendants/payment-successful/:id',
      name: ViewPaymentSuccessful.name,
      builder: (context, state) {
        final eventId = state.pathParameters['id'] ?? '';
        return ViewPaymentSuccessful(eventId: eventId);
      },
    ),
  ],
);
