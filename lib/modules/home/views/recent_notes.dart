
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/note.dart';
import '../../../widgets/note_card.dart';
import '../cubit/note/note_cubit.dart';
import 'views.dart';


class RecentNotes extends StatelessWidget {
  const RecentNotes({super.key});

  @override
  Widget build(BuildContext context) {
    final noteCubit = context.read<NoteCubit>();
    return BlocSelector<NoteCubit, NoteState, List<Note>>(
      selector: (state) => state.notes,
      builder: (context, notes) {
        return ListView.builder(
          itemCount: notes.isEmpty ? 0 : (notes.length >= 5 ? 5 : notes.length),
          itemBuilder: (context, index) {
            final note = notes[index];
            final date =
                "${notes[index].dateAdded?.hour}:${notes[index].dateAdded?.minute}";
            return NoteCard(
              title: note.title,
              content: note.content,
              time: date,
              removeOnPress: () {
                noteCubit.remove(note.id);
              },
              editOnTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewNote(note: note),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
