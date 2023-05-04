package urals.htmlParser;

class HtmlZonesMap 
{
    public function new() {
    }

    private var tagZones: Array<{start: Int, end: Int}> = [];
    private var valZones: Array<{start: Int, end: Int, singleQuote: Bool}> = [];

    public function addTag(tag: {start: Int, end: Int}) 
    {
        tagZones.push(tag);    
    }

    public function addVal(val: {start: Int, end: Int, singleQuote: Bool}) 
    {
        valZones.push(val);    
    }

    public function getTagZones() {
        return tagZones;
    }

    public function getValZones() {
        return valZones;
    }
}