package urals.htmlParser.specCharsProcessor;

enum QuoteState {
    SingleQuoteOpen(start: Int);
    DoubleQuoteOpen(start: Int);
    AllQuoteClosed();
}