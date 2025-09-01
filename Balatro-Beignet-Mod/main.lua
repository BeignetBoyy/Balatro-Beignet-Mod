--- STEAMODDED HEADER
--- MOD_NAME: Beignet mod
--- MOD_ID: BEIGNETMOD
--- MOD_AUTHOR: [BeignetBoyy]
--- MOD_DESCRIPTION: A mod that adds shit jokers.
--- PREFIX: bgnt
----------------------------------------------
------------MOD CODE -------------------------


SMODS.Atlas{
    key = 'Evil Joker', --atlas key
    path = 'evil_joker.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
SMODS.Joker{
    key = 'evil', --joker key
    loc_txt = { -- local text
        name = 'Evil Joker',
        text = {
          'When Blind is selected,',
          'destroy all jokers',
          'Playing a hand sets money to {C:money}0${}',
          '{X:mult,C:white}X#1#{} Mult'
        },
    },
    atlas = 'Evil Joker', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 1, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        Xmult = 0 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            if G.GAME.dollars ~= 0 then
                ease_dollars(-G.GAME.dollars, true)
            end

            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT
            }
        end

        if context.setting_blind then
            local destructable_jokers = {}
            for i = 1, #G.jokers.cards do
                --print("JOKER : ", G.jokers.cards[i].label)
                if G.jokers.cards[i].label ~= "j_bgnt_evil" then destructable_jokers[#destructable_jokers+1] = G.jokers.cards[i] end
            end

            local _first_dissolve = nil
            for k, v in pairs(destructable_jokers) do
                if v ~= eligible_card then v:start_dissolve(nil, _first_dissolve);_first_dissolve = true end
            end

            return {
                card = card,
                message = 'Fuck You',
                colour = G.C.MULT
            }
        end
    end
}


-------------------- JOKER DAVID --------------------------

SMODS.Atlas{
    key = 'Updated Autopsy Report', --atlas key
    path = 'david.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
SMODS.Joker{
    key = 'david', --joker key
    loc_txt = { -- local text
        name = 'Updated Autopsy Report',
        text = {
          'If played hand is different',
          'from the previous one',
          'This joker gains {C:mult}+1{} mult',
          '{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)',
          '{C:inactive}Last played hand :{} #2#'
        },
    },
    atlas = 'Updated Autopsy Report', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 1, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        mult = 0, --configurable value
        previous_hand = "None"
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {
            center.ability.extra.mult,
            center.ability.extra.previous_hand
        }} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self,card,context)

        if context.before then
            --print("previous : ", card.ability.extra.previous_hand)
            --print("current : ", G.GAME.last_hand_played)
            --print("Different : ", G.GAME.last_hand_played ~= card.ability.extra.previous_hand)

            if G.GAME.last_hand_played ~= card.ability.extra.previous_hand then
                card.ability.extra.mult = card.ability.extra.mult + 1

                card.ability.extra.previous_hand = G.GAME.last_hand_played   

                return {
                    card = card,
                    message = 'Objection',
                    colour = G.C.MULT
                }

            end  
            card.ability.extra.previous_hand = G.GAME.last_hand_played   
        end

        if context.joker_main then

            return {
                card = card,
                mult_mod = card.ability.extra.mult,
                message = '+' .. card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
    end
}

-------------------- JONKLER --------------------------

SMODS.Atlas{
    key = 'jonkler', --atlas key
    path = 'jonkler.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}

SMODS.Joker{
    key = 'jonkler', --joker key
    loc_txt = { -- local text
        name = 'Jonkler',
        text = {
          'Base {C:chips}chips{} and',
          '{C:mult}mult{} are reversed.',
          '{C:attention}Destroy{} a random card',
          'from scoring hand'
        },
    },
    atlas = 'jonkler', --atlas' key
    rarity = 4, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    soul_pos = { x = 1, y = 0 },
    cost = 20, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = false, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
        extra = {
            id_to_destroy = 0,
            hands_switched = {
                ["Flush Five"] = false,
                ["Flush House"] = false,
                ["Five of a Kind"] = false,
                ["Straight Flush"] = false,
                ["Four of a Kind"] = false,
                ["Full House"] = false,
                ["Flush"] = false,
                ["Straight"] = false,
                ["Three of a Kind"] = false,
                ["Two Pair"] = false,
                ["Pair"] = false,
                ["High Card"] = false,
            }
        }
    },
    loc_vars = function(self,info_queue,center)
        return {
            vars = {
                center.ability.extra.id_to_destroy,
                center.ability.extra.hands_switched
            }
        } --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self,card,context)
        local destroyed_cards = {}
        local card_to_destroy

        if context.before then

            --print("ID : ", card.ability.extra)

            --print("Chips : ", G.GAME.hands[G.GAME.last_hand_played].chips)
            --print("Mult : ", G.GAME.hands[G.GAME.last_hand_played].mult)


            -- choose card to destroy

            destroyed_cards[#destroyed_cards+1] = pseudorandom_element(G.play.cards, pseudoseed('random_destroy'))
            card_to_destroy = destroyed_cards[1]
            card.ability.extra.id_to_destroy = destroyed_cards[1].ID
            --print(card_to_destroy.ID)

            --invert chips and mult

            if not card.ability.extra.hands_switched[G.GAME.last_hand_played] then
                local temp = G.GAME.hands[G.GAME.last_hand_played].chips
                G.GAME.hands[G.GAME.last_hand_played].chips = G.GAME.hands[G.GAME.last_hand_played].mult
                G.GAME.hands[G.GAME.last_hand_played].mult = temp
    
                update_hand_text({delay = 0}, {mult = G.GAME.hands[G.GAME.last_hand_played].mult, chips = G.GAME.hands[G.GAME.last_hand_played].chips})

                card.ability.extra.hands_switched[G.GAME.last_hand_played] = true
                
                return {
                    card = card,
                    message = 'Why so serious ?',
                    colour = G.C.MULT
                }
            end
        end

        if context.selling_self then 
            for hand, switched in pairs(card.ability.extra.hands_switched) do
                if switched then 
                    local temp = G.GAME.hands[hand].chips
                    G.GAME.hands[hand].chips = G.GAME.hands[hand].mult
                    G.GAME.hands[hand].mult = temp
                end
            end

            return {
                card = card,
                message = 'Society',
                colour = G.C.MULT
            }
        end

        if context.destroying_card and not context.blueprint and context.destroying_card.ID == card.ability.extra.id_to_destroy then

            --print(context.destroying_card.ID)
            card_eval_status_text(
                card,
                "extra",
                nil,
                nil,
                nil,
                { message = 'BWAHAHAH', colour = G.C.FILTER }
            )

            return { remove = not context.destroying_card.ability.eternal }
		end
    end
}

-------------------- MONKEY --------------------------

SMODS.Atlas{
    key = 'Monkey', --atlas key
    path = 'monke.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
SMODS.Joker{
    key = 'monkey', --joker key
    loc_txt = { -- local text
        name = 'Monkey',
        text = {
          'When Blind is selected,',
          'if one of your jokers is a {C:attention}banana{},',
          'destroy it and gain {X:mult,C:white}X1{} Mult.',
          '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
        },
    },
    atlas = 'Monkey', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 7, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        Xmult = 1 --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self,card,context)

        if context.setting_blind then
            destroyed = false --If any jokers have been destroyed
            local destructable_jokers = {}

            for i = 1, #G.jokers.cards do
                --print("JOKER : ", G.jokers.cards[i].label)

                if G.jokers.cards[i].label == "Gros Michel" or G.jokers.cards[i].label == "Cavendish" then 
                    destructable_jokers[#destructable_jokers+1] = G.jokers.cards[i] 
                end
            end

            local _first_dissolve = nil
            for k, v in pairs(destructable_jokers) do
                if v ~= eligible_card then 
                    v:start_dissolve(nil, _first_dissolve);_first_dissolve = true 
                end
                card.ability.extra.Xmult = card.ability.extra.Xmult + 1
                destroyed = true
            end

            if destroyed then
                return {
                    card = card,
                    message = 'X' .. card.ability.extra.Xmult,
                    colour = G.C.MULT
                }
            end
        end

        if context.joker_main then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT
            }
        end

    end
}

-------------------- NONARY --------------------------

SMODS.Atlas{
    key = 'Nonary', --atlas key
    path = 'nonary.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
SMODS.Joker{
    key = 'nonary', --joker key
    loc_txt = { -- local text
        name = 'Nonary',
        text = {
          'If the sum of the base {C:chips}chips{}', 
          'of scored cards is equal',
          'to {C:attention}9{}, destroy them',
          'and create an {C:attention}enhanced 9{}'
        },
    },
    atlas = 'Nonary', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 5, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
    config = { 
      extra = {
        destroy_cards = false --configurable value
      }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.destroy_cards}} --#1# is replaced with card.ability.extra.Xmult
    end,
    calculate = function(self,card,context)

        -- Digital root logic, we check each card from the full hand and sum the chips together
        if context.before and context.full_hand then
            local chips_sum = 0
			for i = 1, #context.full_hand do
				chips_sum = chips_sum + context.full_hand[i]:get_id()
			end
            -- If the total chips sums up to 9 we store the full hand in the cards_to_destroy array
            if chips_sum == 9 then 
                card.ability.extra.destroy_cards = true
            end
        end

        -- Card destruction, I couldn't do it without and event because it kept triggering instantly
        if context.destroying_card and card.ability.extra.destroy_cards and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function() 
                    local destroy = context.full_hand
                    for i = #destroy, 1, -1 do
                        local card = destroy[i]
                        if SMODS.shatters(card) then
                            card:shatter()
                        else
                            card:start_dissolve(nil, i == #destroy)
                        end
                    end
                return true 
            end }))

            return {
                card = card,
                message = 'Funyarinpa',
                colour = G.C.MULT
            }
        end  

        if context.final_scoring_step then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.7,
                func = function() 
                    local cards = {}
                    local _suit, _rank = nil, nil
                    _rank = '9'
                    _suit = pseudorandom_element({'S','H','D','C'}, pseudoseed('nonary_create'))
                    local cen_pool = {}
                    for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                        if v.key ~= 'm_stone' then 
                            cen_pool[#cen_pool+1] = v
                        end
                    end


                    create_playing_card({front = G.P_CARDS[_suit..'_'.._rank], center = pseudorandom_element(cen_pool, pseudoseed('spe_card'))}, G.hand, nil, false, {G.C.SECONDARY_SET.Spectral})
                return true 
            end }))
        end
    end
}

----------------------------------------------
------------MOD CODE END----------------------
    
