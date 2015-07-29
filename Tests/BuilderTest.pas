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

initialization
  TDUnitX.RegisterTestFixture(TBuilderTest);
end.
