function main(Structure, Content, isNext)
{
    var hh = Content.split(/\r\n|\r|\n/);
    var reader = Object.create(PSHandReader);
    var tableData = Object.create(TableData);
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
