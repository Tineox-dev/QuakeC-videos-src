/*  Copyright (C) 1996-1997  Id Software, Inc.

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
*/

$cd id1/models/soldier4
$origin 0 -6 24
$base base
$skin skin

$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8

$frame death1 death2 death3 death4 death5 death6 death7 death8
$frame death9 death10

$frame deathc1 deathc2 deathc3 deathc4 deathc5 deathc6 deathc7 deathc8
$frame deathc9 deathc10 deathc11

$frame load1 load2 load3 load4 load5 load6 load7 load8 load9 load10 load11

$frame pain1 pain2 pain3 pain4 pain5 pain6

$frame painb1 painb2 painb3 painb4 painb5 painb6 painb7 painb8 painb9 painb10
$frame painb11 painb12 painb13 painb14

$frame painc1 painc2 painc3 painc4 painc5 painc6 painc7 painc8 painc9 painc10 painc11
$frame painc12 painc13

$frame run1 run2 run3 run4 run5 run6 run7 run8

$frame shoot1 shoot2 shoot3 shoot4 shoot5 shoot6 shoot7 shoot8 shoot9

$frame prowl_1 prowl_2 prowl_3 prowl_4 prowl_5 prowl_6 prowl_7 prowl_8 prowl_9 prowl_10 prowl_11 prowl_12 prowl_13 prowl_14 prowl_15 prowl_16
$frame prowl_17 prowl_18 prowl_19 prowl_20 prowl_21 prowl_22 prowl_23 prowl_24

/*
=================================================
	SOLDIER2_CODE
=================================================
*/

void() SoldMissileExplosion = 
{
	self.movetype = MOVETYPE_NONE;
	self.velocity = '0 0 0';
	self.touch = SUB_Null;
	setmodel (self, "progs/s_explod.spr");
	self.solid = SOLID_NOT;
	s_explode1 ();
};

void() T_SoldMissileTouch = 
{
	local float damg;
	
	if(pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}
	
	damg = 20 + random()*20;
	
	// daño por directo
	T_RadiusDamage(self, self.owner, damg, self);
	
	//daño en area
	T_RadiusDamage(self, self.owner, 120, other);
	
//===============================================
//	EFECTOS
	
	self.origin = self.origin - 8*normalize(self.velocity);
	
	WriteByte(MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte(MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord(MSG_BROADCAST, self.origin_x);
	WriteCoord(MSG_BROADCAST, self.origin_y);
	WriteCoord(MSG_BROADCAST, self.origin_z);

//===============================================

	SoldMissileExplosion();

};

// FUNCIÓN DE SPAWN + DIRECCIÓN
void() SoldRocket = 
{
	local entity missile;
	
	sound (self, CHAN_WEAPON, "weapons/grenade.wav", 1, ATTN_IDLE);
	
	missile = spawn();
	missile.owner = self;
	missile.movetype = MOVETYPE_FLYMISSILE;
	missile.solid = SOLID_BBOX;
	missile.classname = "missile";
	
//	ángulo del misil + velocidad + dirección + spawn

	missile.velocity = normalize(self.enemy.origin - self.origin);
	missile.velocity = missile.velocity * 1000;
	missile.angles = vectoangles(missile.velocity);
//	:D

	missile.touch = T_SoldMissileTouch;
	
	missile.nextthink  = time + 5;
	missile.think = SUB_Remove;

	setmodel(missile, "progs/missile.mdl");
	setsize(missile, '0 0 0', '0 0 0' );
	makevectors(self.angles);
	setorigin (missile, self.origin + v_forward * 30 + v_right * 5 + '0 0 12');
};

void()	army2_stand1	=[	$stand1,	army2_stand2	]{ai_stand();};
void()	army2_stand2	=[	$stand2,	army2_stand3	] {ai_stand();};
void()	army2_stand3	=[	$stand3,	army2_stand4	] {ai_stand();};
void()	army2_stand4	=[	$stand4,	army2_stand5	] {ai_stand();};
void()	army2_stand5	=[	$stand5,	army2_stand6	] {ai_stand();};
void()	army2_stand6	=[	$stand6,	army2_stand7	] {ai_stand();};
void()	army2_stand7	=[	$stand7,	army2_stand8	] {ai_stand();};
void()	army2_stand8	=[	$stand8,	army2_stand1	] {ai_stand();};

void() army2_walk1 	=[	$prowl_1,	army2_walk2	]
{
	if(random() < 0.2)
		sound (self, CHAN_VOICE, "soldier/idle.wav", 1, ATTN_IDLE);
	ai_walk(1);
};

void()	army2_walk2	=[	$prowl_2,	army2_walk3	] {ai_walk(1);};
void()	army2_walk3	=[	$prowl_3,	army2_walk4	] {ai_walk(1);};
void()	army2_walk4	=[	$prowl_4,	army2_walk5	] {ai_walk(1);};
void()	army2_walk5	=[	$prowl_5,	army2_walk6	] {ai_walk(2);};
void()	army2_walk6	=[	$prowl_6,	army2_walk7	] {ai_walk(3);};
void()	army2_walk7	=[	$prowl_7,	army2_walk8	] {ai_walk(4);};
void()	army2_walk8	=[	$prowl_8,	army2_walk9	] {ai_walk(4);};
void()	army2_walk9	=[	$prowl_9,	army2_walk10	] {ai_walk(2);};
void()	army2_walk10	=[	$prowl_10,	army2_walk11	] {ai_walk(2);};
void()	army2_walk11	=[	$prowl_11,	army2_walk12	] {ai_walk(2);};
void()	army2_walk12	=[	$prowl_12,	army2_walk13	] {ai_walk(1);};
void()	army2_walk13	=[	$prowl_13,	army2_walk14	] {ai_walk(0);};
void()	army2_walk14	=[	$prowl_14,	army2_walk15	] {ai_walk(1);};
void()	army2_walk15	=[	$prowl_15,	army2_walk16	] {ai_walk(1);};
void()	army2_walk16	=[	$prowl_16,	army2_walk17	] {ai_walk(1);};
void()	army2_walk17	=[	$prowl_17,	army2_walk18	] {ai_walk(3);};
void()	army2_walk18	=[	$prowl_18,	army2_walk19	] {ai_walk(3);};
void()	army2_walk19	=[	$prowl_19,	army2_walk20	] {ai_walk(3);};
void()	army2_walk20	=[	$prowl_20,	army2_walk21	] {ai_walk(3);};
void()	army2_walk21	=[	$prowl_21,	army2_walk22	] {ai_walk(2);};
void()	army2_walk22	=[	$prowl_22,	army2_walk23	] {ai_walk(1);};
void()	army2_walk23	=[	$prowl_23,	army2_walk24	] {ai_walk(1);};
void()	army2_walk24	=[	$prowl_24,	army2_walk1	] {ai_walk(1);};

void() army2_run1	=[	$run1,	army2_run2	]
{
	if(random()<0.2)
		sound(self,CHAN_VOICE, "soldier/idle.wav",1,ATTN_IDLE);
	ai_run(11);
};

void()	army2_run2	=[	$run2,		army2_run3	] {ai_run(15);};
void()	army2_run3	=[	$run3,		army2_run4	] {ai_run(10);};
void()	army2_run4	=[	$run4,		army2_run5	] {ai_run(10);};
void()	army2_run5	=[	$run5,		army2_run6	] {ai_run(8);};
void()	army2_run6	=[	$run6,		army2_run7	] {ai_run(15);};
void()	army2_run7	=[	$run7,		army2_run8	] {ai_run(10);};
void()	army2_run8	=[	$run8,		army2_run1	] {ai_run(8);};

//==============================================================
//	ATAQUE_START
//==============================================================

void() army2_atk1	=[	$shoot1,	army2_atk2	]{ai_face();};
void() army2_atk2	=[	$shoot2,	army2_atk3	]{ai_face();};
void() army2_atk3	=[	$shoot3,	army2_atk4	]{ai_face();};
void() army2_atk4	=[	$shoot4,	army2_atk5	]{ai_face();};
//==================================
void() army2_atk5	=[	$shoot5,	army2_atk6	]
{
	ai_face();
	SoldRocket();
	self.effects = self.effects | EF_MUZZLEFLASH;
};
void() army2_atk6	=[	$shoot6,	army2_atk7	]{ai_face();};
void() army2_atk7	=[	$shoot7,	army2_atk8	]{ai_face(); SUB_CheckRefire(army2_atk1);};
void() army2_atk8	=[	$shoot8,	army2_atk9	]{ai_face();};
void() army2_atk9	=[	$shoot9,	army2_atk10	]{ai_face();};
//==================================
void() army2_atk10	=[	$shoot5,	army2_atk11	]
{
	ai_face();
	SoldRocket();
	self.effects = self.effects | EF_MUZZLEFLASH;
};
void() army2_atk11	=[	$shoot6,	army2_atk12	]{ai_face();};
void() army2_atk12	=[	$shoot7,	army2_atk13	]{ai_face(); SUB_CheckRefire(army2_atk1);};
void() army2_atk13	=[	$shoot8,	army2_atk14	]{ai_face();};
void() army2_atk14	=[	$shoot9,	army2_atk15	]{ai_face();};
//==================================
void() army2_atk15	=[	$shoot5,	army2_atk16	]
{
	ai_face();
	SoldRocket();
	self.effects = self.effects | EF_MUZZLEFLASH;
};
void() army2_atk16	=[	$shoot6,	army2_atk17	]{ai_face();};
void() army2_atk17	=[	$shoot7,	army2_atk18	]{ai_face(); SUB_CheckRefire(army2_atk1);};
void() army2_atk18	=[	$shoot8,	army2_atk19	]{ai_face();};
void() army2_atk19	=[	$shoot9,	army2_run1	]{ai_face();};
//==============================================================
//	ATAQUE_END
//==============================================================

void()	army2_pain1	=[	$pain1,		army2_pain2	] {};
void()	army2_pain2	=[	$pain2,		army2_pain3	] {};
void()	army2_pain3	=[	$pain3,		army2_pain4	] {};
void()	army2_pain4	=[	$pain4,		army2_pain5	] {};
void()	army2_pain5	=[	$pain5,		army2_pain6	] {};
void()	army2_pain6	=[	$pain6,		army2_run1	] {ai_pain(1);};

void()	army2_painb1	=[	$painb1,	army2_painb2	] {};
void()	army2_painb2	=[	$painb2,	army2_painb3	] {ai_painforward(13);};
void()	army2_painb3	=[	$painb3,	army2_painb4	] {ai_painforward(9);};
void()	army2_painb4	=[	$painb4,	army2_painb5	] {};
void()	army2_painb5	=[	$painb5,	army2_painb6	] {};
void()	army2_painb6	=[	$painb6,	army2_painb7	] {};
void()	army2_painb7	=[	$painb7,	army2_painb8	] {};
void()	army2_painb8	=[	$painb8,	army2_painb9	] {};
void()	army2_painb9	=[	$painb9,	army2_painb10] {};
void()	army2_painb10=[	$painb10,	army2_painb11] {};
void()	army2_painb11=[	$painb11,	army2_painb12] {};
void()	army2_painb12=[	$painb12,	army2_painb13] {ai_pain(2);};
void()	army2_painb13=[	$painb13,	army2_painb14] {};
void()	army2_painb14=[	$painb14,	army2_run1	] {};

void()	army2_painc1	=[	$painc1,	army2_painc2	] {};
void()	army2_painc2	=[	$painc2,	army2_painc3	] {ai_pain(1);};
void()	army2_painc3	=[	$painc3,	army2_painc4	] {};
void()	army2_painc4	=[	$painc4,	army2_painc5	] {};
void()	army2_painc5	=[	$painc5,	army2_painc6	] {ai_painforward(1);};
void()	army2_painc6	=[	$painc6,	army2_painc7	] {ai_painforward(1);};
void()	army2_painc7	=[	$painc7,	army2_painc8	] {};
void()	army2_painc8	=[	$painc8,	army2_painc9	] {ai_pain(1);};
void()	army2_painc9	=[	$painc9,	army2_painc10] {ai_painforward(4);};
void()	army2_painc10=[	$painc10,	army2_painc11] {ai_painforward(3);};
void()	army2_painc11=[	$painc11,	army2_painc12] {ai_painforward(6);};
void()	army2_painc12=[	$painc12,	army2_painc13] {ai_painforward(8);};
void()	army2_painc13=[	$painc13,	army2_run1] {};

void(entity attacker, float damage) sold_pain = 
{
	local float r;
	
	if(self.pain_finished > time)
		return;
	
	r = random();
	
	if(r < 0.2)
	{
		self.pain_finished = time + 0.6;
		army2_pain1();
		sound(self,CHAN_VOICE,"soldier/pain2.wav",1,ATTN_NORM);
	}
	else if(r < 0.6)
	{
		self.pain_finished = time + 1.1;
		army2_painb1();
		sound(self,CHAN_VOICE,"soldier/pain1.wav",1,ATTN_NORM);
	}
	else
	{
		self.pain_finished = time + 1.1;
		army2_painc1();
		sound(self,CHAN_VOICE,"soldier/pain2.wav",1,ATTN_NORM);
	}
};

void()	army2_die1	=[	$death1,	army2_die2	] {};
void()	army2_die2	=[	$death2,	army2_die3	] {};
void()	army2_die3	=[	$death2,	army2_die4	]
{
	self.solid = SOLID_NOT;
	self.ammo_rockets = 10;
	DropBackpack();
};
void()	army2_die4	=[	$death4,	army2_die5	] {};
void()	army2_die5	=[	$death5,	army2_die6	] {};
void()	army2_die6	=[	$death6,	army2_die7	] {};
void()	army2_die7	=[	$death7,	army2_die8	] {};
void()	army2_die8	=[	$death8,	army2_die9	] {};
void()	army2_die9	=[	$death9,	army2_die10	] {};
void()	army2_die10	=[	$death10,	army2_die10	] {};

void()	army2_cdie1	=[	$deathc1,	army2_cdie2	] {};
void()	army2_cdie2	=[	$deathc2,	army2_cdie3	] {ai_back(5);};
void()	army2_cdie3	=[	$deathc3,	army2_cdie4	]
{
	self.solid = SOLID_NOT;
	self.ammo_rockets = 10;
	DropBackpack();
	ai_back(4);
};
void()	army2_cdie4	=[	$deathc4,	army2_cdie5	] {ai_back(13);};
void()	army2_cdie5	=[	$deathc5,	army2_cdie6	] {ai_back(3);};
void()	army2_cdie6	=[	$deathc6,	army2_cdie7	] {ai_back(4);};
void()	army2_cdie7	=[	$deathc7,	army2_cdie8	] {};
void()	army2_cdie8	=[	$deathc8,	army2_cdie9	] {};
void()	army2_cdie9	=[	$deathc9,	army2_cdie10	] {};
void()	army2_cdie10	=[	$deathc10,	army2_cdie11	] {};
void()	army2_cdie11	=[	$deathc11,	army2_cdie11	] {};

void() sold_die =
{
	// explosion
	if(self.health < -35)
	{
		sound(self,CHAN_VOICE,"player/udeath.wav",1,ATTN_NORM);
		ThrowHead ("progs/h_guard.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		return;
	}
	
	// normal
	sound(self,CHAN_VOICE,"soldier/death1.wav",1,ATTN_NORM);
	if(random()<0.5)
	{
		army2_die1();
	}
	else
	{
		army2_cdie1();
	}
};

void() monster_army2 =
{
	if(deathmatch)
	{
		remove(self);
		return;
	}
	
	precache_model ("progs/rocket_soldier.mdl");
	precache_model ("progs/h_guard.mdl");
	precache_model ("progs/gib1.mdl");
	precache_model ("progs/gib2.mdl");
	precache_model ("progs/gib3.mdl");

	precache_sound ("soldier/death1.wav");
	precache_sound ("soldier/idle.wav");
	precache_sound ("soldier/pain1.wav");
	precache_sound ("soldier/pain2.wav");
	precache_sound ("soldier/sattck1.wav");
	precache_sound ("soldier/sight1.wav");
	precache_sound ("player/udeath.wav");
	
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	
	setmodel(self,"progs/rocket_soldier.mdl");
	setsize(self, '-16 -16 -24', '16 16 40');
	self.health = 30;
	
	self.th_stand = army2_stand1;
	self.th_walk = army2_walk1;
	self.th_run = army2_run1;
	self.th_missile = army2_atk1;
	self.th_pain = sold_pain;
	self.th_die = sold_die;
	
	walkmonster_start();
};