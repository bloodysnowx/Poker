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
                ret = RegExp.$3;
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
            data.SB = RegExp.$1;
            data.BB = RegExp.$2;
            return true;
        }
        return false;
    },
    getButtonPos:function(line) {
        line.match(/Seat[ ]#([0-9]+)[ ]is[ ]the[ ]button/);
        return RegExp.$1;
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
    calcAntePayment:function(result, hh, line) {
        for(var i = 0; i < result.MaxSeatNum; ++i)
        {
            if(hh[line + i + 1].match(/(.+):[ ]posts[ ]the[ ]ante[ ]([0-9]+)/))
            {
                var j = result.getIndexFromName(RegExp.$1);
                result.Ante = Math.max(result.Ante, RegExp.$2);
                result.chips[j] -= RegExp.$2;
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
            result.chips[i] -= result.posted[i];
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
            result.chips[i] -= RegExp.$2;
            result.pot += RegExp.$2;
            result.posted[i] += RegExp.$2;
            return true;
        }
        return false;
    },
    calcCallPayment:function(result, line) {
        if(line.match(/(.+):[ ]calls[ ]([0-9]+)/)) {
            var i = result.getIndexFromName(RegExp.$1);
            result.chips[i] -= RegExp.$2;
            result.pot += RegExp.$2;
            result.posted[i] += RegExp.$2;
            return true;
        }
        return false;
    },
    calcRaisePayment:function(result, line) {
        if(line.match(/(.+):[ ]raises[ ]([0-9]+)[ ]to[ ]([0-9]+)/)) {
            var i = result.getIndexFromName(RegExp.$1);
            result.chips[i] -= RegExp.$3 - result.posted[i];
            result.pot += RegExp.$3 - result.posted[i];
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
    readNow: function(tableData, hh) {
        tableData.heroName = this.getHeroName(hh);
        tableData.StartingChip = this.getStartingChip(tableData.heroName, hh, this.DefaultStartingChip);
        var line = 0;
        var ret = false;
        while(ret == false) ret = this.setBBSB(tableData, hh[line++]);
        tableData.buttonPos = this.getButtonPos(hh[line]);
        line += this.getStartSituation(tableData, hh, line);

        return line;
    },
    readNext: function(tableData, hh) {
        var line = this.readNow(tableData, hh);
        line += this.calcAntePayment(tableData, hh, line);
        line += this.calcBlindsPayment(tableData, hh, line);
        alert(tableData.chips);
        alert(tableData.pot);
        
        for(line; line < hh.length; ++line)
        {
            if (this.calcBetPayment(tableData, hh[line])) continue;
            if (this.calcCallPayment(tableData, hh[line])) continue;
            if (this.calcRaisePayment(tableData, hh[line])) continue;
            if (this.calcUncalledPayment(tableData, hh[line])) continue;
            if (this.calcCollectPayment(tableData, hh[line])) continue;

            if (hh[line].match(/***[ ](FLOP|TURN|RIVER)[ ]***/))
                tableData.posted = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
            else if (hh[line].match("*** SUMMARY ***")) break;
        }
        tableData.nextButton();

        return tableData;
    }
};
