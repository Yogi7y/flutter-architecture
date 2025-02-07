import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/colors/theme.dart';
import '../../../../core/theme/typography/typography.dart';
import '../../domain/repository/order_repository.dart';
import '../state/orders_provider.dart';
import '../widgets/order_list_header.dart';
import '../widgets/order_list_item.dart';

class OrderListScreen extends ConsumerWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final orders = ref.watch(groupedOrdersProvider);

    return Scaffold(
      backgroundColor: theme.surface0,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: orders.when(
          data: (groupedOrders) => _OrderListDataState(groupedOrders: groupedOrders),
          error: (error, stack) => Text(error.toString()),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

class _OrderListDataState extends ConsumerWidget {
  const _OrderListDataState({
    required this.groupedOrders,
  });

  final Map<String, Orders> groupedOrders;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = <Widget>[];
    final fonts = ref.watch(fontsProvider);

    for (final entry in groupedOrders.entries) {
      list
        ..add(SliverList.list(children: [Text(entry.key, style: fonts.label1)]))
        ..add(const SliverToBoxAdapter(child: SizedBox(height: 8)))
        ..add(
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ProviderScope(
                overrides: [
                  scopedOrderProvider.overrideWithValue(entry.value[index]),
                ],
                child: OrderListItem(order: entry.value[index]),
              ),
              childCount: entry.value.length,
            ),
          ),
        )
        ..add(const SliverToBoxAdapter(child: SizedBox(height: 24)));
    }

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: OrdersHeader()),
        ...list,
      ],
    );
  }
}
