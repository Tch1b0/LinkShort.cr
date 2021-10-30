require "spec"
require "../src/linkshort"
require "../src/requester"
require "../src/linker"
require "webmock"

# Mock API
WebMock.stub(:post, "https://ls.johannespour.de/create")
  .with(body: "{\"link\":\"https://example.com\"}", headers: {"Content-type" => "application/json"})
  .to_return(status: 200, body: "{\"short\": \"1234\", \"destination\": \"https://example.com\", \"token\": \"1234\"}")

WebMock.stub(:post, "https://ls.johannespour.de/create")
  .with(body: "{\"link\":\"https://example2.com\"}", headers: {"Content-type" => "application/json"})
  .to_return(status: 200, body: "{\"short\": \"1234\", \"destination\": \"https://example2.com\"}")

WebMock.stub(:get, "https://ls.johannespour.de/links")
  .to_return(status: 200, body: "{\"38066349\":\"https://johannespour.de\",\"test\":\"https://example.com\",\"33b5371c\":\"https://youtube.com\",\"9e50523f\":\"https://youtube.com/test\",\"c7f36740\":\"https://youtube.com/tests\",\"dc87211a\":\"https://youtube.com/testslink\"}")

WebMock.stub(:get, "https://ls.johannespour.de/1234/json")
  .to_return(status: 200, body: "{\"short\": \"1234\", \"destination\": \"https://example.com\"}")

WebMock.stub(:put, "https://ls.johannespour.de/1234")
  .to_return(status: 200)
