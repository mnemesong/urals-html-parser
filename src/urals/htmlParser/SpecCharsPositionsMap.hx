package urals.htmlParser;

class SpecCharsPositionsMap
{
    public var htmlChars(default, null): Array<String> = [];
    public var specCharsSeq(default, null): Array<{pos: Int, char: String}> = [];
    
    public function new(html: String) {
        this.htmlChars = html.split("");
        parseHtml();
    }

    private function parseHtml() {
        for (i in 0...htmlChars.length) {
            if((htmlChars[i] == "<") 
                || (htmlChars[i] == ">") 
                || (htmlChars[i] == "'") 
                || (htmlChars[i] == '"')) 
            { specCharsSeq.push({pos: i, char: htmlChars[i]}); }
        }
    }

    public function getHtmlText(): String {
        return htmlChars.join("");
    }

    public function getHtmlLength(): Int {
        return htmlChars.length;
    }
}