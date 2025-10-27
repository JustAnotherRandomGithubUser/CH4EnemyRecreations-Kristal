local ClawDrop, super = Class(Wave)

function ClawDrop:init()
    super.init(self)

    self.time = 200/30
	
    self.guei = Game.battle:getEnemyBattler("guei")
end

function ClawDrop:onStart()
    self:spawnBullet("poseur/chaserbullet", Game.battle.arena.right, Game.battle.arena.top)
end

return ClawDrop