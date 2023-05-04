package htmlParser;

import haxe.Exception;
import urals.htmlParser.SpecCharsPositionsMap;
import sneaker.assertion.Asserter.*;

class SpecCharsPositionsMapTest 
{
    private static function test1() 
    {
        var scpm = new SpecCharsPositionsMap("<div></div>");
        assert(scpm.getHtmlLength() == 11);
        switch(scpm.specCharsSeq) {
            case [
                {pos: 0, char: "<"},
                {pos: 4, char: ">"},
                {pos: 5, char: "<"},
                {pos: 10, char: ">"},
            ]: {};
            case _: throw new Exception("Error at specCharsSeq comparsion test");
        }
    }

    private static function test2() 
    {
        var scpm = new SpecCharsPositionsMap('
        <body>
            <div<hello id="hello_block">
                <img src=\'url("someUrl)\'
            </hello>
        </body');
        assert(scpm.specCharsSeq[0].char == "<");
        assert(scpm.specCharsSeq[1].char == ">");
        assert(scpm.specCharsSeq[2].char == "<");
        assert(scpm.specCharsSeq[3].char == "<");
        assert(scpm.specCharsSeq[4].char == '"');
        assert(scpm.specCharsSeq[5].char == '"');
        assert(scpm.specCharsSeq[6].char == ">");
        assert(scpm.specCharsSeq[7].char == "<");
        assert(scpm.specCharsSeq[8].char == "'");
        assert(scpm.specCharsSeq[9].char == '"');
        assert(scpm.specCharsSeq[10].char == "'");
        assert(scpm.specCharsSeq[11].char == "<");
        assert(scpm.specCharsSeq[12].char == ">");
        assert(scpm.specCharsSeq[13].char == "<");
    }

    public static function run() {
        test1();
        test2();
    }
}