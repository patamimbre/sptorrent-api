require_relative 'spec_helper'
require_relative '../lib/parser'

describe "Overloaded String class" do

  it "no spaces in string" do
    expected = "juego+de+tronos"
    used = "juego de tronos"

    assert used.clean.must_equal expected

  end

  it "extract season and episode from a string" do
    str = "Narcos3x05"
    arr = str.extract_se

    assert arr[:season].must_equal '3'
    assert arr[:episode].must_equal '05'

  end

end