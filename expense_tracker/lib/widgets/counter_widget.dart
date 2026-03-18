import 'package:expense_tracker/providers/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var cont = context.read<CounterProvider>();
    return Container(
      decoration: BoxDecoration(color: Colors.amber),
      child: Column(
        children: [
          // Consumer<CounterProvider>(
          //   builder: (context, counter, child) {
          //     child = OutlinedButton(
          //       onPressed: () => counter.incrementCounter(),
          //       child: const Icon(Icons.add),
          //     );

          //     return Column(
          //       children: [
          //         child,
          //         Text(
          //           "Current coutner is ${counter.count}",
          //         ),
          //       ],
          //     );
          //   },
          // ),
          Consumer<CounterProvider>(
            builder: (context, counters, child) => Column(
              children: [
                child!,
                Text(
                  "Current coutner is ${counters.count}",
                ),
              ],
            ),

            child: OutlinedButton(
              // onPressed: () => cont.incrementCounter(),
              onPressed: () => Provider.of<CounterProvider>(
                context,
                listen: false,
              ).incrementCounter(),

              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
