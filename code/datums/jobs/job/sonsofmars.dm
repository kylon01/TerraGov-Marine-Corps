/datum/job/som
	job_category = JOB_CAT_MARINE
	access = ALL_ANTAGONIST_ACCESS
	minimal_access = ALL_ANTAGONIST_ACCESS
	faction = FACTION_SOM


/datum/outfit/job/som/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.undershirt = 6
	H.regenerate_icons()

//Base job for normal gameplay SOM, not ERT.
/datum/job/som/squad
	access = ALL_ANTAGONIST_ACCESS
	minimal_access = ALL_ANTAGONIST_ACCESS
	supervisors = "the acting squad leader"
	selection_color = "#ffeeee"
	exp_type_department = EXP_TYPE_MARINES

/datum/job/som/squad/radio_help_message(mob/M)
	. = ..()
	if(istype(SSticker.mode, /datum/game_mode/combat_patrol))
		to_chat(M, span_highdanger("Your platoon has orders to patrol a remote territory illegally claimed by TerraGov imperialists. Intel suggests TGMC units are similarly trying to press their claims by force. Work with your team and eliminate all TGMC you encounter while preserving your own strength! High Command considers wiping out all enemies a major victory, or inflicting more casualties a minor victory."))
		return

/datum/job/som/squad/after_spawn(mob/living/carbon/C, mob/M, latejoin = FALSE)
	. = ..()
	C.hud_set_job(faction)
	if(!ishuman(C))
		return
	var/mob/living/carbon/human/human_spawn = C
	if(!(human_spawn.species.species_flags & ROBOTIC_LIMBS))
		human_spawn.set_nutrition(rand(60, 250))
	if(!human_spawn.assigned_squad)
		CRASH("after_spawn called for a marine without an assigned_squad")
	to_chat(M, {"\nYou have been assigned to: <b><font size=3 color=[human_spawn.assigned_squad.color]>[lowertext(human_spawn.assigned_squad.name)] squad</font></b>.
Make your way to the cafeteria for some post-cryosleep chow, and then get equipped in your squad's prep room."})

/datum/job/som/squad/equip_spawning_squad(mob/living/carbon/human/new_character, datum/squad/assigned_squad, client/player)
	if(!assigned_squad)
		SSjob.JobDebug("Failed to put marine role in squad. Player: [player.key] Job: [title]")
		return
	assigned_squad.insert_into_squad(new_character)

//SOM Standard
/datum/job/som/squad/standard
	title = SOM_SQUAD_MARINE
	paygrade = "SOM1"
	comm_title = "Mar"
	minimap_icon = "private"
	display_order = JOB_DISPLAY_ORDER_SQUAD_MARINE
	total_positions = -1
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS
	outfit = /datum/outfit/job/som/squad/standard
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_REGULAR,
		/datum/job/som/squad/veteran = VETERAN_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Easy<br /><br />
		<b>You answer to the</b> acting Squad Leader<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Combat patrol<br /><br /><br />
		The backbone of the Sons of Mars are their rank and file marines, trained and equipped to fight the conventional military of their former oppressors. They are fitted with the standard arsenal that the SOM offers, equipped with traditional projectile weaponry as well are less common but more deadly volkite weapons as the SOM's industry allows. They’re often high in numbers and divided into squads, but they’re the lowest ranking individuals, with a low degree of skill, not adapt to engineering or medical roles. Still, they are not limited to the arsenal they can take on the field to deal whatever threat that lurks against the Sons of Mars.
		<br /><br />
		<b>Duty</b>: Carry out orders made by your acting Squad Leader, deal with any threats that oppose the Sons of Mars.
	"}

/datum/job/som/squad/standard/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"\nYou are a rank-and-file soldier of the Sons of Mars, and that is your strength.
What you lack alone, you gain standing shoulder to shoulder with the men and women of the SOM. For Mars!"})

/datum/outfit/job/som/squad/standard
	name = "SOM Standard"
	jobtype = /datum/job/som/squad/standard

	id = /obj/item/card/id/dogtag/som


/datum/job/som/squad/engineer
	title = SOM_SQUAD_ENGINEER
	paygrade = "SOM2"
	comm_title = "Eng"
	total_positions = 12
	skills_type = /datum/skills/combat_engineer
	display_order = JOB_DISPLAY_ORDER_SUQAD_ENGINEER
	outfit = /datum/outfit/job/som/squad/engineer
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_REGULAR,
		/datum/job/som/squad/veteran = VETERAN_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Medium<br /><br />
		<b>You answer to the</b> acting Squad Leader<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Combat patrol<br /><br /><br />
		A mastermind of on-field construction, often regarded as the answer on whether the FOB succeeds or not, Squad Engineers are the people who construct the Forward Operating Base (FOB) and guard whatever threat that endangers the marines. In addition to this, they are also in charge of repairing power generators on the field as well as mining drills for requisitions. They have a high degree of engineering skill, meaning they can deploy and repair barricades faster than regular marines.
		<br /><br />
		<b>Duty</b>: Construct and reinforce the FOB that has been ordered by your acting Squad Leader, fix power generators and mining drills in the AO and stay on guard for any dangers that threaten your FOB.
	"}
	minimap_icon = "engi"

/datum/job/som/squad/engineer/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"\nYou have the equipment and skill to build fortifications, reroute power lines, and bunker down.
Your squaddies will look to you when it comes to construction in the field of battle."})

/datum/outfit/job/som/squad/engineer
	name = "SOM Engineer"
	jobtype = /datum/job/som/squad/engineer

	id = /obj/item/card/id/dogtag/som


/datum/job/som/squad/medic
	title = SOM_SQUAD_CORPSMAN
	paygrade = "SOM2"
	comm_title = "Med"
	total_positions = 16
	minimap_icon = "medic"
	skills_type = /datum/skills/combat_medic
	display_order = JOB_DISPLAY_ORDER_SQUAD_CORPSMAN
	outfit = /datum/outfit/job/som/squad/medic
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_REGULAR,
		/datum/job/som/squad/veteran = VETERAN_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Hard<br /><br />
		<b>You answer to the</b> acting Squad Leader<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Combat patrol<br /><br /><br />
		Corpsman are the vital line between life and death of a marine’s life should a marine be wounded in battle, if provided they do not run away. While marines treat themselves, it is the corpsmen who will treat injuries beyond what a normal person can do. With a higher degree of medical skill compared to a normal marine, they are capable of doing medical actions faster and reviving with defibrillators will heal more on each attempt. They can also perform surgery, in an event if there are no acting medical officers onboard.
		<br /><br />
		<b>Duty</b>: Tend the injuries of your fellow marines or related personnel, keep them at fighting strength.
	"}

datum/job/som/squad/medic/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"\nYou must tend the wounds of your squad mates and make sure they are healthy and active.
You may not be a fully-fledged doctor, but you stand between life and death when it matters."})

//AK
/datum/outfit/job/som/squad/medic
	name = "SOM Medic"
	jobtype = /datum/job/som/squad/medic

	id = /obj/item/card/id/dogtag/som


/datum/job/som/squad/veteran
	title = SOM_SQUAD_VETERAN
	paygrade = "SOM3"
	comm_title = "SGnr"
	total_positions = 8
	skills_type = /datum/skills/crafty //smarter than the average bear
	display_order = JOB_DISPLAY_ORDER_SQUAD_SMARTGUNNER
	minimap_icon = "smartgunner"
	outfit = /datum/outfit/job/som/squad/veteran
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS
	jobworth = list(/datum/job/xenomorph = LARVA_POINTS_REGULAR)
	html_description = {"
		<b>Difficulty</b>: Medium<br /><br />
		<b>You answer to the</b> acting Squad Leader<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Combat patrol<br /><br /><br />
		You are a seasoned veteran of the SOM. You have fought and bled for the cause, proving your self a true Son of Mars. As fitting reward for your service, you are entrusted with best arms and equipment the SOM can offer, and you are expected to serve as an example to your fellow soldier.
		<br /><br />
		<b>Duty</b>: Show your comrades how a true Son of Mars acts, and crush our enemies without mercy!.
	"}

/datum/job/som/squad/veteran/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"\nYou are the a Veteran among the SOM. With your long experience (and better training and equipment), your job is to provide special weapons support to bolster the line."})

/datum/outfit/job/som/squad/veteran
	name = "SOM Veteran"
	jobtype = /datum/job/som/squad/veteran
	id = /obj/item/card/id/dogtag/som

/datum/job/som/squad/leader
	title = SOM_SQUAD_LEADER
	req_admin_notify = TRUE
	paygrade = "SOM3"
	comm_title = JOB_COMM_TITLE_SQUAD_LEADER
	total_positions = 4
	supervisors = "the acting field commander"
	minimap_icon = "leader"
	skills_type = /datum/skills/sl
	display_order = JOB_DISPLAY_ORDER_SQUAD_LEADER
	outfit = /datum/outfit/job/som/squad/leader
	exp_requirements = XP_REQ_INTERMEDIATE
	exp_type = EXP_TYPE_REGULAR_ALL
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_BOLD_NAME_ON_SELECTION|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_REGULAR,
		/datum/job/som/squad/veteran = VETERAN_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Hard<br /><br />
		<b>You answer to the</b> acting Command Staff<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Combat patrol<br /><br /><br />
		Squad Leaders are basically the boss of any able-bodied squad. Though while they are not trained compared to engineers, corpsmen and smartgunners, they are (usually) capable of leading the squad. They can issue orders to bolster their soldiers, and are expected to confidentally lead them to victory.
		<br /><br />
		<b>Duty</b>: Be a responsible leader of your squad, make sure your squad communicates frequently all the time and ensure they are working together for the task at hand. Stay safe, as you’re a valuable leader.
	"}

/datum/job/som/squad/leader/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"\nYou are responsible for the men and women of your squad. Make sure they are on task, working together, and communicating.
You are also in charge of communicating with command and letting them know about the situation first hand. Keep out of harm's way."})

/datum/outfit/job/som/squad/leader
	name = "SOM Leader"
	jobtype = /datum/job/som/squad/leader

	id = /obj/item/card/id/dogtag/som

//ERT roles
/datum/job/som/ert
	access = ALL_ANTAGONIST_ACCESS
	minimal_access = ALL_ANTAGONIST_ACCESS
	skills_type = /datum/skills/crafty

//SOM Standard
/datum/job/som/ert/standard
	title = "SOM Standard"
	paygrade = "SOM1"
	outfit = /datum/outfit/job/som/ert/standard
	multiple_outfits = TRUE
	outfits = list(
		/datum/outfit/job/som/ert/standard,
		/datum/outfit/job/som/ert/standard/one,
	)

/datum/outfit/job/som/ert/standard
	name = "SOM Standard"
	jobtype = /datum/job/som/ert/standard

	id = /obj/item/card/id/dogtag/som
	belt = /obj/item/storage/belt/marine/som
	ears = /obj/item/radio/headset/distress/som
	w_uniform = /obj/item/clothing/under/som
	shoes = /obj/item/clothing/shoes/marine/som/knife
	wear_suit = /obj/item/clothing/suit/modular/som
	gloves = /obj/item/clothing/gloves/marine/som
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/modular/som/standard
	suit_store = /obj/item/weapon/gun/rifle/mpi_km/som
	r_store = /obj/item/storage/pouch/firstaid/som/full
	l_store = /obj/item/storage/pouch/pistol
	back = /obj/item/storage/backpack/lightpack/som

//AK
/datum/outfit/job/som/ert/standard/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/radio, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/crowbar/red, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/snacks/upp, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary/molotov, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary/molotov, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/m94, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/gauze, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/upp, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/upp, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/upp, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/stick, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km, SLOT_IN_BELT)

	H.equip_to_slot_or_del(new /obj/item/weapon/gun/revolver/upp, SLOT_IN_L_POUCH)

//Charger
/datum/outfit/job/som/ert/standard/one
	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/charger/magharness

/datum/outfit/job/som/ert/standard/one/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	H.equip_to_slot_or_del(new /obj/item/radio, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/crowbar/red, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/snacks/upp, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary/molotov, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary/molotov, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/m94, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/gauze, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/upp, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/upp, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/upp, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/stick, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BELT)

	H.equip_to_slot_or_del(new /obj/item/weapon/gun/revolver/upp, SLOT_IN_L_POUCH)

//SOM Medic
/datum/job/som/ert/medic
	title = "SOM Medic"
	paygrade = "SOM2"
	skills_type = /datum/skills/combat_medic/crafty
	outfit = /datum/outfit/job/som/ert/medic
	multiple_outfits = TRUE
	outfits = list(
		/datum/outfit/job/som/ert/medic,
		/datum/outfit/job/som/ert/medic/one,
	)

//AK
/datum/outfit/job/som/ert/medic
	name = "SOM Medic"
	jobtype = /datum/job/som/ert/medic

	id = /obj/item/card/id/dogtag/som
	belt = /obj/item/storage/belt/lifesaver/som/ert
	ears = /obj/item/radio/headset/distress/som
	w_uniform = /obj/item/clothing/under/som/medic/vest
	shoes = /obj/item/clothing/shoes/marine/som/knife
	wear_suit = /obj/item/clothing/suit/modular/som
	gloves = /obj/item/clothing/gloves/marine/som
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/modular/som/medic
	glasses = /obj/item/clothing/glasses/hud/health
	suit_store = /obj/item/weapon/gun/rifle/mpi_km/som
	r_store = /obj/item/storage/pouch/medical_injectors/medic
	l_store = /obj/item/storage/pouch/magazine/large
	back = /obj/item/storage/backpack/lightpack/som

/datum/outfit/job/som/ert/medic/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()

	H.equip_to_slot_or_del(new /obj/item/defibrillator, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/healthanalyzer, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/radio, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/crowbar/red, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/m94, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/advanced/meraderm, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/snacks/upp, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km, SLOT_IN_L_POUCH)

//Charger
/datum/outfit/job/som/ert/medic/one
	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/charger/magharness

/datum/outfit/job/som/ert/medic/one/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	H.equip_to_slot_or_del(new /obj/item/defibrillator, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/healthanalyzer, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/radio, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/crowbar/red, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/m94, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/advanced/meraderm, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/snacks/upp, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_L_POUCH)

//SOM Veteran
/datum/job/som/ert/veteran
	title = "SOM Veteran"
	paygrade = "SOM3"
	outfit = /datum/outfit/job/som/ert/veteran
	multiple_outfits = TRUE
	outfits = list(
		/datum/outfit/job/som/ert/veteran,
		/datum/outfit/job/som/ert/veteran/one,
		/datum/outfit/job/som/ert/veteran/two,
		/datum/outfit/job/som/ert/veteran/three,
	)

//Charger
/datum/outfit/job/som/ert/veteran
	name = "SOM Veteran"
	jobtype = /datum/job/som/ert/veteran

	id = /obj/item/card/id/dogtag/som
	belt = /obj/item/storage/belt/marine/som
	ears = /obj/item/radio/headset/distress/som
	w_uniform = /obj/item/clothing/under/som/veteran/highpower
	shoes = /obj/item/clothing/shoes/marine/som/knife
	wear_suit = /obj/item/clothing/suit/modular/som/heavy
	gloves = /obj/item/clothing/gloves/marine/som/veteran
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/modular/som/veteran/vet
	glasses = /obj/item/clothing/glasses/meson
	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/charger/somvet
	r_store = /obj/item/storage/pouch/grenade
	l_store = /obj/item/storage/pouch/firstaid/som/full
	back = /obj/item/storage/backpack/lightpack/som

/datum/outfit/job/som/veteran/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/small_stack, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/radio, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/crowbar/red, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/m94, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/highpower, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/highpower, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/binoculars, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BELT)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/m15, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/m15, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_R_POUCH)

//Caliver
/datum/outfit/job/som/ert/veteran/one
	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/caliver/somvet

/datum/outfit/job/som/ert/veteran/one/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	H.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/small_stack, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/radio, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/crowbar/red, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/m94, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/highpower, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/highpower, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/binoculars, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite/highcap, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite/highcap, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite/highcap, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite/highcap, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite/highcap, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite/highcap, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite/highcap, SLOT_IN_BELT)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/m15, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/m15, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_R_POUCH)

//Caliver and powerpack
/datum/outfit/job/som/ert/veteran/two
	w_uniform = /obj/item/clothing/under/som/veteran/webbing_vet
	belt = /obj/item/weapon/gun/shotgun/double/sawn
	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/caliver/somvet
	back = /obj/item/cell/lasgun/volkite/powerpack

/datum/outfit/job/som/ert/veteran/two/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/m15, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/m15, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_R_POUCH)

//Culverin - bringing the big guns
/datum/outfit/job/som/ert/veteran/three
	w_uniform = /obj/item/clothing/under/som/veteran/webbing_vet
	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/culverin/magharness
	belt = /obj/item/weapon/gun/shotgun/double/sawn
	back = /obj/item/cell/lasgun/volkite/powerpack

/datum/outfit/job/som/ert/veteran/three/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/m15, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/m15, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_R_POUCH)


//SOM Leader
/datum/job/som/ert/leader
	job_category = JOB_CAT_COMMAND
	title = "SOM Leader"
	paygrade = "SOM3"
	skills_type = /datum/skills/sl
	outfit = /datum/outfit/job/som/ert/leader
	multiple_outfits = TRUE
	outfits = list(
		/datum/outfit/job/som/ert/leader,
		/datum/outfit/job/som/ert/leader/one,
		/datum/outfit/job/som/ert/leader/two,
	)

//Charger
/datum/outfit/job/som/ert/leader
	name = "SOM Leader"
	jobtype = /datum/job/som/ert/leader

	id = /obj/item/card/id/dogtag/som
	belt = /obj/item/storage/belt/marine/som
	ears = /obj/item/radio/headset/distress/som
	w_uniform = /obj/item/clothing/under/som/leader/highpower
	shoes = /obj/item/clothing/shoes/marine/som/knife
	wear_suit = /obj/item/clothing/suit/modular/som/heavy/leader/valk
	gloves = /obj/item/clothing/gloves/marine/som/veteran
	mask = /obj/item/clothing/mask/gas
	head = /obj/item/clothing/head/modular/som/veteran/leader
	glasses = /obj/item/clothing/glasses/hud/health
	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/charger/somvet
	r_store = /obj/item/storage/pouch/grenade
	l_store = /obj/item/storage/pouch/magazine/large
	back = /obj/item/storage/backpack/lightpack/som


/datum/outfit/job/som/ert/leader/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/large_stack, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/radio, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/crowbar/red, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/m94, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/binoculars, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/attachable/motiondetector, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/highpower, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/highpower, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/snacks/enrg_bar, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_BELT)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/m15, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/m15, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_R_POUCH)

	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite, SLOT_IN_L_POUCH)

//Caliver
/datum/outfit/job/som/ert/leader/one
	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/caliver/somvet


/datum/outfit/job/som/ert/leader/one/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	H.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/large_stack, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/radio, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/crowbar/red, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/m94, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/binoculars, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/attachable/motiondetector, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/highpower, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/highpower, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/snacks/enrg_bar, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite/highcap, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite/highcap, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite/highcap, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite/highcap, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite/highcap, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite/highcap, SLOT_IN_BELT)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/m15, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/m15, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_R_POUCH)

	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite/highcap, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite/highcap, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/cell/lasgun/volkite/highcap, SLOT_IN_L_POUCH)

//Caliver and powerpack
/datum/outfit/job/som/ert/leader/two
	w_uniform = /obj/item/clothing/under/som/leader/webbing
	suit_store = /obj/item/weapon/gun/energy/lasgun/lasrifle/volkite/caliver/tacsensor
	belt = /obj/item/belt_harness
	back = /obj/item/cell/lasgun/volkite/powerpack
	l_store = /obj/item/storage/pouch/general/large

/datum/outfit/job/som/ert/leader/two/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)

	H.equip_to_slot_or_del(new /obj/item/binoculars, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/tool/crowbar/red, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/radio, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/standard_pocketpistol, SLOT_IN_ACCESSORY)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/smokebomb, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/m15, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/m15, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary, SLOT_IN_R_POUCH)

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/standard_pocketpistol, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/standard_pocketpistol, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/standard_pocketpistol, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/snacks/enrg_bar, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_L_POUCH)
