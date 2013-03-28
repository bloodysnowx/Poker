function main()
{
    var Structure = document.HandHistory.Structure.value;
    var Content = document.HandHistory.Content.value;
    var hh = Content.split(/\r\n|\r|\n/);
    var reader = Object.create(PSHandReader);
    var tableData = Object.create(TableData);
    reader.readNext(tableData, hh);
    tableData.calcPositions();
    var url = "http://www.holdemresources.net/hr/sngs/icmcalculator.html?action=calculate&bb=";
    url += tableData.BB;
    url += "&sb=" + tableData.SB;
    url += "&ante=" + tableData.Ante;
    url += "&structure=" + Structure;
    for(var i = 0; i <= tableData.MaxSeatNum; ++i)
        if(tableData.chips[i] > 0) url += "&s" + tableData.positions[i] + "=" + tableData.chips[i];
    window.open(url);
}
