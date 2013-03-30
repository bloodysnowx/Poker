var CheckHeroName = {
    whiteList: ["chiyuki"],
    check: function(name) {
        for(var i = 0; i < this.whiteList.length; ++i) if(name == this.whiteList[i]) return true;
        return false;
    }
};

