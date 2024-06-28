import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_overflow/_util/extensions.dart';
import 'package:stack_overflow/module/brewary/controller/brewary_bloc.dart';
import 'package:stack_overflow/module/brewary/controller/brewary_state.dart';
import 'package:stack_overflow/module/brewary/controller/breway_event.dart';
import 'package:stack_overflow/module/brewary/view/scanner_view.dart';

class BrewaryUI extends StatelessWidget {
  const BrewaryUI({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BrewaryBloc()..add(GetbrewaryData(cityName: "India")),
      child: const BrewaryView(),
    );
  }
}

class BrewaryView extends StatefulWidget {
  const BrewaryView({super.key});

  @override
  State<BrewaryView> createState() => _BrewaryViewState();
}

class _BrewaryViewState extends State<BrewaryView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrewaryBloc, BrewaryState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text("Brewary Spot"), centerTitle: true),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: DropdownButton(
                  isExpanded: true,
                  value: state.countryName,
                  items: const [
                    DropdownMenuItem(value: "India", child: Text("India")),
                    DropdownMenuItem(value: "UK", child: Text("UK")),
                    DropdownMenuItem(value: "US", child: Text("US")),
                  ],
                  onChanged: (val) {
                    context
                        .read<BrewaryBloc>()
                        .add(GetbrewaryData(cityName: val!));
                  },
                ),
              ),
              const SizedBox(height: 8),
              state.isFetching
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: ListView.builder(
                        itemCount: state.brewaryDTO.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(state.brewaryDTO[index].toString()),
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.startToEnd) {
                                "Inside ".logIt;
                              }
                              return true;
                            },
                            onDismissed: (direction) {},
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.5),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Name: ${state.brewaryDTO[index].name}"),
                                  Text(
                                      "Brewary Type: ${state.brewaryDTO[index].brewaryType}"),
                                  Text(
                                      "Phone: ${state.brewaryDTO[index].phone}"),
                                  Text(
                                      "Postal Code: ${state.brewaryDTO[index].postalCode}")
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScannerView(),
                    ),
                  );
                },
                child: Text("Scanner View"),
              )
            ],
          ),
        );
      },
    );
  }
}
