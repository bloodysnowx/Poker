function main()
{
    var Structure = document.HandHistory.Structure.value;
    var Content = document.HandHistory.Content.value;
    var hh = Content.split(/\r\n|\r|\n/);
    var reader = Object.create(PSHandReader);
    var tableData = reader.readNow(hh);
    // window.open("http://bloodysnow.com");
}
