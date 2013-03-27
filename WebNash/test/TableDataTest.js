TestCase("TableDataTest", {
    setUp: function() {
        this.tableData = Object.create(TableData);
    },
    "test create": function() {
        var result = Object.create(TableData);
        assertEquals(9, result.MaxSeatNum);
    }
});
