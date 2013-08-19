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

