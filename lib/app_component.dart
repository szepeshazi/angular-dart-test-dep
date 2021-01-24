import 'package:angular/angular.dart';
import 'package:test_deps/environment.dart';

@Component(
    selector: 'my-app',
    template: '<outer></outer>',
    directives: [OuterComponent],
    providers: [ValueProvider.forToken(isTestEnvironment, false)])
class AppComponent {}

@Component(selector: 'outer', template: '<div>I am outer</div><inner></inner>', directives: [InnerComponent])
class OuterComponent {}

@Component(selector: 'inner', template: '<p>I am inner</p><p>Service says: {{serviceResult}}</p>', providers: [
  FactoryProvider(SomeService, serviceFactory, deps: [isTestEnvironment])
])
class InnerComponent implements OnInit {
  String serviceResult = 'Loading';

  final SomeService svc;

  InnerComponent(this.svc) {
    print('${svc.runtimeType}');
  }

  @override
  Future<void> ngOnInit() async {
    serviceResult = await svc.call();
  }
}

// Services
SomeService serviceFactory(bool testEnvironment) => testEnvironment ? FakeServiceImpl() : SomeServiceImpl();

abstract class SomeService {
  Future<String> call();
}

class SomeServiceImpl implements SomeService {
  @override
  Future<String> call() async => 'Real service';
}

class FakeServiceImpl implements SomeService {
  @override
  Future<String> call() async => 'Fake service';
}