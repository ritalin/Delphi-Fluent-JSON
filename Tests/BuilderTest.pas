unit BuilderTest;

interface
uses
  DUnitX.TestFramework;

type

  [TestFixture]
  TBuilderTest = class(TObject)
  public
  end;

implementation


initialization
  TDUnitX.RegisterTestFixture(TBuilderTest);
end.
