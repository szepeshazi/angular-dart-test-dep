import 'package:angular/angular.dart';
@TestOn('browser')
import 'package:angular_test/angular_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:test_deps/app_component.dart';
import 'package:test_deps/app_component.template.dart' as ng;
import 'package:test_deps/service_overrides.dart';

class FakeServiceImpl extends Mock implements SomeService {}

final FakeServiceImpl _fakeServiceImpl = FakeServiceImpl();

void main() {
  final testBed = NgTestBed.forComponent<OuterComponent>(ng.OuterComponentNgFactory,
      rootInjector: ([parent]) => Injector.map({
            someServiceOverride: _fakeServiceImpl,
          }, parent));
  NgTestFixture<OuterComponent> fixture;

  setUp(() async {
    when(_fakeServiceImpl.call()).thenAnswer((_) async => 'Fake it till you make it');
    fixture = await testBed.create();
  });

  tearDown(disposeAnyRunningTest);

  test('service injection', () async {
    expect(fixture.text, contains('Fake it till you make it'));
  });
}
