import 'package:angular/angular.dart';
@TestOn('browser')
import 'package:angular_test/angular_test.dart';
import 'package:test/test.dart';
import 'package:test_deps/app_component.dart';
import 'package:test_deps/app_component.template.dart' as ng;
import 'package:test_deps/environment.dart';
import 'app_test.template.dart' as self;

@GenerateInjector([
  ValueProvider.forToken(isTestEnvironment, true),
])
final InjectorFactory rootInjector = self.rootInjector$Injector;

void main() {
  final testBed =
      NgTestBed.forComponent<OuterComponent>(ng.OuterComponentNgFactory,
          rootInjector: rootInjector);
  NgTestFixture<OuterComponent> fixture;

  setUp(() async {
    fixture = await testBed.create();
  });

  tearDown(disposeAnyRunningTest);

  test('service injection', () {
    expect(fixture.text, contains('Fake service'));
  });
}
