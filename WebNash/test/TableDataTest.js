TestCase("TableDataTest", {
    setUp: function() {
        this.tableData = Object.create(TableData);
        this.tableData.heroName = "HERO";
        this.tableData.playerNames = [ "Alpha", "Bravo", "Charlie", "Delta", "Echo", "Foxtrot", "Golf", "HERO", "India" ];
        this.tableData.seats = [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ];
        this.tableData.buttonPos = 1;
        this.tableData.chips = [ 100, 100, 100, 100, 100, 100, 100, 100, 100 ];
    },

    "test create": function() {
        var result = Object.create(TableData);
        assertEquals(9, result.MaxSeatNum);
        assertEquals("1,1", result.Structure);
    },

    "test getHeroIndex = 0": function() {
        this.tableData.playerNames = [ "HERO", "test" ];
        assertEquals(0, this.tableData.getHeroIndex());
    },
    "test getHeroIndex = 1": function() {
        this.tableData.playerNames = [ "hoge", "HERO", "test" ];
        assertEquals(1, this.tableData.getHeroIndex());
    },
    "test getHeroIndex = 7": function() {
        assertEquals(7, this.tableData.getHeroIndex());
    },

    "test calcHeroIndex": function() { },

    "test getHeroSeat = 2": function() {
        this.tableData.playerNames = [ "hoge", "HERO", "test" ];
        this.tableData.seats = [ "1", "2", "3" ];
        assertEquals(2, this.tableData.getHeroSeat());
    },
    "test getHeroSeat = 5": function() {
        this.tableData.playerNames = [ "hoge", "Alpha", "Bravo", "HERO", "test" ];
        this.tableData.seats = [ "1", "2", "3", "5", "7" ];
        assertEquals(5, this.tableData.getHeroSeat());
    },
    "test getHeroSeat = 8": function() {
        assertEquals(8, this.tableData.getHeroSeat());
    },

    "test nextButton normal": function() {
        assertEquals(1, this.tableData.buttonPos);
        this.tableData.nextButton();
        assertEquals(2, this.tableData.buttonPos);
        this.tableData.nextButton();
        assertEquals(3, this.tableData.buttonPos);
        this.tableData.nextButton();
        assertEquals(4, this.tableData.buttonPos);
        this.tableData.nextButton();
        assertEquals(5, this.tableData.buttonPos);
        this.tableData.nextButton();
        assertEquals(6, this.tableData.buttonPos);
        this.tableData.nextButton();
        assertEquals(7, this.tableData.buttonPos);
        this.tableData.nextButton();
        assertEquals(8, this.tableData.buttonPos);
        this.tableData.nextButton();
        assertEquals(9, this.tableData.buttonPos);
        this.tableData.nextButton();
        assertEquals(1, this.tableData.buttonPos);
        this.tableData.nextButton();
    },
    "test nextButton another": function() {
        this.tableData.playerNames = [ "hoge", "Alpha", "Bravo", "HERO", "test" ];
        this.tableData.seats = [ "1", "2", "3", "5", "7" ];
        assertEquals(1, this.tableData.buttonPos);
        this.tableData.nextButton();
        assertEquals(2, this.tableData.buttonPos);
        this.tableData.nextButton();
        assertEquals(3, this.tableData.buttonPos);
        this.tableData.nextButton();
        assertEquals(5, this.tableData.buttonPos);
        this.tableData.nextButton();
        assertEquals(7, this.tableData.buttonPos);
        this.tableData.nextButton();
        assertEquals(1, this.tableData.buttonPos);
        this.tableData.nextButton();
    },

    "test getLivePlayerCount = 9": function() {
        assertEquals(9, this.tableData.getLivePlayerCount());
    },
    "test getLivePlayerCount = 7": function() {
        this.tableData.chips = [ 100, 0, 100, 0, 100, 100, 100, 100, 100 ];
        assertEquals(7, this.tableData.getLivePlayerCount());
    }
});
