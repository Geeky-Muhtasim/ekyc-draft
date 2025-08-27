class Branch {
  final String branchId;
  final String branchName;
  final int districtId;

  Branch({
    required this.branchId,
    required this.branchName,
    required this.districtId,
  });

  factory Branch.fromJson(Map<String, dynamic> j) => Branch(
        branchId: (j['branch_id'] ?? '').toString(),
        branchName: (j['branch_name'] ?? '').toString(),
        districtId: int.tryParse(j['district_id']?.toString() ?? '') ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'branch_id': branchId,
        'branch_name': branchName,
        'district_id': districtId,
      };

  @override
  String toString() => 'Branch($branchId, $branchName, $districtId)';
}
