import 'package:hiredstep/domain/models/status.dart';

import '../domain/models/stage.dart';

const List<Status> defaultStatuses = [
  Status(id: 'saved', name: 'Saved', stage: Stage.saved),
  Status(id: 'applied', name: 'Applied', stage: Stage.applied),
  Status(id: 'interview', name: 'Interview', stage: Stage.inProcess),
  Status(id: 'technical-test', name: 'Technical Test', stage: Stage.inProcess),
  Status(id: 'offering', name: 'Offering', stage: Stage.offering),
  Status(id: 'accepted', name: 'Accepted', stage: Stage.closed),
  Status(id: 'rejected', name: 'Rejected', stage: Stage.closed),
  Status(id: 'withdrawn', name: 'Withdrawn', stage: Stage.closed),
];
