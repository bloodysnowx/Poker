var PSHandReader = {
    getHeroName:function(hh) {
        for(var i = 0; i < hh.length; ++i)
        {
            if(hh[i].match(/Dealt¥sto¥s(.+)¥s¥[[2-9TJQKA][shdc]¥s[2-9TJQKA][shdc]¥]/))
                return RegExp.$1;
        }
        return null;
    },
    getStartingChip:function(heroName, hh, defaultValue) {
        var ret = defaultValue;
        for(var i = 0; i < hh.length; ++i)
        {
            if(hh[i].match(/Seat¥s([0-9]+):¥s(.+)¥s¥(([0-9]+)¥sin¥schips¥)/) && RegExp.$2 == heroName)
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
        if(line.match(/¥(([0-9]+)¥u002f([0-9]+)¥)/))
        {
            data.SB = RegExp.$1;
            data.BB = RegExp.$2;
        }
    },
    getButtonPos:function(line) {
        line.match(/Seat¥s#([0-9]+)¥sis¥sthe¥sbutton/);
        return RegExp.$1;
    },
    getStartSituation:function(result, hh, line) {
        for(var i = 0; i < result.MaxSeatNum; ++i)
        {
            if(hh[line + i + 1].match(/Seat¥s([0-9]+):¥s(.+)¥s¥(([0-9]+)¥sin¥schips¥)/))
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
            if(hh[line + i + 1].match(/(.+):¥sposts¥sthe¥sante¥s([0-9]+)/))
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
        var regexp = new RegExp("(.+):¥¥sposts¥¥s" + blind + "¥¥sblind¥¥s([0-9]+)");
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
        if(line.match(/(.+):¥sbets¥s([0-9]+)/)) {
            var i = result.getIndexFromName(RegExp.$1);
            result.chips[i] -= RegExp.$2;
            result.pot += RegExp.$2;
            result.posted[i] += RegExp.$2;
            return true;
        }
        return false;
    },
    calcCallPayment:function(result, line) {
        if(line.match(/(.+):¥scalls¥s([0-9]+)/)) {
            var i = result.getIndexFromName(RegExp.$1);
            result.chips[i] -= RegExp.$2;
            result.pot += RegExp.$2;
            result.posted[i] += RegExp.$2;
            return true;
        }
        return false;
    },
    calcRaisePayment:function(result, line) {
        if(line.match(/(.+):¥sraises¥s([0-9]+)¥sto¥s([0-9]+)/)) {
            var i = result.getIndexFromName(RegExp.$1);
            result.chips[i] -= RegExp.$3 - result.posted[i];
            result.pot += RegExp.$3 - result.posted[i];
            result.posted[i] = parseInt(RegExp.$3);
            return true;
        }
        return false;
    },
    calcUncalledPayment:function(result, line) {
        if(line.match(/Uncalled¥sbet¥s¥(([0-9]+)¥)¥sreturned¥sto¥s(.+)/)) {
            var i = result.getIndexFromName(RegExp.$2);
            result.chips[i] += parseInt(RegExp.$1);
            result.pot -= RegExp.$1;
            return true;
        }
        return false;
    },
    calcCollectPayment:function(result, line) {
        if(line.match(/(.+)¥scollected¥s([0-9]+)¥sfrom¥s/)) {
            var i = result.getIndexFromName(RegExp.$1);
            result.chips[i] += parseInt(RegExp.$2);
            result.pot -= parseInt(RegExp.$2);
            return true;
        }
        return false;
    },
    readNow: function(hh) {
    },
    readNext: function(hh) {
    }
};
