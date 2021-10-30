require "./spec_helper"

describe LinkShort do
  it "Create new Linker" do
    linkshort = LinkShort::LinkShort.new
    linker = linkshort.create "https://example.com"
    linker.short.should eq("1234")
    linker.token.should eq("1234")
    linker.original?.should be_true()
  end

  it "Create existing Linker" do
    linkshort = LinkShort::LinkShort.new
    linker = linkshort.create "https://example2.com"
    linker.short.should eq("1234")
    linker.token.should eq("")
    linker.original?.should be_false()
  end

  it "Get all Linkers" do
    linkshort = LinkShort::LinkShort.new
    linkers = linkshort.all
    linkers.should be_a(Array(LinkShort::Linker))
    linkers[0].should be_a(LinkShort::Linker)
  end

  it "Get certain Linker" do
    linkshort = LinkShort::LinkShort.new
    linker = linkshort.from_id "1234"
    linker.should be_a(LinkShort::Linker)
    linker.original?.should be_false()
    linker.empty?.should be_false()
  end

  it "Edit destination of Linker with LinkerShort object" do
    linkshort = LinkShort::LinkShort.new
    linker = LinkShort::Linker.new "1234", "https://exmaple.com", "https://exmaple.com", linkshort, "1234"
    linkshort.edit linker, "https://example2.com"
    linker.destination.should eq("https://example2.com")
  end

  it "Edit destination of Linker directly with edit func" do
    linkshort = LinkShort::LinkShort.new
    linker = LinkShort::Linker.new "1234", "https://exmaple.com", "https://exmaple.com", linkshort, "1234"
    linker.edit "https://example2.com"
    linker.destination.should eq("https://example2.com")
  end

  it "Edit destination of Linker indirectly with assignment operator" do
    linkshort = LinkShort::LinkShort.new
    linker = LinkShort::Linker.new "1234", "https://exmaple.com", "https://exmaple.com", linkshort, "1234"
    linker.destination = "https://example2.com"
    linker.destination.should eq("https://example2.com")
  end
end
