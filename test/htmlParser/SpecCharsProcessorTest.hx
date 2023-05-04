package htmlParser;

import haxe.Exception;
import urals.htmlParser.SpecCharsProcessor;
import urals.htmlParser.SpecCharsPositionsMap;

using StringTools;

class SpecCharsProcessorTest 
{
    public static function test1() 
    {
        var html = "<div></div>";
        var scpm = new SpecCharsPositionsMap(html);
        var processor = new SpecCharsProcessor(scpm);
        switch (processor.getHtmlZonesMap().getTagZones()) {
            case [{start: 0, end: 4}, {start: 5, end: 10}]: {};
            case _: throw new Exception("htmlZomesMap matching error");
        }
    }  
    
    public static function test2() 
        {
            var html = 
'<body>
    <div<hello id="hello_block">
        <img src=\'url("someUrl)\'
    </hello>
</body'.replace("\r", "");
            var scpm = new SpecCharsPositionsMap(html);
            var processor = new SpecCharsProcessor(scpm);
            switch (processor.getHtmlZonesMap().getTagZones()) {
                case [
                    {start: 0, end: 5}, //<body>
                    {start: 11, end: 14}, //<div
                    {start: 15, end: 38}, //<hello ...>
                    {start: 48, end: 76}, //<img ...
                    {start: 77, end: 84}, //</hello>
                    {start: 86, end: 91}, //</body>
                ]: {};
                case _: {
                    trace("real value:");
                    trace(processor.getHtmlZonesMap().getTagZones());
                    throw new Exception("htmlZomesMap matching error");
                }
            }
        }   

    public static function run() {
        test1();
        test2();
    }
}