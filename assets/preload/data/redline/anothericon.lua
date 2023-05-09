function opponentNoteHit(id, data, noteType)
	if noteType == "No Animation" then
		runHaxeCode([[
			game.iconP2.changeIcon('roc');
		]])
	else	
		runHaxeCode([[
			game.iconP2.changeIcon('leroy');
		]])
	end
end