// class NomineeInfoState {
//   final String name;
//   final String fatherName;
//   final String motherName;
//   final String relationship;
//   final String dob;
//   final String nid;
//   final String? photoPath;

//   NomineeInfoState({
//     this.name = '',
//     this.fatherName = '',
//     this.motherName = '',
//     this.relationship = '',
//     this.dob = '',
//     this.nid = '',
//     this.photoPath,
//   });

//   NomineeInfoState copyWith({
//     String? name,
//     String? fatherName,
//     String? motherName,
//     String? relationship,
//     String? dob,
//     String? nid,
//     String? photoPath,
//   }) {
//     return NomineeInfoState(
//       name: name ?? this.name,
//       fatherName: fatherName ?? this.fatherName,
//       motherName: motherName ?? this.motherName,
//       relationship: relationship ?? this.relationship,
//       dob: dob ?? this.dob,
//       nid: nid ?? this.nid,
//       photoPath: photoPath ?? this.photoPath,
//     );
//   }
// }
// import 'dart:typed_data';

// class NomineeInfoState {
//   final String name;
//   final String fatherName;
//   final String motherName;
//   final String relationship;
//   final String dob;
//   final String nid;
//   final String address; // ✅ NEW
//   final String? photoPath; // for signature
//   final String? nomineePhotoPath; // ✅ NEW
//   final Uint8List? signatureBytes;

//   NomineeInfoState({
//     this.name = '',
//     this.fatherName = '',
//     this.motherName = '',
//     this.relationship = '',
//     this.dob = '',
//     this.nid = '',
//     this.address = '', // ✅ NEW
//     this.photoPath,
//     this.nomineePhotoPath, // ✅ NEW
//     this.signatureBytes,
//   });

//   NomineeInfoState copyWith({
//     String? name,
//     String? fatherName,
//     String? motherName,
//     String? relationship,
//     String? dob,
//     String? nid,
//     String? address,
//     String? photoPath,
//     String? nomineePhotoPath,
//     Uint8List? signatureBytes,
//   }) {
//     return NomineeInfoState(
//       name: name ?? this.name,
//       fatherName: fatherName ?? this.fatherName,
//       motherName: motherName ?? this.motherName,
//       relationship: relationship ?? this.relationship,
//       dob: dob ?? this.dob,
//       nid: nid ?? this.nid,
//       address: address ?? this.address,
//       photoPath: photoPath ?? this.photoPath,
//       nomineePhotoPath: nomineePhotoPath ?? this.nomineePhotoPath,
//       signatureBytes: signatureBytes ?? this.signatureBytes,
//     );
//   }
// }
import 'dart:typed_data';

class NomineeInfoState {
  final String name;
  final String fatherName;
  final String motherName;
  final String relationship;
  final String dob;
  final String nid;
  final String address;
  final String? photoPath;           // Drawn or uploaded signature
  final String? nomineePhotoPath;    // Uploaded nominee photo
  final Uint8List? signatureBytes;

  NomineeInfoState({
    this.name = '',
    this.fatherName = '',
    this.motherName = '',
    this.relationship = '',
    this.dob = '',
    this.nid = '',
    this.address = '',
    this.photoPath,
    this.nomineePhotoPath,
    this.signatureBytes,
  });

  NomineeInfoState copyWith({
    String? name,
    String? fatherName,
    String? motherName,
    String? relationship,
    String? dob,
    String? nid,
    String? address,
    String? photoPath,
    String? nomineePhotoPath,
    Uint8List? signatureBytes,
  }) {
    return NomineeInfoState(
      name: name ?? this.name,
      fatherName: fatherName ?? this.fatherName,
      motherName: motherName ?? this.motherName,
      relationship: relationship ?? this.relationship,
      dob: dob ?? this.dob,
      nid: nid ?? this.nid,
      address: address ?? this.address,
      photoPath: photoPath ?? this.photoPath,
      nomineePhotoPath: nomineePhotoPath ?? this.nomineePhotoPath,
      signatureBytes: signatureBytes ?? this.signatureBytes,
    );
  }
}

