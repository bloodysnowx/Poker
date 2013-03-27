var PlayerData = {
    seat: 0,
    position: "",
    playerName: "",
    chip: 0
};

var TableData = {
    MaxSeatNum: 9,
    BB: 20,
    SB: 10,
    Ante: 0,
    Structure: "",
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
    calcHeroIndex: function() { },
    getHeroSeat: function() { return this.seats[this.getHeroIndex()]; },
    nextButton: function() { },
    getLivePlayerCount: function() { }
};
