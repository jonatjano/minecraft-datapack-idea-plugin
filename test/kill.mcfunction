kill @a
kill jonatjano

kill @a
kill @e
kill @p
kill @r
kill @s

kill @e[distance=10]
kill @e[distance=8..16]

kill @e[x=1,dx=4,y=2,dy=5,z=3,dz=6]
kill @e[x=1,y=2,z=3,dx=0,dy=0,dz=0]
kill @e[x=1,dx=4,y=2,dy=5,z=3,dz=6]
kill @e[x=1,y=2,z=30,dx=0,dy=0,dz=0]

kill @e[scores={myscore=10}]
kill @e[scores={myscore=10..12}]
kill @e[scores={myscore=5..}]
kill @e[scores={myscore=..15}]
kill @e[scores={foo=10,bar=1..5}]

kill @e[tag=string]
kill @e[tag=!string]
kill @e[tag=]
kill @e[tag=!]

kill @e[team=teamName]
kill @e[team=!teamName]
kill @e[team=]
kill @e[team=!]

kill @a[limit=3,sort=nearest]
kill @p[limit=3]
kill @a[limit=4,sort=furthest]
kill @a[limit=2,sort=random]
kill @a[limit=2,sort=arbitrary]
kill @r[limit=2]

kill @a[level=10]
kill @a[level=8..16]

kill @a[gamemode=spectator]
kill @a[gamemode=!spectator]
kill @a[gamemode=survival]
kill @a[gamemode=!survival]
kill @a[gamemode=creative]
kill @a[gamemode=!creative]
kill @a[gamemode=adventure]
kill @a[gamemode=!adventure]

kill @e[name=jano]
kill @e[name=!jano]

kill @e[x_rotation=0]
kill @e[x_rotation=30..60]
kill @e[x_rotation=..0]

kill @e[y_rotation=0]
kill @e[y_rotation=-90..0]
kill @e[y_rotation=0..180]

kill @e[type=zombie]
kill @e[type=!zombie]
kill @e[type=minecraft:zombie]
kill @e[type=!minecraft:zombie]

kill @a[nbt={OnGround:true}]
kill @e[type=sheep,nbt={Color:0b}]
kill @e[type=item,nbt={Item:{id:"minec\\raft:sl\"ime_ball"}}]
kill @e[nbt={Tags:["a",b]}]
kill @e[tag=a,tag=b]

kill @a[advancements={story/smelt_iron=true}]
kill @a[advancements={story/form_obsidian=false}]
kill @a[advancements={story/follow_ender_eye=true}]
kill @a[advancements={story/follow_ender_eye={in_stronghold=true}}]
kill @a[advancements={adventure/kill_all_mobs={witch=true}}]

kill @e[predicate=minecraft:fake_predicate]
kill @e[predicate=!minecraft:fake_predicate]
kill @e[predicate=fake_predicate]
kill @e[predicate=!fake_predicate]
