var PlayerData = {
    seat: 0,
    position: "",
    playerName: "",
    chip: 0,
    posted: 0
};

var TableData = {
    MaxSeatNum: 9,
    BB: 20,
    SB: 10,
    Ante: 0,
    Structure: "1,1",
    heroPos: -1,
    heroName: "",
    seats: [],
    positions: [],
    playerNames: [],
    chips: [],
    buttonPos: -1,
    pot: 0,
    posted: [],
    StartingChip: 0,
    heroIndex: -1,
    getHeroIndex: function() { if (this.heroIndex < 0) this.heroIndex = this.calcHeroIndex(); return this.heroIndex; },
    calcHeroIndex: function() {
        var ret = 0;
        for(var i = 0; i < this.playerNames.length; ++i) if(this.playerNames[i] == this.heroName) ret = i;
        return ret;
    },
    getHeroSeat: function() { return this.seats[this.getHeroIndex()]; },
    nextButton: function() {
        var nowIndex;
        for(nowIndex = 0; nowIndex < this.MaxSeatNum; ++nowIndex) if(this.seats[nowIndex] == this.buttonPos) break;
        for(var i = 1; i < this.MaxSeatNum; ++i) {
            if(this.seats[(i + nowIndex) % this.MaxSeatNum] > 0) {
                this.buttonPos = this.seats[(i + nowIndex) % this.MaxSeatNum];
                break;
            }
        }
    },
    getLivePlayerCount: function() {
        var count = 0;
        for(var i = 0; i < this.chips.length; ++i) if(this.chips[i] > 0) ++count;
        return count;
    }
};
