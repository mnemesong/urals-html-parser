package urals.htmlParser;

import urals.htmlParser.specCharsProcessor.TagState;
import urals.htmlParser.specCharsProcessor.QuoteState;

class SpecCharsProcessor 
{
    private var state: {
        quote: QuoteState,
        tag: TagState
    } = {
        quote: AllQuoteClosed,
        tag: TagClose
    }

    private var htmlZonesMap = new HtmlZonesMap();

    private var map: SpecCharsPositionsMap;

    public function new(map: SpecCharsPositionsMap) {
        this.map = map;
        process();
    }

    private function process(): Void
    {
        for (i in 0...map.specCharsSeq.length) {
            switch state {
                case {quote: AllQuoteClosed, tag: TagClose}: {
                    if (map.specCharsSeq[i].char == '<') {
                        state.tag = TagOpen(map.specCharsSeq[i].pos);
                    }
                };
                case {quote: AllQuoteClosed, tag: TagOpen(tagOpenStart)}: {
                    if(map.specCharsSeq[i].char == '<') {
                        htmlZonesMap.addTag({
                            start: tagOpenStart, 
                            end: (map.specCharsSeq[i].pos - 1)
                        });
                        state.tag = TagOpen(map.specCharsSeq[i].pos);
                    } else if(map.specCharsSeq[i].char == '>') {
                        htmlZonesMap.addTag({
                            start: tagOpenStart, 
                            end: (map.specCharsSeq[i].pos)
                        });
                        state.tag = TagClose;
                    } else if(map.specCharsSeq[i].char == '"') {
                        state.quote = DoubleQuoteOpen(map.specCharsSeq[i].pos);
                    } else if(map.specCharsSeq[i].char == "'") {
                        state.quote = SingleQuoteOpen(map.specCharsSeq[i].pos);
                    }
                };
                case {quote: SingleQuoteOpen(quoteOpenStart), tag: TagOpen(tagStart)}: {
                    if(map.specCharsSeq[i].char == "'") {
                        htmlZonesMap.addVal({
                            start: quoteOpenStart, 
                            end: map.specCharsSeq[i].pos,
                            singleQuote: true
                        });
                        state.quote = AllQuoteClosed;
                    }
                };
                case {quote: DoubleQuoteOpen(quoteOpenStart), tag: TagOpen(tagStart)}: {
                    if(map.specCharsSeq[i].char == '"') {
                        htmlZonesMap.addVal({
                            start: quoteOpenStart, 
                            end: map.specCharsSeq[i].pos,
                            singleQuote: false
                        });
                        state.quote = AllQuoteClosed;
                    }
                };
                case _: {};
            }
        }
        switch (state.quote) {
            case DoubleQuoteOpen(quoteOpenStart): {
                htmlZonesMap.addVal({
                    start: quoteOpenStart, 
                    end: map.getHtmlLength() - 1,
                    singleQuote: false
                });
                state.quote = AllQuoteClosed;
            };
            case SingleQuoteOpen(quoteOpenStart): {
                htmlZonesMap.addVal({
                    start: quoteOpenStart, 
                    end: map.getHtmlLength() - 1,
                    singleQuote: true
                });
                state.quote = AllQuoteClosed;
            };
            case _: {};
        }
        switch (state.tag) {
            case TagOpen(tagOpenStart): {
                htmlZonesMap.addTag({
                    start: tagOpenStart,
                    end: map.getHtmlLength() - 1
                });
                state.tag = TagClose;
            };
            case _: {};
        }
    }    

    public function getHtmlZonesMap(): HtmlZonesMap {
        return htmlZonesMap;
    }
}