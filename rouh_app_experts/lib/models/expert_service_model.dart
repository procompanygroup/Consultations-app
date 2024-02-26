class ExpertService {
  //Instance variables
  int? id;
  int? service_id;
  int? expert_id;
  int? points;
  double? expert_cost;
  int? cost_type;
  double? expert_cost_value;

  //Constructor
  ExpertService(
      { this.id, this.service_id, this.expert_id, this.points, this.expert_cost, this.cost_type, this.expert_cost_value,});

  factory ExpertService.fromJson(dynamic parsedJson) {
    return ExpertService(
        id: parsedJson['id'],
        service_id: parsedJson['service_id'],
        expert_id: parsedJson['expert_id'],
        points: parsedJson['points'],
        expert_cost: double.tryParse(parsedJson['expert_cost']),
        cost_type: parsedJson['cost_type'],
       expert_cost_value: double.tryParse(parsedJson['expert_cost_value']),
    );
  }

  // used  for convert a List of value
  static List<T> convertListToModel<T>(
      T Function(Map<String, dynamic> map) fromJson, List data) {
    return data.map((e) => fromJson((e as Map).cast())).toList();
  }
}