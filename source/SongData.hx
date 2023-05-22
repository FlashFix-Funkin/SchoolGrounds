import haxe.ds.StringMap;

class SongData {
    public static var songList:StringMap<{songName : String, artist : String}> = [
        'kmfdm' => {
            songName : "KMFDM",
            artist : "BBpanzu"
        },
        'bathroom-break' => {
            songName : !ClientPrefs.censoring ? "Bathroom Break" : "Potty Break",
            artist : "Requiem"
        },
        'redline' => {
            songName : "Redline",
            artist : "Requiem"
        },
        'mindfuck' => {
            songName : !ClientPrefs.censoring ? "Mindfuck" : "Brainfart",
            artist : "Requiem & KaranXD"
        },
        '2swag' => {
            songName : "2SWAG",
            artist : "Octigone"
        },
        '2swag-erect' => {
            songName : "2SWAG",
            artist : "Octigone"
        },
        'rapman' => {
            songName : "Rapman",
            artist : "Requiem"
        },
        'hall-pass' => {
            songName : "Hall Pass",
            artist : "BBpanzu"
        },
        'whippy' => {
            songName : "Whippy",
            artist : "Evilvaye"
        },
        'yuh' => {
            songName : "Yuh",
            artist : "Requiem"
        },
        'tutorial' => {
            songName: "Tutorial",
            artist: "ev1337"
        },
        'brainstorm' => {
            songName: "Brainstorm",
            artist: "Biddle3"
        },
        'pinkeye' => {
            songName: "Pinkeye",
            artist: "Octigone"
        }
    ];
}