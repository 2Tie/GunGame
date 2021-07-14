
declare global.number[0] with network priority local
declare global.number[1] with network priority local
declare global.number[2] with network priority local = 1
declare global.number[3] with network priority local = -1
declare global.number[4] with network priority high
declare global.number[5] with network priority high
declare global.number[6] with network priority high
declare global.player[0] with network priority local
declare global.player[1] with network priority local
declare player.number[0] with network priority local
declare player.number[1] with network priority low
declare player.number[2] with network priority local
declare player.number[3] with network priority high
declare player.timer[0] = 5
declare player.timer[1] = script_option[1]
declare player.timer[2] = script_option[2]
declare object.player[0] with network priority low

for each player do
   current_player.apply_traits(script_traits[6])
end

if game.teams_enabled == 1 then 
   for each object with label "ffa_only" do
      current_object.delete()
   end
end

if game.teams_enabled == 0 then 
   for each object with label "team_only" do
      current_object.delete()
   end
end

for each player do
   if current_player.is_elite() then 
      current_player.set_loadout_palette(elite_tier_1)
   end
   if not current_player.is_elite() then 
      current_player.set_loadout_palette(spartan_tier_1)
   end
end

for each player do
   current_player.set_round_card_title("Get a new weapon with each kill,\r\n23 weapons to master.")
end

for each player do
   current_player.timer[0].set_rate(-100%)
   if current_player.number[1] == 0 and current_player.timer[0].is_zero() then 
	  global.number[1] = rand(21)
	  if global.number[1] < 15 then
	     send_incident(custom_game_start, current_player, no_player)
	  end
	  if global.number[1] == 15 then
	     send_incident(yoink, current_player, no_player)
	  end
	  if global.number[1] == 16 then
	     send_incident(infection_15x, current_player, no_player)
	  end
	  if global.number[1] == 17 then
	     send_incident(40_in_a_row, current_player, no_player)
	  end
	  if global.number[1] == 18 then
	     send_incident(checkpoint_reached, current_player, no_player)
	  end
	  if global.number[1] == 19 then
	     send_incident(inf_new_zombie, current_player, no_player)
	  end
	  if global.number[1] == 20 then
		 send_incident(game_over, current_player, no_player)
      end
      game.show_message_to(current_player, none, "Original by TrustySnooze")
      if script_option[0] == 1 then 
         current_player.number[3] = 21
      end
	  game.show_message_to(current_player, none, "Modified by 2Tie")
      game.show_message_to(current_player, none, "Version 1.20")
      current_player.number[1] = 1
   end
end

for each player do
   global.number[1] = 0
   current_player.script_stat[0] = current_player.rating
   current_player.number[0] = 0
   if game.teams_enabled == 1 then 
      global.number[1] = current_player.team.get_scoreboard_pos()
   end
   if game.teams_enabled == 0 then 
      global.number[1] = current_player.get_scoreboard_pos()
   end
   if global.number[1] == 1 and not current_player.score == 0 then 
      current_player.number[0] = 1
   end
end

if script_option[9] == 3 then 
   for each object with label 1 do
      current_object.delete()
   end
end

for each player do
   global.number[1] = 0
   if current_player.killer_type_is(guardians | suicide | kill | betrayal | quit) then 
      if current_player.killer_type_is(kill) then 
         global.player[0] = current_player.try_get_killer()
         do --check weapon kills
            global.number[3] = current_player.try_get_death_damage_type()
            if global.number[3] > 3 and global.number[3] < 22 then
			   global.number[1] = 1
			end
			--ignore plasma_grenade, so stick setting is adhered to
			if global.number[1] == 1 or global.number[3] == 23 or global.number[3] == 54 or global.number[3] == 55 or global.number[3] == 63 or global.number[3] == 64 then
               global.player[0].score += 1
               if script_option[0] != 1 then 
                  global.player[0].number[3] += 1
               end
               if script_option[0] == 1 then 
                  global.player[0].number[3] -= 1
               end
               game.play_sound_for(global.player[0], timer_beep, true)
               game.show_message_to(all_players, none, "%s promoted!", global.player[0])
               global.player[0].timer[1].reset()
               global.player[0].script_stat[3] += 1
            end
         end
         global.number[0] = current_player.try_get_death_damage_mod()
		 global.number[1] = 0
         if global.number[0] == 1 and script_option[5] != 0 and script_option[5] != -1 then --pummel
		    global.number[1] = 1
		 end
		 if global.number[0] == 2 and script_option[3] != 0 and script_option[3] != -1 then --backsmack
		    global.number[1] = 1
		 end
		 if global.number[0] == 4 and script_option[4] != 0 and script_option[4] != -1 then --stick
		    global.number[1] = 1
		 end
		 if global.number[3] != 43 then --verify weapon is melee_generic, to prevent double points from sword and hammer
		    global.number[1] = 0
		 end
		 if global.number[1] == 1 then --handle promote/all
			if script_option[0] != 1 then
               global.player[0].number[3] += 1
               global.player[0].script_stat[3] += 1
               global.player[0].score += 1
               global.player[0].timer[1].reset()
            end
			if script_option[0] == 1 then
			   global.player[0].number[3] -= 1
               global.player[0].script_stat[3] += 1
               global.player[0].score += 1
               global.player[0].timer[1].reset()
			end
		 end
		 global.number[1] = 0
         if global.number[0] == 1 and script_option[5] != 1 and script_option[5] != -1 then
		    global.number[1] = 1
		 end
		 if global.number[0] == 2 and script_option[3] != 1 and script_option[3] != -1 then
		    global.number[1] = 1
		 end
		 if global.number[0] == 4 and script_option[4] != 1 and script_option[4] != -1 then
		    global.number[1] = 1
		 end
		 if global.number[1] == 1 then --handle demote/all
			if script_option[0] != 1 then
               current_player.number[3] -= 1
               current_player.script_stat[3] -= 1
               global.player[0].script_stat[1] += 1
               current_player.score -= 1
               game.play_sound_for(current_player, boneyard_generator_power_down, true)
               game.show_message_to(all_players, none, "%s demoted %s!", global.player[0], current_player)
               if current_player.number[3] == 22 then 
                  game.play_sound_for(global.player[0], announce_vip_killed, true)
                  send_incident(vip_kill, global.player[0], current_player)
                  current_player.timer[2].reset()
               end
            end
            if script_option[0] == 1 then 
               current_player.number[3] += 1
               current_player.script_stat[3] -= 1
               global.player[0].script_stat[1] += 1
               current_player.score -= 1
               game.play_sound_for(current_player, boneyard_generator_power_down, true)
               game.show_message_to(all_players, none, "%s demoted %s!", global.player[0], current_player)
               if current_player.number[3] == 0 then 
                  game.play_sound_for(global.player[0], announce_vip_killed, true)
                  send_incident(vip_kill, global.player[0], current_player)
                  current_player.timer[2].reset()
               end
            end
         end
         if global.number[0] == 4 and script_option[6] == 0 or script_option[6] == 2 then 
            global.player[0].plasma_grenades += 1
            game.show_message_to(global.player[0], none, "You have received additional grenades!")
         end
      end
   end
end

for each player do
   if current_player.killer_type_is(guardians | suicide | kill | betrayal | quit) and not current_player.killer_type_is(kill) and not current_player.killer_type_is(betrayal) then 
   end
end

for each player do
   if current_player.killer_type_is(betrayal) then 
      global.player[0] = current_player.try_get_killer()
   end
end

if game.round_time_limit > 0 and game.round_timer.is_zero() then 
   game.end_round()
end

for each player do
   if current_player.number[0] == 1 then 
      current_player.apply_traits(script_traits[5])
   end
end

for each object do
   if script_option[8] == 1 then 
      current_object.set_invincibility(1)
   end
end

for each object with label "attach_base" do
   global.object[0] = current_object
   for each object with label "attachment" do
      if global.object[0].spawn_sequence == current_object.spawn_sequence then 
         current_object.attach_to(global.object[0], 0, 0, 0, relative)
      end
   end
end

for each player do
   script_widget[0].set_text("Traits Applied")
   script_widget[0].set_visibility(current_player, false)
   if current_player.score < 22 then
      script_widget[1].set_text("%n/22 Completed", hud_player.score)
      script_widget[1].set_visibility(current_player, true)
   end
   if current_player.score > 21 then
      global.number[2] = 30
	  global.number[2] -= current_player.score
	  
      script_widget[1].set_visibility(current_player, false)
      script_widget[2].set_text("%n Kills To Win", global.number[2])
      script_widget[2].set_visibility(current_player, true)
   end
   if script_option[1] != 0 then 
      script_widget[3].set_text("Handicap Timer:  %s", hud_player.timer[1])
      script_widget[3].set_visibility(current_player, true)
   end
end

for each object with label "trait_zone" do
   current_object.set_invincibility(1)
   current_object.set_pickup_permissions(everyone)
   current_object.set_shape_visibility(everyone)
   for each player do
      if current_object.team == current_player.team or current_object.team == neutral_team and current_object.shape_contains(current_player.biped) then 
         script_widget[0].set_visibility(current_player, true)
         if current_object.spawn_sequence == 0 then 
            current_player.apply_traits(script_traits[2])
            script_widget[0].set_visibility(current_player, true)
         end
         if current_object.spawn_sequence == 1 then 
            current_player.apply_traits(script_traits[3])
            script_widget[0].set_visibility(current_player, true)
         end
      end
   end
end

for each object with label "scale" do
   current_object.set_waypoint_priority(high)
   if current_object.spawn_sequence == -3 then 
      current_object.set_scale(25)
   end
   if current_object.spawn_sequence == -2 then 
      current_object.set_scale(50)
   end
   if current_object.spawn_sequence == -1 then 
      current_object.set_scale(75)
   end
   if current_object.spawn_sequence == 0 then 
      current_object.set_scale(100)
   end
   if current_object.spawn_sequence == 1 then 
      current_object.set_scale(125)
   end
   if current_object.spawn_sequence == 2 then 
      current_object.set_scale(150)
   end
   if current_object.spawn_sequence == 3 then 
      current_object.set_scale(175)
   end
   if current_object.spawn_sequence == -4 then 
      current_object.set_scale(0)
   end
   if current_object.spawn_sequence == 4 then 
      current_object.set_scale(200)
   end
   if current_object.spawn_sequence == 5 then 
      current_object.set_scale(225)
   end
   if current_object.spawn_sequence == 6 then 
      current_object.set_scale(250)
   end
   if current_object.spawn_sequence == 7 then 
      current_object.set_scale(275)
   end
   if current_object.spawn_sequence == 8 then 
      current_object.set_scale(300)
   end
   if current_object.spawn_sequence == 16 then 
      current_object.set_scale(500)
   end
end

for each object with label "civilian" do
   global.object[3] = current_object
   for each object do
      global.number[2] = current_object.get_distance_to(global.object[3])
      global.player[1] = current_object.try_get_carrier()
      if global.number[2] == 0 and global.player[1] == no_player and global.object[3] != current_object and not current_object.is_of_type(spartan) and not current_object.is_of_type(elite) and not current_object.is_of_type(monitor) then 
         current_object.delete()
      end
   end
end

for each object with label "harmless" do
   global.object[6] = current_object
   for each object do
      global.number[2] = current_object.get_distance_to(global.object[6])
      global.player[1] = current_object.try_get_carrier()
      if global.number[2] == 0 and global.player[1] == no_player and global.object[6] != current_object and not current_object.is_of_type(spartan) and not current_object.is_of_type(elite) and not current_object.is_of_type(monitor) then 
         current_object.attach_to(global.object[6], 0, 0, 0, relative)
      end
   end
end

for each player do
   if script_option[0] != 2 and current_player.number[1] == 1 then 
      current_player.object[0] = current_player.try_get_weapon(primary)
      if current_player.number[3] < 1 and not current_player.object[0].is_of_type(rocket_launcher) then 
         current_player.biped.remove_weapon(primary, true)
         current_player.biped.remove_weapon(secondary, true)
         current_player.biped.add_weapon(rocket_launcher, force)
         current_player.timer[1].set_rate(-100%)
      end
      if current_player.number[3] == 1 and not current_player.object[0].is_of_type(fuel_rod_gun) then 
         current_player.biped.remove_weapon(primary, true)
         current_player.biped.remove_weapon(secondary, true)
         current_player.biped.add_weapon(fuel_rod_gun, force)
         current_player.timer[1].set_rate(-100%)
      end
      if current_player.number[3] == 2 and not current_player.object[0].is_of_type(sniper_rifle) then 
         current_player.biped.remove_weapon(primary, true)
         current_player.biped.remove_weapon(secondary, true)
         current_player.biped.add_weapon(sniper_rifle, force)
         current_player.timer[1].set_rate(-100%)
      end
      if current_player.number[3] == 3 and not current_player.object[0].is_of_type(needle_rifle) then 
         current_player.biped.remove_weapon(primary, true)
         current_player.biped.remove_weapon(secondary, true)
         current_player.biped.add_weapon(needle_rifle, force)
         current_player.timer[1].set_rate(-100%)
      end
      if current_player.number[3] == 4 and not current_player.object[0].is_of_type(dmr) then 
         current_player.biped.remove_weapon(primary, true)
         current_player.biped.remove_weapon(secondary, true)
         current_player.biped.add_weapon(dmr, force)
         current_player.timer[1].set_rate(-100%)
      end
      if current_player.number[3] == 5 and not current_player.object[0].is_of_type(concussion_rifle) then 
         current_player.biped.remove_weapon(primary, true)
         current_player.biped.remove_weapon(secondary, true)
         current_player.biped.add_weapon(concussion_rifle, force)
         current_player.timer[1].set_rate(-100%)
      end
      if current_player.number[3] == 6 and not current_player.object[0].is_of_type(detached_machine_gun_turret) then 
         current_player.biped.remove_weapon(primary, true)
         current_player.biped.remove_weapon(secondary, true)
         current_player.biped.add_weapon(detached_machine_gun_turret, force)
         current_player.timer[1].set_rate(-100%)
      end
      if current_player.number[3] == 7 and not current_player.object[0].is_of_type(detached_plasma_cannon) then 
         current_player.biped.remove_weapon(primary, true)
         current_player.biped.remove_weapon(secondary, true)
         current_player.biped.add_weapon(detached_plasma_cannon, force)
         current_player.timer[1].set_rate(-100%)
      end
      if current_player.number[3] == 8 and not current_player.object[0].is_of_type(focus_rifle) then 
         current_player.biped.remove_weapon(primary, true)
         current_player.biped.remove_weapon(secondary, true)
         current_player.biped.add_weapon(focus_rifle, force)
         current_player.timer[1].set_rate(-100%)
      end
      if current_player.number[3] == 9 and not current_player.object[0].is_of_type(grenade_launcher) then 
         current_player.biped.remove_weapon(primary, true)
         current_player.biped.remove_weapon(secondary, true)
         current_player.biped.add_weapon(grenade_launcher, force)
         current_player.timer[1].set_rate(-100%)
      end
      if current_player.number[3] == 10 and not current_player.object[0].is_of_type(needler) then 
         current_player.biped.remove_weapon(primary, true)
         current_player.biped.remove_weapon(secondary, true)
         current_player.biped.add_weapon(needler, force)
         current_player.timer[1].set_rate(-100%)
      end
      if current_player.number[3] == 11 and not current_player.object[0].is_of_type(energy_sword) then 
         current_player.biped.remove_weapon(primary, true)
         current_player.biped.remove_weapon(secondary, true)
         current_player.biped.add_weapon(energy_sword, force)
         current_player.timer[1].set_rate(-100%)
      end
      if current_player.number[3] == 12 and not current_player.object[0].is_of_type(gravity_hammer) then 
         current_player.biped.remove_weapon(primary, true)
         current_player.biped.remove_weapon(secondary, true)
         current_player.biped.add_weapon(gravity_hammer, force)
         current_player.timer[1].set_rate(-100%)
      end
      if current_player.number[3] == 13 and not current_player.object[0].is_of_type(shotgun) then 
         current_player.biped.remove_weapon(primary, true)
         current_player.biped.remove_weapon(secondary, true)
         current_player.biped.add_weapon(shotgun, force)
         current_player.timer[1].set_rate(-100%)
      end
      if current_player.number[3] == 14 and not current_player.object[0].is_of_type(magnum) then 
         current_player.biped.remove_weapon(primary, true)
         current_player.biped.remove_weapon(secondary, true)
         current_player.biped.add_weapon(magnum, force)
         current_player.timer[1].set_rate(-100%)
      end
      if current_player.number[3] == 15 and not current_player.object[0].is_of_type(spartan_laser) then 
         current_player.biped.remove_weapon(primary, true)
         current_player.biped.remove_weapon(secondary, true)
         current_player.biped.add_weapon(spartan_laser, force)
         current_player.timer[1].set_rate(-100%)
      end
      if current_player.number[3] == 16 and not current_player.object[0].is_of_type(plasma_launcher) then 
         current_player.biped.remove_weapon(primary, true)
         current_player.biped.remove_weapon(secondary, true)
         current_player.biped.add_weapon(plasma_launcher, force)
         current_player.timer[1].set_rate(-100%)
      end
      if current_player.number[3] == 17 and not current_player.object[0].is_of_type(plasma_rifle) then 
         current_player.biped.remove_weapon(primary, true)
         current_player.biped.remove_weapon(secondary, true)
         current_player.biped.add_weapon(plasma_rifle, force)
         current_player.timer[1].set_rate(-100%)
      end
      if current_player.number[3] == 18 and not current_player.object[0].is_of_type(assault_rifle) then 
         current_player.biped.remove_weapon(primary, true)
         current_player.biped.remove_weapon(secondary, true)
         current_player.biped.add_weapon(assault_rifle, force)
         current_player.timer[1].set_rate(-100%)
      end
      if current_player.number[3] == 19 and not current_player.object[0].is_of_type(spiker) then 
         current_player.biped.remove_weapon(primary, true)
         current_player.biped.remove_weapon(secondary, true)
         current_player.biped.add_weapon(spiker, force)
         current_player.timer[1].set_rate(-100%)
      end
      if current_player.number[3] == 20 and not current_player.object[0].is_of_type(plasma_repeater) then 
         current_player.biped.remove_weapon(primary, true)
         current_player.biped.remove_weapon(secondary, true)
         current_player.biped.add_weapon(plasma_repeater, force)
         current_player.timer[1].set_rate(-100%)
      end
      if current_player.number[3] == 21 and not current_player.object[0].is_of_type(plasma_pistol) then 
         current_player.biped.remove_weapon(primary, true)
         current_player.biped.remove_weapon(secondary, true)
         current_player.biped.add_weapon(plasma_pistol, force)
         current_player.timer[1].set_rate(-100%)
      end
	  
      if current_player.score > 21 and not current_player.object[0].is_of_type(golf_club) then 
         current_player.biped.remove_weapon(primary, true)
         current_player.biped.remove_weapon(secondary, true)
         current_player.biped.add_weapon(golf_club, force)
         current_player.timer[1].set_rate(-100%)
      end
   end
end

for each player do
   current_player.biped.set_waypoint_visibility(no_one)
   if current_player.score > 21 then 
      current_player.apply_traits(script_traits[1])
      if current_player.score > 24 then 
         current_player.biped.set_waypoint_icon(vip)
		 current_player.biped.set_waypoint_text("")
         current_player.biped.set_waypoint_priority(blink)
		 if script_option[7] == 0 then
            current_player.biped.set_waypoint_visibility(everyone)
		 end
         current_player.apply_traits(script_traits[4])
      end
   end
end

for each player do
   if current_player.score > 29 then 
      game.play_sound_for(current_player, inv_cue_spartan_win_big, true)
	  --just let the game handle this lol
	  --game.play_sound_for(current_player, announce_game_over, true)
      --game.end_round()
   end
end

for each player do
   if script_option[0] != 1 and current_player.number[3] < 0 then 
      current_player.apply_traits(script_traits[0])
      if script_option[2] != -7 and current_player.number[3] < script_option[2] then 
         current_player.number[3] = script_option[2]
         current_player.score = script_option[2]
      end
   end
   if script_option[0] == 1 and current_player.number[3] > 21 then 
      current_player.apply_traits(script_traits[0])
      if script_option[2] != -7 then 
         if current_player.number[3] > 22 and script_option[2] == -1 then 
            current_player.number[3] = 22
            current_player.score = -1
         end
         if current_player.number[3] > 21 and script_option[2] == 0 then 
            current_player.number[3] = 21
            current_player.score = 0
         end
      end
   end
end

for each player do
   if script_option[1] != 0 and current_player.timer[1].is_zero() then 
      if script_option[0] != 1 then 
         current_player.number[3] += 1
         current_player.timer[1].reset()
      end
      if script_option[0] == 1 then 
         current_player.number[3] -= 1
         current_player.timer[1].reset()
      end
      current_player.score += 1
      current_player.script_stat[2] += 1
      current_player.script_stat[3] += 1
      game.play_sound_for(current_player, timer_beep, true)
      game.show_message_to(all_players, none, "%s promoted!", current_player)
      if script_option[6] == 1 or script_option[6] == 2 then 
         current_player.plasma_grenades += 1
         game.show_message_to(current_player, none, "You have received additional grenades!")
      end
   end
end

for each player do
   if current_player.score == 21 and current_player.number[2] == 0 then 
      game.play_sound_for(current_player, inv_cue_spartan_win_1, true)
	  current_player.number[2] = 1
   end
   if current_player.score > 21 and current_player.number[2] == 1 then 
      game.play_sound_for(current_player, inv_cue_spartan_win_2, true)
	  current_player.number[2] = 2
   end
end
