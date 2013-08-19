var CheckHeroName = {
    whiteList: ["chiyuki"],
    blackList: [],
    check: function(name) {
        return this.checkByBlackList(name);
    },
    checkByWhiteList: function(name) {
        for(var i = 0; i < this.whiteList.length; ++i) if(name == this.whiteList[i]) return true;
        return false;
    },
    checkByBlackList: function(name) {
        for(var i = 0; i < this.blackList.length; ++i) if(name == this.blackList[i]) return false;
        return true;
    }
};

var PlayerData = {
    seat: 0,
    position: "",
    playerName: "",
    chip: 0,
    posted: 0
};

var TableData = {
    MaxSeatNum: 10,
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
    reset: function() {
	this.BB = 20;
	this.SB = 10;
	this.Ante = 0;
	this.Structure = "1,1",
	this.heroPos = -1;
	this.heroName = "";
	this.seats = [];
	this.positions = [];
	this.playerNames = [];
	this.chips = [];
	this.buttonPos = -1;
	this.pot = 0;
	this.posted = [];
	this.StartingChip = 0;
	this.heroIndex = -1;
    },
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
    },
    getIndexFromName:function(name) {
        for(var i = 0; i < this.MaxSeatNum; ++i) if(name == this.playerNames[i]) return i;
        return null;
    },
    getIndexFromSeat:function(seat) {
        for(var i = 0; i < this.MaxSeatNum; ++i) if(seat == this.seats[i]) return i;
        return null;
    },
    calcBBIndex:function() {
        var livePlayerCount = this.getLivePlayerCount();
        var BBIndex = -1;
        var buttonIndex = this.getIndexFromSeat(this.buttonPos);
        if(livePlayerCount < 3)
        {
            for(var i = 1; i < this.MaxSeatNum; ++i)
                if(this.chips[(buttonIndex + i) % this.chips.length] > 0) { BBIndex = (buttonIndex + i) % this.chips.length; break; }
        }
        else
        {
            var count = 0;
            for(var i = 1; i < this.MaxSeatNum; ++i)
            {
                if(this.chips[(buttonIndex + i) % this.chips.length] > 0)
                {

                    if(++count == 2) { BBIndex = (buttonIndex + i) % this.chips.length; break; }
                }
            }
        }
        return BBIndex;
    },
    calcPositions:function() {
        var BBIndex = this.calcBBIndex();
        var posNum = 1;
        for(var i = 1; i <= this.chips.length; ++i)
        {
            if(this.chips[(BBIndex + i) % this.chips.length] > 0)
            {
                this.positions[(BBIndex + i) % this.chips.length] = posNum++;
            }
        }
    }
};
var PSHandReader = {
    DefaultStartingChip:1500,
    getHeroName:function(hh) {
        for(var i = 0; i < hh.length; ++i)
        {
            if(hh[i].match(/Dealt[ ]to[ ](.+)[ ][[][2-9TJQKA][shdc][ ][2-9TJQKA][shdc]]/))
                return RegExp.$1;
        }
        return null;
    },
    getStartingChip:function(heroName, hh, defaultValue) {
        var ret = defaultValue;
        for(var i = 0; i < hh.length; ++i)
        {
            if(hh[i].match(/Seat[ ]([0-9]+):[ ](.+)[ ][(]([0-9]+)[ ]in[ ]chips[)]/) && RegExp.$2 == heroName)
            {
                ret = parseInt(RegExp.$3);
                break;
            }
        }
        return ret;
    },
    // getHHLineList:function(hh) { },
    // getNowHH:function(hh, lineList, backNum) { },
    setBBSB:function(data, line) {
        if(line.match(/[(]([0-9]+)[/]+([0-9]+)[)]/))
        {
            data.SB = parseInt(RegExp.$1);
            data.BB = parseInt(RegExp.$2);
            return true;
        }
        return false;
    },
    getButtonPos:function(line) {
        line.match(/Seat[ ]#([0-9]+)[ ]is[ ]the[ ]button/);
        return parseInt(RegExp.$1);
    },
    getStartSituation:function(result, hh, line) {
        for(var i = 0; i < result.MaxSeatNum; ++i)
        {
            if(hh[line + i + 1].match(/Seat[ ]([0-9]+):[ ](.+)[ ][(]([0-9]+)[ ]in[ ]chips[)]/))
            {
                result.seats[i] = parseInt(RegExp.$1);
                result.playerNames[i] = RegExp.$2;
                result.chips[i] = parseInt(RegExp.$3);
                result.posted[i] = 0;
            }
            else return i;
        }
        return result.MaxSeatNum;
    },
    getAnte:function(result, hh, line) {
        for(var i = 0; i < result.MaxSeatNum; ++i)
        {
            if(hh[line + i + 1].match(/(.+):[ ]posts[ ]the[ ]ante[ ]([0-9]+)/))
            {
                var j = result.getIndexFromName(RegExp.$1);
                result.Ante = Math.max(result.Ante, RegExp.$2);
            }
        }
    },
    calcAntePayment:function(result, hh, line) {
        for(var i = 0; i < result.MaxSeatNum; ++i)
        {
            if(hh[line + i + 1].match(/(.+):[ ]posts[ ]the[ ]ante[ ]([0-9]+)/))
            {
                var j = result.getIndexFromName(RegExp.$1);
                result.Ante = Math.max(result.Ante, RegExp.$2);
                result.chips[j] -= parseInt(RegExp.$2);
                result.pot += parseInt(RegExp.$2);
            }
            else return i;
        }
        return result.MaxSeatNum;
    },
    calcBlindPayment:function(blind, result, hh, line) {
        var regexp = new RegExp("(.+):[ ]posts[ ]" + blind + "[ ]blind[ ]([0-9]+)");
        if(hh[line + 1].match(regexp))
        {
            var i = result.getIndexFromName(RegExp.$1);
            result.posted[i] = parseInt(RegExp.$2);
            result.chips[i] -= parseInt(result.posted[i]);
            result.pot += result.posted[i];
            return 1;
        }
        return 0;
    },
    calcBlindsPayment:function(result, hh, line) {
        var ret = this.calcBlindPayment("small", result, hh, line);
        ret += this.calcBlindPayment("big", result, hh, line + ret);
        return ret;
    },
    calcBetPayment:function(result, line) {
        if(line.match(/(.+):[ ]bets[ ]([0-9]+)/)) {
            var i = result.getIndexFromName(RegExp.$1);
            result.chips[i] -= parseInt(RegExp.$2);
            result.pot += parseInt(RegExp.$2);
            result.posted[i] += parseInt(RegExp.$2);
            return true;
        }
        return false;
    },
    calcCallPayment:function(result, line) {
        if(line.match(/(.+):[ ]calls[ ]([0-9]+)/)) {
            var i = result.getIndexFromName(RegExp.$1);
            result.chips[i] -= RegExp.$2;
            result.pot += parseInt(RegExp.$2);
            result.posted[i] += parseInt(RegExp.$2);
            return true;
        }
        return false;
    },
    calcRaisePayment:function(result, line) {
        if(line.match(/(.+):[ ]raises[ ]([0-9]+)[ ]to[ ]([0-9]+)/)) {
            var i = result.getIndexFromName(RegExp.$1);
            result.chips[i] -= RegExp.$3 - result.posted[i];
            result.pot += parseInt(RegExp.$3) - result.posted[i];
            result.posted[i] = parseInt(RegExp.$3);
            return true;
        }
        return false;
    },
    calcUncalledPayment:function(result, line) {
        if(line.match(/Uncalled[ ]bet[ ][(]([0-9]+)[)][ ]returned[ ]to[ ](.+)/)) {
            var i = result.getIndexFromName(RegExp.$2);
            result.chips[i] += parseInt(RegExp.$1);
            result.pot -= RegExp.$1;
            return true;
        }
        return false;
    },
    calcCollectPayment:function(result, line) {
        if(line.match(/(.+)[ ]collected[ ]([0-9]+)[ ]from[ ]/)) {
            var i = result.getIndexFromName(RegExp.$1);
            result.chips[i] += parseInt(RegExp.$2);
            result.pot -= parseInt(RegExp.$2);
            return true;
        }
        return false;
    },
    readNowWithoutAnte: function(tableData, hh) {
        tableData.heroName = this.getHeroName(hh);
        tableData.StartingChip = this.getStartingChip(tableData.heroName, hh, this.DefaultStartingChip);
        var line = 0;
        var ret = false;
        while(ret == false) ret = this.setBBSB(tableData, hh[line++]);
        tableData.buttonPos = this.getButtonPos(hh[line]);
        line += this.getStartSituation(tableData, hh, line);

        return line;
    },
    readNow: function(tableData, hh) {
        var line = this.readNowWithoutAnte(tableData, hh);
        this.getAnte(tableData, hh, line);
    },
    readNext: function(tableData, hh) {
        var line = this.readNowWithoutAnte(tableData, hh);
        line += this.calcAntePayment(tableData, hh, line);
        line += this.calcBlindsPayment(tableData, hh, line);
        
        for(line; line < hh.length; ++line)
        {
            if (this.calcBetPayment(tableData, hh[line])) continue;
            if (this.calcCallPayment(tableData, hh[line])) continue;
            if (this.calcRaisePayment(tableData, hh[line])) continue;
            if (this.calcUncalledPayment(tableData, hh[line])) continue;
            if (this.calcCollectPayment(tableData, hh[line])) continue;

            if (hh[line].indexOf("*** FLOP ***") >= 0 || hh[line].indexOf("*** TURN ***") >= 0 || hh[line].indexOf("*** RIVER ***") >= 0)
                tableData.posted = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
            else if (hh[line].indexOf("*** SUMMARY ***") >= 0) break;
        }
        tableData.nextButton();

        return tableData;
    }
};
function main(Structure, Content, isNext)
{
    var hh = Content.split(/\r\n|\r|\n/);
    var reader = Object.create(PSHandReader);
    var tableData = Object.create(TableData);
    tableData.reset();
    var checker = Object.create(CheckHeroName);
    if(isNext) reader.readNext(tableData, hh);
    else reader.readNow(tableData, hh);
    if(checker.check(tableData.heroName) == false) return '/error';
    tableData.calcPositions();
    var url = "http://www.holdemresources.net/hr/sngs/icmcalculator.html?action=calculate&bb=";
    url += tableData.BB;
    url += "&sb=" + tableData.SB;
    url += "&ante=" + tableData.Ante;
    url += "&structure=" + Structure;
    for(var i = 0; i <= tableData.MaxSeatNum; ++i)
        if(tableData.chips[i] > 0) url += "&s" + tableData.positions[i] + "=" + tableData.chips[i];
    return url;
}

exports.main = main;
