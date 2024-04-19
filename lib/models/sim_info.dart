import 'dart:convert';

class SimInfoM {
  final String number;
  final String country;
  final String? mcc;
  final int? cardId;
  final int? carrierId;
  final String? groupUuid;
  final String? mncStr;
  final int? subscriptionType;
  final int? portIndex;
  final int? usageSetting;
  final int slotIndex;
  final int roamingData;
  final String carrierName;
  final String displayName;
  final String iccId;
  final int mccInt;
  final int subscriptionId;
  SimInfoM({
    required this.number,
    required this.country,
    this.mcc,
    this.cardId,
    this.carrierId,
    this.groupUuid,
    this.mncStr,
    this.subscriptionType,
    this.portIndex,
    this.usageSetting,
    required this.slotIndex,
    required this.roamingData,
    required this.carrierName,
    required this.displayName,
    required this.iccId,
    required this.mccInt,
    required this.subscriptionId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'number': number,
      'country': country,
      'mcc': mcc,
      'cardId': cardId,
      'carrierId': carrierId,
      'groupUuid': groupUuid,
      'mncStr': mncStr,
      'subscriptionType': subscriptionType,
      'portIndex': portIndex,
      'usageSetting': usageSetting,
      'slotIndex': slotIndex,
      'roamingData': roamingData,
      'carrierName': carrierName,
      'displayName': displayName,
      'iccId': iccId,
      'mccInt': mccInt,
      'subscriptionId': subscriptionId,
    };
  }

  factory SimInfoM.fromMap(Map<String, dynamic> map) {
    return SimInfoM(
      number: map['number'] ?? "",
      country: map['country'] ?? "",
      mcc: map['mcc'] != null ? map['mcc'] as String : null,
      cardId: map['cardId'] != null ? map['cardId'] as int : null,
      carrierId: map['carrierId'] != null ? map['carrierId'] as int : null,
      groupUuid: map['groupUuid'] != null ? map['groupUuid'] as String : null,
      mncStr: map['mncStr'] != null ? map['mncStr'] as String : null,
      subscriptionType: map['subscriptionType'] != null
          ? map['subscriptionType'] as int
          : null,
      portIndex: map['portIndex'] != null ? map['portIndex'] as int : null,
      usageSetting:
          map['usageSetting'] != null ? map['usageSetting'] as int : null,
      slotIndex: map['slotIndex'] ?? 0,
      roamingData: map['roamingData'] ?? 0,
      carrierName: map['carrierName'] ?? "",
      displayName: map['displayName'] ?? "",
      iccId: map['iccId'] ?? "",
      mccInt: map['mccInt'] ?? 0,
      subscriptionId: map['subscriptionId'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SimInfoM.fromJson(String source) =>
      SimInfoM.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SimInfoM(number: $number, country: $country, mcc: $mcc, cardId: $cardId, carrierId: $carrierId, groupUuid: $groupUuid, mncStr: $mncStr, subscriptionType: $subscriptionType, portIndex: $portIndex, usageSetting: $usageSetting, slotIndex: $slotIndex, roamingData: $roamingData, carrierName: $carrierName, displayName: $displayName, iccId: $iccId, mccInt: $mccInt, subscriptionId: $subscriptionId)';
  }
}
