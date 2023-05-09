package costumes;

import Character;

class CostumeHandler {
    public static var costumes:Array<CostumeFile> = [
        
    ];
}

typedef CostumeFile = {
    name : String,
    description : String,
    predicate : String,
    character : Character
}