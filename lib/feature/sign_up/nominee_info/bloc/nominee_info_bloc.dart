// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'nominee_info_event.dart';
// import 'nominee_info_state.dart';

// class NomineeInfoBloc extends Bloc<NomineeInfoEvent, NomineeInfoState> {
//   NomineeInfoBloc() : super(NomineeInfoState()) {
//     on<UpdateNomineeField>((event, emit) {
//       switch (event.field) {
//         case 'name':
//           emit(state.copyWith(name: event.value));
//           break;
//         case 'father':
//           emit(state.copyWith(fatherName: event.value));
//           break;
//         case 'mother':
//           emit(state.copyWith(motherName: event.value));
//           break;
//         case 'relationship':
//           emit(state.copyWith(relationship: event.value));
//           break;
//         case 'dob':
//           emit(state.copyWith(dob: event.value));
//           break;
//         case 'nid':
//           emit(state.copyWith(nid: event.value));
//           break;
//       }
//     });

//     on<UpdateNomineePhoto>((event, emit) {
//       emit(state.copyWith(photoPath: event.photoPath));
//     });
    
//     on<UpdatePhotoPath>((event, emit) {
//       emit(state.copyWith(photoPath: event.path));
//     });
//   }
// }
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'nominee_info_event.dart';
// import 'nominee_info_state.dart';

// class NomineeInfoBloc extends Bloc<NomineeInfoEvent, NomineeInfoState> {
//   NomineeInfoBloc() : super(NomineeInfoState()) {
//     on<UpdateNomineeField>((event, emit) {
//       switch (event.field) {
//         case 'name':
//           emit(state.copyWith(name: event.value));
//           break;
//         case 'father':
//           emit(state.copyWith(fatherName: event.value));
//           break;
//         case 'mother':
//           emit(state.copyWith(motherName: event.value));
//           break;
//         case 'relationship':
//           emit(state.copyWith(relationship: event.value));
//           break;
//         case 'dob':
//           emit(state.copyWith(dob: event.value));
//           break;
//         case 'nid':
//           emit(state.copyWith(nid: event.value));
//           break;
//       }
//     });

//     on<UpdateNomineePhoto>((event, emit) {
//       emit(state.copyWith(photoPath: event.photoPath));
//     });

//     on<UpdatePhotoPath>((event, emit) {
//       emit(state.copyWith(photoPath: event.path));
//     });

//     on<UpdateSignatureBytes>((event, emit) {
//       emit(state.copyWith(signatureBytes: event.bytes));
//     });
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';
import 'nominee_info_event.dart';
import 'nominee_info_state.dart';

class NomineeInfoBloc extends Bloc<NomineeInfoEvent, NomineeInfoState> {
  NomineeInfoBloc() : super(NomineeInfoState()) {
    on<UpdateNomineeField>((event, emit) {
      switch (event.field) {
        case 'name':
          emit(state.copyWith(name: event.value));
          break;
        case 'father':
          emit(state.copyWith(fatherName: event.value));
          break;
        case 'mother':
          emit(state.copyWith(motherName: event.value));
          break;
        case 'relationship':
          emit(state.copyWith(relationship: event.value));
          break;
        case 'dob':
          emit(state.copyWith(dob: event.value));
          break;
        case 'nid':
          emit(state.copyWith(nid: event.value));
          break;
        case 'address':
          emit(state.copyWith(address: event.value));
          break;
      }
    });

    on<UpdatePhotoPath>((event, emit) {
      emit(state.copyWith(photoPath: event.path));
    });

    on<UpdateNomineeImagePath>((event, emit) {
      emit(state.copyWith(nomineePhotoPath: event.nomineePhotoPath));
    });

    on<UpdateSignatureBytes>((event, emit) {
      emit(state.copyWith(signatureBytes: event.bytes));
    });
  }
}
