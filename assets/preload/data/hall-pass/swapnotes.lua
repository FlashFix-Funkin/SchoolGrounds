

function onUpdate()
    --Player Notes

    noteTweenX(defaultPlayerStrumX0, 4, defaultPlayerStrumX0 - 650, 0.025)
    noteTweenX(defaultPlayerStrumX1, 5, defaultPlayerStrumX1 - 650, 0.025)
    noteTweenX(defaultPlayerStrumX2, 6, defaultPlayerStrumX2 - 650, 0.025)
    noteTweenX(defaultPlayerStrumX3, 7, defaultPlayerStrumX3 - 650, 0.025)

    --Opponent Notes

    noteTweenX(defaultOpponentStrumX0, 0, defaultOpponentStrumX0 + 650, 0.025)
    noteTweenX(defaultOpponentStrumX1, 1, defaultOpponentStrumX1 + 650, 0.025)
    noteTweenX(defaultOpponentStrumX2, 2, defaultOpponentStrumX2 + 650, 0.025)
    noteTweenX(defaultOpponentStrumX3, 3, defaultOpponentStrumX3 + 650, 0.025)
end