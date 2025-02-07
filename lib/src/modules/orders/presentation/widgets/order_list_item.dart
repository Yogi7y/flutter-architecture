import 'dart:developer' as developer;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/colors/theme.dart';
import '../../../../core/theme/typography/typography.dart';
import '../../domain/entity/order.dart';
import '../state/orders_provider.dart';

class OrderListItem extends ConsumerWidget {
  const OrderListItem({super.key, required Order order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final font = ref.watch(fontsProvider);
    final theme = ref.watch(themeProvider);
    final order = ref.watch(scopedOrderProvider);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => developer.log('Order item tapped: ${order.id}'),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProductLeadingImage(),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.merchant.name,
                    style: font.label1,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    order.paymentProductType.displayText,
                    style: font.caption1,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${order.amount.currency} ${order.amount.value}',
                  style: font.label2,
                ),
                Text(
                  order.status.displayText,
                  style: font.caption1.copyWith(color: theme.statusColor),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ProductLeadingImage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(scopedOrderProvider);
    final theme = ref.watch(themeProvider);

    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: CachedNetworkImage(
        imageUrl: order.merchant.logo,
        fit: BoxFit.cover,
        placeholder: (context, url) => ColoredBox(color: theme.neutral200),
        errorWidget: (context, url, error) => ColoredBox(
          color: theme.neutral200,
          child: Icon(
            Icons.error,
            size: 20,
            color: theme.textSecondary.withValues(alpha: .6),
          ),
        ),
      ),
    );
  }
}
