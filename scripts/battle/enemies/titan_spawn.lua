local TitanSpawn, super = Class(EnemyBattler)

function TitanSpawn:init()
    super.init(self)

    self.name = "Titan Spawn"
    self:setActor("titan_spawn")

    self.max_health = 3000
    self.health = 3000
    self.attack = 18
    self.defense = 0
    self.money = 0

    self.disable_mercy = true
    self.spare_points = 0
    self.tired_percentage = -0.5

    self.waves = {}

    self.text = {
        "* You hear your heart beating in \nyour ears.",
        "* When did you start being \nyourself?",
        "* It sputtered in a voice like \ncrushed glass.",
        "* Ralsei mutters to himself to \nstay calm."
    }

	self.low_health_text = nil
	self.tired_text = nil
	self.spareable_text = nil

    self:registerAct("Brighten", "Powerup\nlight", "all", 4)
    self:registerAct("DualHeal", "Heal\nparty",    "all", 16)
    self:registerAct("Banish",   "Defeat\nenemy",  nil,   90)

    self.text_override = nil

    self.exit_on_defeat = false
end

function TitanSpawn:isXActionShort(battler)
    return true
end

function TitanSpawn:onShortAct(battler, name)
    if name == "Standard" then
        if battler.chara.id == "susie" then
            self:addMercy(50)
            local msg = Utils.pick{
                "* Susie ",
            }
            return msg
        elseif battler.chara.id == "ralsei" then
            local msg = Utils.pick{
                "* Ralsei ",
            }
            return msg
        end
    end
    return nil
end

function TitanSpawn:onAct(battler, name)
	if name == "Check" then
        if Game:getTension() >= 90 then 
            return {
                "* TITAN SPAWN - AT 30 DF 200\n* A shard of fear. Appears \nin places of deep dark.",
                "* The atmosphere feels tense...\n* (You can use [color:yellow]BANISH[color:reset]!)"
            }
        else
            return {
                "* TITAN SPAWN - AT 30 DF 200\n* A shard of fear. Appears \nin places of deep dark.",
                "* Expose it to LIGHT... and gather COURAGE to gain TP.",
                "* Then, \"[color:yellow]BANISH[color:reset]\" it!",
            }
        end
    elseif name == "Standard" then
        if battler.chara.id == "susie" then
        elseif battler.chara.id == "ralsei" then
        end
    end
    return super.onAct(self, battler, name)
end

function TitanSpawn:getEnemyDialogue()
    return false
end

function TitanSpawn:update()
    if self.hurt_timer == -1 then
    end

    super.update(self)
end

function TitanSpawn:onHurt(damage, battler)
	super.onHurt(self, damage, battler)

    Assets.stopAndPlaySound("spawn_weaker")
end

function TitanSpawn:onDefeat(damage, battler)
	super.onDefeat(self, damage, battler)

    self:onDefeatFatal(damage, battler)
end

function TitanSpawn:getEncounterText()
	if Game:getTension() < 90 and love.math.random(0, 100) < 3 then
		return "* Smells like adrenaline."
    elseif Game:getTension() >= 90 then 
		return "* The atmosphere feels tense...\n* (You can use [color:yellow]BANISH[color:reset]!)"
	else
		return super.getEncounterText(self)
	end
end

function TitanSpawn:getGrazeTension()
    return 0
end

return TitanSpawn