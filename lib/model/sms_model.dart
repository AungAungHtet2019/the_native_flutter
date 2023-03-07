class SmsModel {
  SmsModel({
    required this.status,
    required this.data,
  });
  late final bool status;
  late final Data data;

  SmsModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.messages,
    required this.balance,
    required this.credit,
  });
  late final List<Messages> messages;
  late final int balance;
  late final int credit;

  Data.fromJson(Map<String, dynamic> json){
    messages = List.from(json['messages']).map((e)=>Messages.fromJson(e)).toList();
    balance = json['balance'];
    credit = json['credit'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['messages'] = messages.map((e)=>e.toJson()).toList();
    _data['balance'] = balance;
    _data['credit'] = credit;
    return _data;
  }
}

class Messages {
  Messages({
    required this.id,
    required this.createAt,
    required this.messageTo,
    required this.messageText,
    required this.operator,
    required this.sender,
    required this.isDelivered,
    required this.isQueuing,
    required this.test,
    required this.numParts,
    required this.credit,
  });
  late final int id;
  late final int createAt;
  late final String messageTo;
  late final String messageText;
  late final String operator;
  late final String sender;
  late final bool isDelivered;
  late final bool isQueuing;
  late final bool test;
  late final int numParts;
  late final int credit;

  Messages.fromJson(Map<String, dynamic> json){
    id = json['id'];
    createAt = json['create_at'];
    messageTo = json['message_to'];
    messageText = json['message_text'];
    operator = json['operator'];
    sender = json['sender'];
    isDelivered = json['is_delivered'];
    isQueuing = json['is_queuing'];
    test = json['test'];
    numParts = json['num_parts'];
    credit = json['credit'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['create_at'] = createAt;
    _data['message_to'] = messageTo;
    _data['message_text'] = messageText;
    _data['operator'] = operator;
    _data['sender'] = sender;
    _data['is_delivered'] = isDelivered;
    _data['is_queuing'] = isQueuing;
    _data['test'] = test;
    _data['num_parts'] = numParts;
    _data['credit'] = credit;
    return _data;
  }
}