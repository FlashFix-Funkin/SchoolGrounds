function onCreatePost()
    for i = 0, getProperty('strumLineNotes.members.length') do
        local name = i >= 4 and 'Opponent' or 'Player'
        setProperty('strumLineNotes.members['..i..'].x', _G['default'..name..'StrumX'..i%4])
        setProperty('strumLineNotes.members['..i..'].y', _G['default'..name..'StrumY'..i%4])
    end
end