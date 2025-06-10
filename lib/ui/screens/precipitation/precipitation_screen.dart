import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/ui/screens/precipitation/precipitation_cubit.dart';

@RoutePage()
class PrecipitationScreen extends StatelessWidget {
  const PrecipitationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PrecipitationCubit(),
      child: const PrecipitationView(),
    );
  }
}

class PrecipitationView extends StatefulWidget {
  const PrecipitationView({super.key});

  @override
  State<PrecipitationView> createState() => _PrecipitationViewState();
}

class _PrecipitationViewState extends State<PrecipitationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MinuteCast'),
      ),
    );
  }
}
