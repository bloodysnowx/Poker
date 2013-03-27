TestCase("PSHandReaderTest", {
    setUp: function() {
        this.reader = Object.create(PSHandReader);
    },
    "test getHeroName": function() {
        assertEquals(null, this.reader.getHeroName([]));
    }
});
