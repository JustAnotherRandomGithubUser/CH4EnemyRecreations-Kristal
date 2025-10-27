local Spirals, super = Class(Wave)

function Spirals:init()
    super.init(self)

    self.time = 270/30

    self.enemies = self:getAttackers()
	self.sameattack = 0
	self.sameattacker = 0
	if #self.enemies > 1 then
		self.sameattack = #self.enemies-1
	end

	self.btimer = 0
	self.made = false
end

function Spirals:onStart()
	self.notsameattacker = false
	Game:setFlag("mizzleSpiral", 0)
	for i = 1, #self.enemies do
		if self.sameattack >= 1 then
			if not self.notsameattacker then
				self.sameattacker = Game:getFlag("mizzleSpiral", 0)
				self.notsameattacker = true
			end
			Game:setFlag("mizzleSpiral", Game:getFlag("mizzleSpiral", 0)+1)
		end
	end
end

function Spirals:update()
    super.update(self)
	
    local arena = Game.battle.arena
    self.btimer = self.btimer + DTMULT

	if not self.made then
		self.made = true
        self.btimer = 0
        self.side = 1
        self.offset = 0
        --coat_pop = instance_number(obj_mizzle_enemy);    -- literally an unused variable lmao
        --instance_create(0, 0, obj_coathanger_renderer);  -- apparently this object exists just to spawn outline sprites on the droplet bullets?? wtf Deltarune team lol.
    end
    
    if self.sameattack == #Game.battle.enemies then
        --for _, bullet in ipairs(Game.stage:getObjects(Registry.getBullet("mizzle/holydroplet"))) do
            --bullet.x = bullet.x + ((math.sin((Kristal.getTime()/30) * 0.1) * 1.5) / #Game.battle.enemies)
        --end
    end
    
    local _miz_cd
    if #Game.battle.enemies == self.sameattack then
        _miz_cd = 19 + (#Game.battle.enemies * 3)
    else
        _miz_cd = 22 + (#Game.battle.enemies * 6)
    end
    
    if (self.btimer % _miz_cd) == 0 then
        local do_this = true

        --haven't ported the spotlight attack yet.
        --[[
        with (obj_mizzle_spotlight_controller_b)
        {
            if (alert)
                do_this = false;
        }
        ]]
        
        self.offset = MathUtils.randomInt(-60, 60)
        local circ = 7 + (3 * self.sameattack)
        
        if do_this then
            for a = 0, circ-1 do
                local cside = 90 + (90 * self.side)
                local spiral = self:spawnBullet("mizzle/spiral",arena.x + MathUtils.lengthDirX(128, (cside - 5) + (10 * a) + self.offset), arena.y + MathUtils.lengthDirY(128, (cside - 5) + (10 * a) + self.offset))
                spiral = self:spawnBullet("mizzle/spiral", arena.x + MathUtils.lengthDirX(128, ((cside + 5) - (10 * a)) + self.offset), arena.y + MathUtils.lengthDirY(128, ((cside + 5) - (10 * a)) + self.offset))
            end
        end
        
        self.side = self.side * -1
    end
end

return Spirals