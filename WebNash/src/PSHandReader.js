var PSHandReader = {
    getHeroName:function(hh) {
        var regex = new RegExp("Dealt¥sto¥s(.+)¥s¥[[2-9TJQKA][shdc]¥s[2-9TJQKA][shdc]¥]");
        for(var i = 0; i < hh.length; ++i)
        {
            if(hh[i].match(regex))
                return RegExp.$1;
        }
        return null;
    },
    getStartingChip:function(heroName, hh, defaultValue) { },
    // getHHLineList:function(hh) { },
    // getNowHH:function(hh, lineList, backNum) { },
    setBBSB:function(data, line) { },
    getButtonPos:function(line) { },
    getStartSituation:function(result, hh, line) { },
    calcAntePayment:function(result, hh, line) { },
    calcBlindPayment:function(blind, result, hh, line) { },
    calcBetPayment:function(result, line) { },
    calcCallPayment:function(result, line) { },
    calcRaisePayment:function(result, line) { },
    calcUncalledPayment:function(result, line) { },
    calcCollectPayment:function(result, line) { },
    readNow: function(history) { },
    readNext: function(history) { }
};
