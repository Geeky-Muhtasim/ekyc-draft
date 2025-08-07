// abstract class NomineeInfoEvent {}

// class UpdateNomineeField extends NomineeInfoEvent {
//   final String field;
//   final String value;
//   UpdateNomineeField(this.field, this.value);
// }

// class UpdateNomineePhoto extends NomineeInfoEvent {
//   final String photoPath;
//   UpdateNomineePhoto(this.photoPath);
// }

// class UpdatePhotoPath extends NomineeInfoEvent {
//   final String path;
//   UpdatePhotoPath(this.path);
// }
// import 'dart:typed_data';

// abstract class NomineeInfoEvent {}

// class UpdateNomineeField extends NomineeInfoEvent {
//   final String field;
//   final String value;
//   UpdateNomineeField(this.field, this.value);
// }

// class UpdateNomineePhoto extends NomineeInfoEvent {
//   final String photoPath;
//   UpdateNomineePhoto(this.photoPath);
// }

// class UpdatePhotoPath extends NomineeInfoEvent {
//   final String path;
//   UpdatePhotoPath(this.path);
// }

// class UpdateSignatureBytes extends NomineeInfoEvent {
//   final Uint8List? bytes;
//   UpdateSignatureBytes(this.bytes);
// }
// class UpdateNomineeImagePath extends NomineeInfoEvent {
//   final String nomineePhotoPath;
//   UpdateNomineeImagePath(this.nomineePhotoPath);
// }
import 'dart:typed_data';

abstract class NomineeInfoEvent {}

class UpdateNomineeField extends NomineeInfoEvent {
  final String field;
  final String value;
  UpdateNomineeField(this.field, this.value);
}

class UpdatePhotoPath extends NomineeInfoEvent {
  final String path; // For signature image
  UpdatePhotoPath(this.path);
}

class UpdateNomineeImagePath extends NomineeInfoEvent {
  final String nomineePhotoPath; // For nominee's photo
  UpdateNomineeImagePath(this.nomineePhotoPath);
}

class UpdateSignatureBytes extends NomineeInfoEvent {
  final Uint8List? bytes;
  UpdateSignatureBytes(this.bytes);
}
