import 'package:flutter/material.dart';
import 'package:gold_stream_app/src/gold/presentation/widgets/gold_header.dart';
import 'package:intl/intl.dart';
import 'package:gold_stream_app/src/gold/data/fake_gold_api.dart';

class GoldScreen extends StatelessWidget {
  const GoldScreen({super.key});
  @override
  Widget build(BuildContext context) {
    /// Platzhalter für den Goldpreis
    /// soll durch den Stream `getGoldPriceStream()` ersetzt werden
    double goldPrice = 69.22;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GoldHeader(),
              SizedBox(height: 20),
              Text(
                'Live Kurs:',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 20),
              // TODO: Verwende einen StreamBuilder, um den Goldpreis live anzuzeigen
              // statt des konstanten Platzhalters
              StreamBuilder<double>(
                stream: getGoldPriceStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(
                      'Fehler: ${snapshot.error}',
                      style: const TextStyle(color: Colors.redAccent),
                    );
                  }

                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }

                  final goldPrice = snapshot.data!;
                  return Text(
                    NumberFormat.simpleCurrency(
                      locale: 'de_DE',
                    ).format(goldPrice),
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
