import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mimemo/ui/screens/radar/radar_cubit.dart';

class RadarTimeline extends StatelessWidget {
  const RadarTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RadarCubit>();

    return BlocSelector<RadarCubit, RadarState, (List<DateTime>, int, bool)>(
      selector: (s) => (s.timestamps, s.selectedTimestampIndex, s.isPlaying),
      builder: (context, data) {
        final (timestamps, index, isPlaying) = data;
        if (timestamps.isEmpty) return const SizedBox.shrink();

        final selected = timestamps[index];
        final isPast = selected.isBefore(DateTime.now().toUtc());

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: cubit.togglePlay,
              ),
              Expanded(
                child: Slider(
                  min: 0,
                  max: (timestamps.length - 1).toDouble(),
                  divisions: timestamps.length > 1
                      ? timestamps.length - 1
                      : null,
                  value: index.toDouble(),
                  activeColor: Colors.white,
                  onChanged: (v) => cubit.selectTimestampIndex(v.round()),
                ),
              ),
              SizedBox(
                width: 56,
                child: Text(
                  DateFormat('HH:mm').format(selected.toLocal()),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: isPast ? FontWeight.normal : FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
