TestCase("PSHandReaderTest", {
    setUp: function() {
        this.reader = Object.create(PSHandReader);
        this.tableData = Object.create(TableData);
        this.reader.getStartSituation(this.tableData, ["Table '674374357 1' 6-max Seat #1 is the button",
                                                               "Seat 1: SLIMEE_11 (500 in chips)", "Seat 2: chiyuki (500 in chips)", "Seat 3: The Borsh (500 in chips)", 
                                                               "Seat 4: ElenaDenisov (500 in chips)", "Seat 5: V_Andreich (500 in chips)", "Seat 6: PitTheGreek (500 in chips)",
                                                               "SLIMEE_11: posts the ante 10"], 0);
    },
    "test getHeroName null": function() {
        assertEquals(null, this.reader.getHeroName([]));
    },
    "test getHeroName 1 line": function() {
        assertEquals("HERO", this.reader.getHeroName(["Dealt to HERO [5c 6c]"]));
    },
    
    "test getStartingChip 1 line": function() {
        assertEquals(1000, this.reader.getStartingChip("HERO", ["Seat 6: HERO (1000 in chips)"], 500));
    },

    "test setBBSB": function() {
        assertEquals(10, this.tableData.SB);
        assertEquals(20, this.tableData.BB);
        this.reader.setBBSB(this.tableData, "PokerStars Hand #92440992009: Tournament #674374357, $9.07+$0.18 USD Hold'em No Limit - Level I (25/50) - 2013/01/16 22:11:08 JST [2013/01/16 8:11:08 ET]");
        assertEquals(25, this.tableData.SB);
        assertEquals(50, this.tableData.BB);
    },

    "test getButtonPos": function() {
        assertEquals(1, this.reader.getButtonPos("Table '674374357 1' 6-max Seat #1 is the button"));
    },

    "test getStartSituation": function() {
        var result = this.reader.getStartSituation(this.tableData, ["Table '674374357 1' 6-max Seat #1 is the button",
                                                               "Seat 1: SLIMEE_11 (500 in chips)", "Seat 2: chiyuki (500 in chips)", "Seat 3: The Borsh (500 in chips)", 
                                                               "Seat 4: ElenaDenisov (500 in chips)", "Seat 5: V_Andreich (500 in chips)", "Seat 6: PitTheGreek (500 in chips)",
                                                               "SLIMEE_11: posts the ante 10"], 0);
        assertEquals(6, result);
        assertEquals([1, 2, 3, 4, 5, 6], this.tableData.seats);
        assertEquals(["SLIMEE_11", "chiyuki", "The Borsh", "ElenaDenisov", "V_Andreich", "PitTheGreek"], this.tableData.playerNames);
        assertEquals([500, 500, 500, 500, 500, 500], this.tableData.chips);
    },

    "test calcAntePayment no Ante": function() {
        var result = this.reader.calcAntePayment(this.tableData, ["Seat 6: PitTheGreek (500 in chips)", "chiyuki: posts small blind 25"], 0);
        assertEquals(0, result);
        assertEquals(0, this.tableData.Ante);
        assertEquals(0, this.tableData.pot);
        assertEquals([500, 500, 500, 500, 500, 500], this.tableData.chips);
    },
    "test calcAntePayment 10": function() {
        var result = this.reader.calcAntePayment(this.tableData, ["Seat 6: PitTheGreek (500 in chips)", "SLIMEE_11: posts the ante 10", "chiyuki: posts the ante 10",
                                                              "The Borsh: posts the ante 10", "ElenaDenisov: posts the ante 10", "V_Andreich: posts the ante 10",
                                                              "PitTheGreek: posts the ante 10", "chiyuki: posts small blind 25"], 0);
        assertEquals(6, result);
        assertEquals(10, this.tableData.Ante);
        assertEquals(60, this.tableData.pot);
        assertEquals([490, 490, 490, 490, 490, 490], this.tableData.chips);
    },

    "test calcBlindPayment SB": function() {
        var result = this.reader.calcBlindPayment("small", this.tableData, ["PitTheGreek: posts the ante 10", "chiyuki: posts small blind 25", "The Borsh: posts big blind 50"], 0);
        assertEquals(1, result);
        assertEquals(25, this.tableData.pot);
        assertEquals(25, this.tableData.posted[1]);
        assertEquals([500, 475, 500, 500, 500, 500], this.tableData.chips);
    },
    "test calcBlindPayment BB": function() {
        var result = this.reader.calcBlindPayment("big", this.tableData, ["chiyuki: posts small blind 25", "The Borsh: posts big blind 50", "*** HOLE CARDS ***"], 0);
        assertEquals(1, result);
        assertEquals(50, this.tableData.pot);
        assertEquals(50, this.tableData.posted[2]);
        assertEquals([500, 500, 450, 500, 500, 500], this.tableData.chips);
    },
    "test calcBlindsPayment": function() {
        var result = this.reader.calcBlindsPayment(this.tableData, ["PitTheGreek: posts the ante 10", "chiyuki: posts small blind 25", 
                                                                "The Borsh: posts big blind 50", "*** HOLE CARDS ***"], 0);
        assertEquals(2, result);
        assertEquals(75, this.tableData.pot);
        assertEquals(25, this.tableData.posted[1]);
        assertEquals(50, this.tableData.posted[2]);
        assertEquals([500, 475, 450, 500, 500, 500], this.tableData.chips);
    },

    "test calcBetPayment false": function() {
        var result = this.reader.calcBetPayment(this.tableData, "ElenaDenisov: folds");
        assertEquals(false, result);
    },
    "test calcBetPayment true": function() {
        var result = this.reader.calcBetPayment(this.tableData, "");
        assertEquals(true, result);
    },

    "test calcCallPayment false": function() {
        var result = this.reader.calcCallPayment(this.tableData, "ElenaDenisov: folds");
        assertEquals(false, result);
    },
    "test calcCallPayment true": function() {
        var result = this.reader.calcCallPayment(this.tableData, "PitTheGreek: calls 385 and is all-in");
        assertEquals(true, result);
        assertEquals(385, this.tableData.pot);
        assertEquals(385, this.tableData.posted[5]);
        assertEquals([500, 500, 500, 500, 500, 115], this.tableData.chips);
    },

    "test calcRaisePayment false": function() {
        var result = this.reader.calcRaisePayment(this.tableData, "ElenaDenisov: folds");
        assertEquals(false, result);
    },
    "test calcRaisePayment true": function() {
        var result = this.reader.calcRaisePayment(this.tableData, "chiyuki: raises 440 to 490 and is all-in");
        assertEquals(true, result);
        assertEquals(490, this.tableData.pot);
        assertEquals(490, this.tableData.posted[1]);
        assertEquals([500, 10, 500, 500, 500, 500], this.tableData.chips);
    },
    
    "test calcUncalledPayment false": function() {
        var result = this.reader.calcUncalledPayment(this.tableData, "ElenaDenisov: folds");
        assertEquals(false, result);
    },
    "test calcUncalledPayment true": function() {
        var result = this.reader.calcUncalledPayment(this.tableData, "");
        assertEquals(true, result);
    }


});
