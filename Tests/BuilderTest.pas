unit BuilderTest;

interface
uses
  DUnitX.TestFramework;

type

  TBuilderTest = class(TObject)
  type
    [TestFixture]
    TFactoryTest = class
      [Test] procedure when_creating_as_object;
    end;

    [TestFixture]
    TFormatTest = class
      [Test] procedure when_applying_prety_prent;
      [Test] procedure when_no_prety_prent;
    end;

    [TestFixture]
    TComposeTest = class
      [Test] procedure when_add_member_using_anonymous_function;
    end;
  end;

implementation

uses
  VSoft.Fluent.JSON;

{ TBuilderTest.TFactoryTest }

procedure TBuilderTest.TFactoryTest.when_creating_as_object;
var
  builder: IFluentJSONBuilder;
begin
  builder := TFluentJSON.AsObject;

  Assert.AreEqual('{}', builder.ToString);
end;

{ TBuilderTest.TFormatTest }

procedure TBuilderTest.TFormatTest.when_applying_prety_prent;
var
  json, expected: string;
begin
  expected := '{'#13#10'  "name":"xyz",'#13#10'  "value":12345'#13#10'}';

  json :=
    TFluentJSON.AsObject
    .AddString('name', 'xyz')
    .AddNumber('value', 12345)
    .Up
    .ToString;

  Assert.AreEqual(expected, json);
end;

procedure TBuilderTest.TFormatTest.when_no_prety_prent;
var
  json, expected: string;
begin
  expected := '{"name":"xyz","value":12345}';

  json :=
    TFluentJSON.AsObject
    .AddString('name', 'xyz')
    .AddNumber('value', 12345)
    .Up
    .ToString(false);

  Assert.AreEqual(expected, json);
end;

{ TBuilderTest.TComposeTest }

procedure TBuilderTest.TComposeTest.when_add_member_using_anonymous_function;
var
  json, expected: string;
begin
  expected := '{"variable":{"name":"xyz","value":12345},"constant":{"name":"c","value":"foo"}}';

  json :=
    TFluentJSON.AsObject
    .AddObject('variable',
      procedure (builder: IFluentJSONBuilder)
      begin
        builder
          .AddString('name', 'xyz')
          .AddNumber('value', 12345)
      end
    )
    .AddObject('constant',
      procedure (builder: IFluentJSONBuilder)
      begin
        builder
          .AddString('name', 'c')
          .AddString('value', 'foo')
      end
    )
    .ToString(false);

  Assert.AreEqual(expected, json);
end;

initialization
  TDUnitX.RegisterTestFixture(TBuilderTest);
  TDUnitX.RegisterTestFixture(TBuilderTest.TFormatTest);
  TDUnitX.RegisterTestFixture(TBuilderTest.TComposeTest);
end.
